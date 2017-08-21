
#import "FbHelper.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@implementation FbHelper

+ (id)Instance{
    static id sharedManager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)authenticateWithBlock:(SocialBlock)block{
    socialBlock = block;
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"public_profile",@"email",@"user_birthday"] fromViewController:nil handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (!error) {
            if ([FBSDKAccessToken currentAccessToken]) {
                FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:@{@"fields" : @"id,name,email,first_name,last_name"                                                                                                            }];
                [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                    if (result) {
                        if (socialBlock) {
                            socialBlock(result,nil);
                        }
                    }
                }];
            }
        }
    }];
}

- (UIViewController*) topMostController {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    return topController;
}

- (void)getAllMyFBPhotoWithBlock:(SocialBlock)block{
    socialBlock = block;
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logInWithReadPermissions:@[@"public_profile,email,user_friends,user_photos"                                                                                                ] fromViewController:[self topMostController] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         [[[FBSDKGraphRequest alloc]
           initWithGraphPath:@"me/albums"
           parameters:nil
           HTTPMethod:@"GET"]
          startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
              if (!error) {
                  if (socialBlock) {
                      socialBlock(result,nil);
                  }
              }
          }];
     }];
}

@end
