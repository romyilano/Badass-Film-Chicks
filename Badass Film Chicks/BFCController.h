#import <Foundation/Foundation.h>
#import "Constants.h"

@class Film, PFUser;
@interface BFCController : NSObject

@property (strong, nonatomic) NSArray *favoriteDirectors;
@property (strong, nonatomic) NSArray *friends;

+ (instancetype)shared;

#pragma mark - Parse iOS API Specific
#pragma mark - Update Friends and Favorites

- (void)refreshCurrentFavoriteDirectorsOfCurrentUser;

- (void)getCurrentUserFreshListUsersFavoriteDirectors:(void(^)(NSArray *directors, NSError *error))completionBlock;

- (void)getFreshListUsersFavoriteDirectors:(PFUser *)user withCompletionBlock:(void(^)(NSArray *directors, NSError *error))completionBlock;

#pragma mark - Parse Data Calls

- (void)loadFavoriteDirectorsBackgroundWithParseIOSAPI:(void(^)(NSArray *directorArray, NSError *error))completionBlock;

- (void)loadDirectorsInBackgroundFromParseiOSAPI:(void(^)(NSArray *directorArray, NSError *error))completionBlock;

- (void)loadFilmsInBackgroundFromParseiOSAPI:(void(^)(NSArray *filmArray, NSError *error))completionBlock;

#pragma mark - REST API Specific

- (void)loadMovieFromSource:(RESTAPISource)restAPISource
                  movieName:(NSString *)movieName
        withCompletionBlock:(void(^)(id movieDict, NSError *error))completionBlock;

- (void)loadListFilms:(RESTAPISource)restAPISource
          withOptions:(NSDictionary *)options
   andCompletionBlock:(void(^)(NSArray *films, NSError *error))completionBlock;

#pragma mark - Open Movie DBB

/*
- (void)loadMovieFromOpenMovieDBByName:(NSString *)movieName
                   withCompletionBlock:(void(^)(NSDictionary *movieDict, NSError *error))completionBlock;
*/

- (void)loadMovieFromOpenMovieDBByName:(NSString *)movieName
                   withCompletionBlock:(void(^)(Film *film, NSError *error))completionBlock;

- (void)loadMovieFromOpenMovieDBByIMDBID:(NSString *)imdbID withCompletionBlock:(void (^)(Film *film, NSError *error))completionBlock;


#pragma mark - Parse

- (void)loadParseFilmsWithOptions:(NSDictionary *)options
               andCompletionBlock:(void(^)(NSArray *films, NSError *error))completionBlock;

#pragma mark - total hacks
// pleaes delete!
- (void)setTransferFlag;
- (void)moveTempFilmsToBFFilm;
- (void)populateWithIMDBIDs;
- (void)populateWithMoviePosterURLs;
- (void)populateMovieRelationshipsWithDirectors;
- (void)setFlagForFemaleDirector;
- (void)hackthetempfilmsdatabase; // shameful to show this stuff in public
- (void)hackthetempfilmsdatabase2;

@end


extern NSString *BFCControllerDomain;

typedef NS_ENUM(NSUInteger, BFCControllerError) {
    BFCControllerErrorFetchData,
    BFCControllerErrorInvalidParameter,
    BFCControllerErrorOMDBMovieNotFound // total hack this hsould be somewhere else
};

