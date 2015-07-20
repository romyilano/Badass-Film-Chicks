#import "BFCController.h"
#import <Parse/Parse.h>
#import <Mantle/Mantle.h>
#import "Constants.h"
#import "Film.h"
#import "NSString+URLEncoding.h"

NSString *BFCControllerDomain = @"GuidebookControllerDomain";

@interface BFCController()
@property (strong, nonatomic) PFRelation *directorRelation;
@property (strong, nonatomic) PFRelation *friendRelation;
@end

@implementation BFCController

// singleton
+ (instancetype)shared {
    static id _shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}
#pragma mark - accessor

- (void)setFavoriteDirectors:(NSArray *)favoriteDirectors {
    if (![favoriteDirectors isEqualToArray:self.favoriteDirectors]) {
        favoriteDirectors = self.favoriteDirectors;
    }
}

#pragma mark - Parse IOS API Specific

- (void)refreshCurrentFavoriteDirectorsOfCurrentUser {
    [self getCurrentUserFreshListUsersFavoriteDirectors:^(NSArray *directors, NSError *error) {
        if (!error) {
            [self setFavoriteDirectors:directors];
        }
    }];
}

- (void)getCurrentUserFreshListUsersFavoriteDirectors:(void (^)(NSArray *, NSError *))completionBlock {
    if (completionBlock) {
        [self getFreshListUsersFavoriteDirectors:[PFUser currentUser]
                             withCompletionBlock:completionBlock];
    }
}

- (void)getFreshListUsersFavoriteDirectors:(PFUser *)user withCompletionBlock:(void (^)(NSArray *, NSError *))completionBlock {
    if (completionBlock && user) {
        self.directorRelation = [user relationForKey:kParseUserClassDirectorRelationKey];
        PFQuery *relationQuery = [self.directorRelation query];
        [relationQuery orderByAscending:kParseDirectorLastNameClassKey];
        [relationQuery findObjectsInBackgroundWithBlock:^(NSArray * __nullable objects, NSError * __nullable error) {
            if (!error) {
                completionBlock(objects, nil);
            } else {
                completionBlock(@[], error);
            }
        }];
    }
}

- (void)loadFavoriteDirectorsBackgroundWithParseIOSAPI:(void (^)(NSArray *, NSError *))completionBlock {
    if (![PFUser currentUser] || !(completionBlock)) {
        return;
    }
    
    PFRelation *relation = [[PFUser currentUser] objectForKey:@"directorRelation"];
    PFQuery *relationQuery = [relation query];
    [relationQuery orderByAscending:@"lastName"];
    [relationQuery findObjectsInBackgroundWithBlock:^(NSArray * __nullable objects, NSError * __nullable error) {
        if (!error && objects.count > 0) {
            // array of favorite directors
            completionBlock(objects, error);
        } else {
            completionBlock(@[], error);
        }
    }];
}

- (void)loadDirectorsInBackgroundFromParseiOSAPI:(void (^)(NSArray *, NSError *))completionBlock {
    PFQuery *query = [PFQuery queryWithClassName:kParseDirectorClassKey];
    [query orderByAscending:kParseDirectorLastNameClassKey];
    [query findObjectsInBackgroundWithBlock:^(NSArray * __nullable objects, NSError * __nullable error) {
        if (completionBlock) {
            completionBlock(objects, error);
        }
    }];
}


- (void)loadFilmsInBackgroundFromParseiOSAPI:(void (^)(NSArray *, NSError *))completionBlock {
    PFQuery *query = [PFQuery queryWithClassName:kParseFilmClassKey];
    [query orderByAscending:@"film"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * __nullable objects, NSError * __nullable error) {
        if (completionBlock) {
            completionBlock(objects, error);
        }
    }];
}

#pragma mark - REST API Specific

- (void)loadMovieFromSource:(RESTAPISource)restAPISource
                  movieName:(NSString *)movieName
        withCompletionBlock:(void (^)(NSDictionary *, NSError *))completionBlock {
    
    if (movieName == nil || movieName.length == 0) {
        return;
    }
    
    if (completionBlock) {
        if (restAPISource == RESTAPISourceOpenMovieDB) {
           //  [self loadMovieFromOpenMovieDBByName:movieName withCompletionBlock:completionBlock];
           //  [self loadMovieFromOpenMovieDBByName:movieName withCompletionBlock:completionBlock];
        }
    }
}

- (void)loadListFilms:(RESTAPISource)restAPISource withOptions:(NSDictionary *)options andCompletionBlock:(void (^)(NSArray *, NSError *))completionBlock {
    if (!completionBlock || !restAPISource) {
        NSLog(@"Missing completion block / api source");
        return;
    }
    
    if (restAPISource == RESTAPISourceParse) {
        [self loadParseFilmsWithOptions:options andCompletionBlock:completionBlock];
    }
}

#pragma mark - OpenMovie DBB

