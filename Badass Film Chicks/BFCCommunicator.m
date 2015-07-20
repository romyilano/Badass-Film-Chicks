#import "BFCCommunicator.h"
#import "Constants.h"

NSString *BFCCommunicatorDomain = @"BFCCommunicatorDomain";

@implementation BFCCommunicator

- (void)fetchDataForURLInBackground:(NSURL *)url
                withCompletionBlock:(void (^)(NSData *, NSURLResponse *, NSError *))completionBlock {
    
    __block NSError *finalError;
    
    if (!completionBlock) {
        NSLog(@"Please add completion block");
        return;
    }
    
    if (!url) {
        finalError = [NSError errorWithDomain:BFCCommunicatorDomain
                                         code:BFCCommunicatorMissingDataError userInfo:@{NSLocalizedDescriptionKey : @"Please supply url for fetch data for url in background method"}];
        completionBlock(nil, nil, finalError);
        return;
    }
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    urlRequest.HTTPMethod = @"GET";
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [configuration setHTTPAdditionalHeaders:@{@"Content-Type": @"application/json"}];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:[urlRequest copy]
                                                completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {
                                                    if (error) {
                                                        finalError = [NSError errorWithDomain:BFCCommunicatorDomain
                                                                                         code:BFCCommunicatorNetworkError     userInfo:@{NSLocalizedDescriptionKey : @"Network error"}];
                                                        completionBlock(data, response, finalError);
                                                    } else {
                                                        completionBlock(data, response, nil);
                                                    }
                                                }];
    [dataTask resume];
}

@end
