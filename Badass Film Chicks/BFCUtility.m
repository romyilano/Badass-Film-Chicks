#import "BFCUtility.h"
#import <Parse/Parse.h>
#import "Constants.h"

@implementation BFCUtility

+ (UIFont *)bfcCellFont {
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0];;
}

+ (UIFont *)secondaryCellFont {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0];
}

+ (UIColor *)bfcCellFontColor {
    return [UIColor whiteColor];
}

+ (NSDateFormatter *)baceDateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    return dateFormatter;
}

+ (NSDictionary *)neighborhoodKeys {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Miscjson" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                 options:NSJSONReadingMutableContainers  error:nil];
        NSArray *neighborhoodDicts = jsonDict[@"results"];
        NSMutableDictionary *workingDict = [[NSMutableDictionary alloc] init];
        for (NSDictionary *neighborhoodDictObj in neighborhoodDicts) {
            [workingDict setObject:neighborhoodDictObj[@"objectId"]
                            forKey:neighborhoodDictObj[@"neighborhoodName"]];
        }
    return [workingDict copy];
}

// block returns a dictionary with set keys for a given class as the key and the object id as object value. this is useful for doing simple pointer queries.
+ (void)fetchObjectIDDictionaryForClassName:(NSString *)className selectedKey:(NSString *)selectedKey
                                  withBlock:(void (^)(NSDictionary *, BOOL, NSError *))completionBlock {
    NSMutableDictionary *workingDictionary = [[NSMutableDictionary alloc] init];
    PFQuery *classQuery = [PFQuery queryWithClassName:className];
    [classQuery findObjectsInBackgroundWithBlock:^(NSArray * __nullable objects, NSError * __nullable error) {
        if (!error && objects.count > 0) {
            for (PFObject *object in objects) {
                [workingDictionary setObject:object.objectId
                                      forKey:[object objectForKey:selectedKey]];
                // todo do some error checking
            }
        }
        if (completionBlock) {
            if (error) {
                completionBlock([NSDictionary dictionary], NO, error);
            } else {
                completionBlock([workingDictionary copy], YES, nil);
            }
        }
    }];
}

@end
