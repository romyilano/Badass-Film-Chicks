@import UIKit;

@interface BFCUtility : NSObject

+ (UIFont *)bfcCellFont;
+ (UIColor *)bfcCellFontColor;
+ (UIFont *)secondaryCellFont;
+ (NSDateFormatter *)baceDateFormatter;
+ (NSDictionary *)neighborhoodKeys;

+ (void)fetchObjectIDDictionaryForClassName:(NSString *)className
                                selectedKey:(NSString *)selectedKey
                                  withBlock:(void(^)(NSDictionary *objectIDDictionary, BOOL success, NSError *error))completionBlock;

@end
