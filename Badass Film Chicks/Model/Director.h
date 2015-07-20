#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface Director : MTLModel  <MTLJSONSerializing>
@property (strong, nonatomic) NSString *objectId;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSURL *imdbURL;
@property (strong, nonatomic) NSURL *wikiURL; // wikipedia URL
@property (strong, nonatomic) NSArray *films; // todo < -
@property (strong, nonatomic) NSString *country;

@end
