#import "Film.h"
#import "Director.h"

@implementation Film

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"title" : @"Title",
             @"imdbID" : @"imdbID",
             @"director" : @"Director",
             @"writer" : @"Writer",
             @"plot" : @"Plot",
             @"posterURLString" : @"Poster",
             @"genre" : @"Genre",
             };
}

/*
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"objectId" : @"objectId",
             @"filmName" : @"film",
             @"imdbURL" : @"film_imdb",
             @"wikiURL" : @"wikipedia",
             @"firstName" : @"firstName",
             @"lastName" : @"lastName"
             };
}


+ (MTLValueTransformer *)imdbURLJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *imdbURLString, BOOL *success, NSError *__autoreleasing *error) {
        return [NSURL URLWithString:imdbURLString];
    } reverseBlock:^id(NSURL *imdbURL, BOOL *success, NSError *__autoreleasing *error) {
        return [imdbURL absoluteString];
    }];
}

+ (MTLValueTransformer *)wikiURLJSONTransformer {
    return [self imdbURLJSONTransformer];
}
 */
@end
