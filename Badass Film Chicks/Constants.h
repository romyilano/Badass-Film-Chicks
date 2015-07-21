#import <Foundation/Foundation.h>

@interface Constants : NSObject

extern NSString *const kParseApplicationId;
extern NSString *const kParseClientKey;
extern NSString *const kParseRESTAPIKey;
extern NSString *const kParseMasterKey;

extern NSString *const URLRSSIndieWire;
extern NSString *const kRottenTomatoesAPIKey;

#pragma mark - URLs
extern NSString *const kOpenMDBAPIBaseURL;  //http://www.omdbapi.com
#pragma mark - PFObject Film Class
extern NSString *const kParseFilmClassKey;

#pragma mark - PFUser keys
extern NSString *const kParseUserClassDirectorRelationKey;

#pragma mark - PFObject Director Class
extern NSString *const kParseDirectorClassKey;
extern NSString *const kParseDirectorFirstNameClassKey;
extern NSString *const kParseDirectorLastNameClassKey;

#pragma mark - Segues
extern NSString *const kSegueLoginKey;
extern NSString *const kSegueSignupKey;
extern NSString *const kSegueProfileKey;

#pragma mark - Storyboard IDS
extern NSString *const kLoneWolfSTIDLoginNavKey;

@end

typedef NS_ENUM(NSUInteger, RESTAPISource) {
    RESTAPISourceOpenMovieDB,
    RESTAPISourceTheMovieDB,
    RESTAPISourceRottenTomatoes,
    RESTAPISourceParse,
};

typedef NS_ENUM(NSUInteger, MovieGoreLevel) {
    MovieGoreLevelNone,
    MovieGoreLevelLow,
    MovieGoreLevelAverage,
    MovieGoreLevelHigh,
    MovieGoreLevelExtreme
};

typedef NS_ENUM(NSInteger, ParseFetchError)  {
    ParseFetchErrorUserNotLoggedInError,
    ParseFetchErrorNoDataError,
    ParseFetchErrorNetworkCallFailedError,
    ParseFetchErrorBadParameter
};