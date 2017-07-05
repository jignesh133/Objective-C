#import <Foundation/Foundation.h>
#import "RequestDelegate.h"
#import <AFNetworking/AFNetworking.h>
#import "AccountManager.h"

typedef enum {
    GET = 1,
    POST = 2,
    PUT = 3,
    DELETE = 4,
    MULTI_PART_FORM = 5
}RequestMethod;

@interface Request : NSObject
{
    id<RequestDelegate> _delegate;
    
    NSString *_urlPart;
    
    NSMutableDictionary *_postParameters;
    
    RequestMethod _methodType;
    
    NSString *_postData;
    
    id _serverData;
    
    NSString *_rawResponse;
    
    BOOL _IsSuccess;
    
    NSInteger _StatusCode;
    
    NSString *_Tag;
}

@property (nonatomic, retain, readwrite) NSString *postData;

@property (nonatomic, retain, readwrite) id serverData;

@property (nonatomic, retain, readwrite) NSString *rawResponse;

@property (nonatomic, assign) NSInteger StatusCode;

@property (nonatomic, assign) BOOL IsSuccess;

@property (nonatomic, retain, readwrite) NSString *Tag;


- (id) initWithUrl:(NSString*) urlString andDelegate:(id<RequestDelegate>) del;

- (id) initWithUrl:(NSString*) urlString andDelegate:(id<RequestDelegate>) del andMethod:(RequestMethod) method;

- (void)setParameter:(id)parameter forKey:(NSString *)key;

- (void) setPostParameters:(NSMutableDictionary*)dict;

- (void)startRequest;

@end