- (void)loadMovieFromOpenMovieDBByName:(NSString *)movieName
                   withCompletionBlock:(void (^)(Film *, NSError *))completionBlock {
    // http://www.omdbapi.com?plot=long&r=json&i=tt0060959
    
    NSError *finalError = nil;
    NSString *urlEncodedMovieName = [movieName URLEncodedString];
    NSString *urlSuffix = [NSString stringWithFormat:@"?t=%@&plot=short&r=json", urlEncodedMovieName]; // ?t=hunger+games&plot=short&r=json
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kOpenMDBAPIBaseURL, urlSuffix]];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // Parse requires HTTP headers for authentication. Set them before creating your NSURLSession
    [config setHTTPAdditionalHeaders:@{@"Content-Type": @"application/json"}];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {
                                                    // todo error handling
                                                    
                                                    
                                                    if (!error && completionBlock) {
                                                        
                                                        NSLog(@"respnose: %@", response);
                                                        
                                                        // check to see if there's a response
                                                        NSDictionary *filmDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                                        if (![filmDict[@"Error"] isEqualToString:@"Movie not found!"]) {
                                                            // it has to be on the main treahd?
                                                            Film *film = [MTLJSONAdapter modelOfClass:[Film class] fromJSONDictionary:filmDict error:nil];
                                                            NSLog(@"this mantle film better facking work %@", film);
                                                            if (!finalError) {
                                                                completionBlock(film, nil);
                                                            } else {
                                                                completionBlock(nil, finalError);
                                                            }
                                                        } else {
                                                            completionBlock(nil, [NSError errorWithDomain:BFCControllerDomain
                                                                                                     code:BFCControllerErrorOMDBMovieNotFound
                                                                                                 userInfo:@{NSLocalizedDescriptionKey : @"OMDB says sorry girllllfriend, your title ain't inside me"}]);
                                                        }
                                                    }
                                                }];
    [dataTask resume];}

- (void)loadMovieFromOpenMovieDBByIMDBID:(NSString *)imdbID withCompletionBlock:(void (^)(Film *, NSError *))completionBlock {
    // http://www.omdbapi.com?plot=long&r=json&i=tt0060959
    NSString *urlSuffix = [NSString stringWithFormat:@"?plot=long&r=json&i=%@",imdbID];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kOpenMDBAPIBaseURL, urlSuffix]];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // Parse requires HTTP headers for authentication. Set them before creating your NSURLSession
    [config setHTTPAdditionalHeaders:@{@"Content-Type": @"application/json"}];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {
                                                    // todo error handling
                                                    NSError *finalError = nil;
                                                    if (!error && completionBlock) {
                                                        // check to see if there's a response
                                                        NSDictionary *filmDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                                        
                                                        if (![filmDict[@"Error"] isEqualToString:@"Movie not found!"]) {
                                                            // it has to be on the main treahd?
                                                            Film *film = [MTLJSONAdapter modelOfClass:[Film class] fromJSONDictionary:filmDict error:nil];
                                                            NSLog(@"this mantle film better facking work %@", film);
                                                            if (!finalError) {
                                                                completionBlock(film, nil);
                                                            } else {
                                                                completionBlock(nil, finalError);
                                                            }
                                                        } else {
                                                            completionBlock(nil, [NSError errorWithDomain:BFCControllerDomain
                                                                                                     code:BFCControllerErrorOMDBMovieNotFound
                                                                                                 userInfo:@{NSLocalizedDescriptionKey : @"OMDB says sorry girllllfriend, your title ain't inside me"}]);
                                                        }

                                                    } else {
                                                        completionBlock(nil, error);
                                                    }
                                                    
                                                }];
    [dataTask resume];
    
}

#pragma mark - REST API Parse

- (void)loadParseFilmsWithOptions:(NSDictionary *)options
               andCompletionBlock:(void(^)(NSArray *films, NSError *error))completionBlock {
    if (!completionBlock) {
        NSLog(@"Missing completion block / api source");
        return;
    }
    
    // todo - options
    
    // 1
    NSURL *url = [NSURL URLWithString:@"https://api.parse.com/1/classes/Film"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // Parse requires HTTP headers for authentication. Set them before creating your NSURLSession
    [config setHTTPAdditionalHeaders:@{@"X-Parse-Application-Id":kParseApplicationId,
                                       @"X-Parse-REST-API-Key":kParseRESTAPIKey,
                                       @"Content-Type": @"application/json"}];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {
        
        if (!error) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:nil];
            NSArray *results = json[@"results"];
            completionBlock(results, nil);
        }
    }];
    
    [dataTask resume];
    
}

#pragma mark - Hacks for updating the database on Parse

- (PFObject *)copyNewObj:(PFObject *)copyFromObj newClassName:(NSString *)newClassName {
    if (copyFromObj == nil) {
        return  nil;
    }
    NSArray *origKeys = [copyFromObj allKeys];
    __block PFObject *newObj = [PFObject objectWithClassName:newClassName];
    
    for (NSString *key in origKeys) {
        if (copyFromObj[key]) {
            [newObj setObject:copyFromObj[key] forKeyedSubscript:key];
        }
    }
    return newObj;
}

@end
