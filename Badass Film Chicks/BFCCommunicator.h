#import <Foundation/Foundation.h>

/**
 *  Communicator layer that talks to network
 */
@interface BFCCommunicator : NSObject

/**
 *  Fetches data for a given url, runs on a background thread (not the main thread)
 *
 *  @param url             NSURL Parameter
 *  @param completionBlock completion block -> NSData data downloaded, urlResponse is the url response, error if there are any
 */
- (void)fetchDataForURLInBackground:(NSURL *)url
                withCompletionBlock:(void(^)(NSData *data, NSURLResponse *urlResponse, NSError *error))completionBlock;

@end

extern NSString *BFCCommunicatorDomain;

typedef NS_ENUM(NSUInteger, BFCCommunicatorError) {
    BFCCommunicatorInvalidJSONError,
    BFCCommunicatorNetworkError,
    BFCCommunicatorMissingDataError,
    BFCCommunicatorBadData
};