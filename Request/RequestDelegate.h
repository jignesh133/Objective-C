
#import <Foundation/Foundation.h>

@class Request;

@protocol RequestDelegate <NSObject>

- (void) RequestDidSuccess:(Request*)request;

- (void) RequestDidFailForRequest:(Request*)request withError:(NSError*)error;

@end
