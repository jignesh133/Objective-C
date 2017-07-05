
#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "URLSchema.h"

@interface RequestManager : NSObject {
    AFHTTPSessionManager *_manager;
}


+ (id) Instance;

- (void) ClearInstance;

- (AFHTTPSessionManager*) requestManager;

- (AFHTTPSessionManager*) tempRequestManager;


@end
