//
//  Director.m
//  Badass Film Chicks
//
//  Created by Romy on 7/11/15.
//  Copyright © 2015 Romy. All rights reserved.
//

#import "Director.h"
#import "Film.h"

@implementation Director

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"objectId" : @"objectId",
             @"firstName" : @"firstName",
             @"lastName" : @"lastName",
             @"imdbURL" : @"director_imdb",
             @"wikiURL" : @"director_wiki",
             @"films" : @"films"
             };
}

+ (NSValueTransformer *)filmsJSONTransformer {
   return [MTLJSONAdapter arrayTransformerWithModelClass:Film.class];
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

@end
