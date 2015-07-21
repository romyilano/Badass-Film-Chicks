//
//  Constants.m
//  ParseStarterProject
//
//  Created by Romy on 6/5/15.
//
//

#import "Constants.h"
#import "SecretKeys.h"

@implementation Constants

NSString *const kParseApplicationId = kSecretParseApplicationId;
NSString *const kParseClientKey = kSecretParseClientKey;
NSString *const kRottenTomatoesAPIKey = kSecretRottenTomatoesApiKey;
NSString *const kParseRESTAPIKey = kSecretParseRESTAPIKey;
NSString *const kParseMasterKey = kSecretParseMasterKey;

NSString *const URLRSSIndieWire = @"http://feeds.feedburner.com/indiewire/womenandhollywood?format=xml";

NSString *const kOpenMDBAPIBaseURL= @"http://www.omdbapi.com";

#pragma mark - PFObject User Keys

NSString *const kParseUserClassDirectorRelationKey = @"directorRelation";

#pragma mark - PFObject Film Class
NSString *const kParseFilmClassKey = @"Film";

#pragma mark - PFObject Director Class
NSString *const kParseDirectorClassKey = @"Director";
NSString *const kParseDirectorFirstNameClassKey = @"firstName";
NSString *const kParseDirectorLastNameClassKey = @"lastName";

#pragma mark - Storyboard IDS
NSString *const kLoneWolfSTIDLoginNavKey = @"LoneWolfLoginScene";

#pragma mark - Segues
NSString *const kSegueLoginKey = @"LoginSegue";
NSString *const kSegueSignupKey = @"SignupSegue";
NSString *const kSegueProfileKey = @"ProfileSegue";

@end
