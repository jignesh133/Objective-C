
#import "FbHelper.h"

@implementation FbHelper

+ (id)Instance{
    static id sharedManager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}


// Authenticate the block

- (void)authenticateWithBlock:(SocialBlock)block{
    socialBlock = block;

    login = [[FBSDKLoginManager alloc] init];
    //ESSENTIAL LINE OF CODE BECAUSE OF 304 Error
    [login logInWithReadPermissions:@[@"public_profile",@"email",@"user_birthday"] fromViewController:nil handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (result.isCancelled) {
            if (socialBlock) {
                socialBlock(nil,@"");
            }
        }
      else if (!error) {
            if ([FBSDKAccessToken currentAccessToken]) {
                FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:@{@"fields" : @"id,name,email,first_name,last_name"                                                                                                            }];
                [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                    if (result) {
                        if (socialBlock) {
                            socialBlock(result,nil);
                        }
                       
                    }
                    else{
                        if (socialBlock) {
                            socialBlock(nil,error.localizedDescription);
                        }
                     
                    }
                }];
            }else{
                if (socialBlock) {
                    socialBlock(nil,[error localizedDescription]);
                }
              
            }
        }
        else{
            if (socialBlock) {
                socialBlock(nil,[error localizedDescription]);
            }
            
        }
    }];
    //then logout
    [login logOut];
}



@end
