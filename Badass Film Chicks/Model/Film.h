#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>


@interface Film : MTLModel <MTLJSONSerializing>

// hacking this for omdb
@property (strong, nonatomic) NSString *title;
// @property (strong, nonatomic) NSNumber *year;
@property (strong, nonatomic) NSString *imdbID;
@property (strong, nonatomic) NSString *posterURLString;
@property (strong, nonatomic) NSString *plot;
@property (strong, nonatomic) NSString *genre;
// @property (strong, nonatomic) NSDate *releaseDate;
@property (strong, nonatomic) NSString *director;
@property (strong, nonatomic) NSString *writer;
@property (strong, nonatomic) NSString *runTimeString;




/*
@property (strong, nonatomic) NSString *objectId;
@property (strong, nonatomic) NSString *filmName;
@property (strong, nonatomic) NSURL *imdbURL;
@property (strong, nonatomic) NSURL *wikiURL; // wikipedia URL
@property (strong, nonatomic) Director *director;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSURL *posterURL;

// todo - remove this later
@property (strong, nonatomic) NSString *directorName;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
 */

@end
