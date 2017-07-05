
#import "RequestManager.h"

@implementation RequestManager

+ (id) Instance {
    static RequestManager *__sharedDataModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedDataModel = [[RequestManager alloc] init];
    });
    
    return __sharedDataModel;
}

- (void)ClearInstance{
    _manager = nil;
}
- (AFHTTPSessionManager*) requestManager {
    if (_manager == nil) {
        
        NSURL *url = [NSURL URLWithString:kBASE_URL]; // :: use the base url here
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/x-www-form-urlencoded",@"application/javascript",@"application/json", nil];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _manager;
}
- (AFHTTPSessionManager*) tempRequestManager
{
    NSURL *url = [NSURL URLWithString:kBASE_URL]; // :: use the base url here
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
    return manager;
}

@end
