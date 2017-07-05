#import "Request.h"
#import "RequestManager.h"
#import "Account.h"

@implementation Request
@synthesize postData = _postData;
@synthesize serverData = _serverData;
@synthesize rawResponse = _rawResponse;
@synthesize StatusCode = _StatusCode;
@synthesize IsSuccess = _IsSuccess;
@synthesize Tag = _Tag;

- (id)initWithUrl:(NSString *)urlString andDelegate:(id<RequestDelegate>)del {
    return [self initWithUrl:urlString andDelegate:del andMethod:GET];
}

- (id)initWithUrl:(NSString *)urlString andDelegate:(id<RequestDelegate>)del andMethod:(RequestMethod)method {
    self = [super init];
    
    if (self)
    {
        _urlPart = urlString;
        _methodType = method;
        _postParameters = [[NSMutableDictionary alloc] init];
        _delegate = del;
    }
    
    return self;
}

- (void)setParameter:(id)parameter forKey:(NSString *)key {
    [_postParameters setObject:parameter forKey:key];
}

- (void) setPostParameters:(NSMutableDictionary*)dict
{
    _postParameters = dict;
}

- (void)startRequest{
    
    if (_methodType == GET) {
        if ([self.Tag isEqualToString:KDashboardStatistics] ||[self.Tag isEqualToString:kgetUser]  ||[self.Tag isEqualToString:kGetCategory] || [self.Tag isEqualToString:Kachievements] || [self.Tag isEqualToString:kteacherlistannouncement] || [self.Tag isEqualToString:KLastMessage]) {
            Account * account = [AccountManager Instance].activeAccount;
            if (account) {
                NSString * str = [NSString stringWithFormat:@"Bearer %@", account.token];
                [[[RequestManager Instance] requestManager].requestSerializer setValue:str forHTTPHeaderField:@"Authorization"];
            }

        }
        [[[RequestManager Instance] requestManager] GET:_urlPart parameters:nil success:^void(NSURLSessionDataTask * task, id responseObject) {
            
           
            _serverData = responseObject;
            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
            self.StatusCode = r.statusCode;
            if ([[responseObject objectForKey:@"is_error"]intValue] != 1) {
                self.IsSuccess = YES;
                [self requestSuccess];
            }else{
                self.IsSuccess = NO;
                NSError *error = [NSError errorWithDomain:@"Application" code:100 userInfo:@{ @"message":[responseObject objectForKey:@"message"] }];
                [self requestFailedWithError:error];
            }
        } failure:^void(NSURLSessionDataTask * task, NSError *error) {
            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
            self.StatusCode = r.statusCode;
            self.IsSuccess = NO;
            self.serverData = nil;
            [self requestFailedWithError:error];
        }];
    }else if (_methodType == POST){
        Account * account = [AccountManager Instance].activeAccount;
        if (account) {
            NSString * str = [NSString stringWithFormat:@"Bearer %@", account.token];
            [[[RequestManager Instance] requestManager].requestSerializer setValue:str forHTTPHeaderField:@"Authorization"];
        }
        [[[RequestManager Instance] requestManager] POST:_urlPart parameters:_postParameters success:^void(NSURLSessionDataTask * task, id responseObject) {
            _serverData = responseObject;
            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
            self.StatusCode = r.statusCode;
            if ([[responseObject objectForKey:@"is_error"]intValue] != 1) {
                self.IsSuccess = YES;
                [self requestSuccess];
            }else if(self.StatusCode == 401){
                if ([[responseObject objectForKey:@"is_error"]intValue] == 1) {
                    self.IsSuccess = NO;
                    NSError *error = [NSError errorWithDomain:@"Application" code:100 userInfo:@{ @"message":[responseObject objectForKey:@"message"] }];
                    [self requestFailedWithError:error];
                } else {
                    self.IsSuccess = YES;
                    [self requestSuccess];
                }
            } else{
                self.IsSuccess = NO;
                NSError *error = [NSError errorWithDomain:@"Application" code:100 userInfo:@{ @"message":[responseObject objectForKey:@"message"] }];
                [self requestFailedWithError:error];
            }
        } failure:^void(NSURLSessionDataTask * task, NSError * error) {
            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
            self.StatusCode = r.statusCode;
            self.IsSuccess = NO;
            self.serverData = nil;
            [self requestFailedWithError:error];
        }];
    }else if (_methodType == PUT) {
        [[[RequestManager Instance] requestManager] PUT:_urlPart parameters:_postParameters success:^void(NSURLSessionDataTask * task, id responseObject) {
            _serverData = responseObject;
            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
            self.StatusCode = r.statusCode;
            self.IsSuccess = YES;
            [self requestSuccess];
        } failure:^void(NSURLSessionDataTask * task, NSError * error) {
            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
            self.StatusCode = r.statusCode;
            self.IsSuccess = NO;
            self.serverData = nil;
            [self requestFailedWithError:error];
        }];
    }else if (_methodType == DELETE) {
        [[[RequestManager Instance] requestManager] DELETE:_urlPart parameters:_postParameters success:^void(NSURLSessionDataTask * task, id responseObject) {
            _serverData = responseObject;
            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
            self.StatusCode = r.statusCode;
            self.IsSuccess = YES;
            [self requestSuccess];
        } failure:^void(NSURLSessionDataTask * task, NSError *error) {
            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
            self.StatusCode = r.statusCode;
            self.IsSuccess = NO;
            self.serverData = nil;
            [self requestFailedWithError:error];
        }];
    }else if (_methodType == MULTI_PART_FORM){
       
        Account * account = [AccountManager Instance].activeAccount;
        if (account) {
            NSString * str = [NSString stringWithFormat:@"Bearer %@", account.token];
            [[[RequestManager Instance] requestManager].requestSerializer setValue:str forHTTPHeaderField:@"Authorization"];
        }
        [[[RequestManager Instance] requestManager] POST:_urlPart parameters:_postParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            if ([self.Tag isEqualToString:KEditSubCat]) {
                [formData appendPartWithFileData:[_postParameters objectForKey:@"image"] name:@"image" fileName:@"image" mimeType:@"image/jpeg"];
            }
            else{
            [formData appendPartWithFileData:[_postParameters objectForKey:@"file"] name:@"file" fileName:@"file" mimeType:@"image/jpeg"];
            }
            
        } success:^(NSURLSessionDataTask * task, id responseObject) {
            _serverData = responseObject;
            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
            self.StatusCode = r.statusCode;
            self.IsSuccess = YES;
            [self requestSuccess];
        } failure:^(NSURLSessionDataTask* task, NSError* error) {
            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
            self.StatusCode = r.statusCode;
            self.IsSuccess = NO;
            self.serverData = nil;
            [self requestFailedWithError:error];
        }];
        
    }
}

- (void) requestSuccess {
    if (_delegate && [_delegate respondsToSelector:@selector(RequestDidSuccess:)]) {
        [_delegate RequestDidSuccess:self];
    }
}
- (void) requestFailedWithError:(NSError*)error {
    if (_delegate && [_delegate respondsToSelector:@selector(RequestDidFailForRequest:withError:)]) {
        [_delegate RequestDidFailForRequest:self withError:error];
    }
}

@end
