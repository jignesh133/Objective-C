
#import "GoogleHelper.h"


@implementation GoogleHelper

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
    [[GIDSignIn sharedInstance] signOut];    
    GIDSignIn* signIn = [GIDSignIn sharedInstance];
    signIn.scopes = @[ @"profile", @"email"];
    signIn.delegate = self;
    signIn.uiDelegate = self;
    signIn.shouldFetchBasicProfile = YES;
    
    [[GIDSignIn sharedInstance] signIn];
}

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    if (error == nil) {
        if (socialBlock) {
            socialBlock(user,nil);
        }
    }else{
        if (socialBlock) {
            socialBlock(nil,[error localizedDescription]);
        }
    }
}

- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error {
    NSLog(@"fdbd");
    if (socialBlock) {
        socialBlock(nil,error.localizedDescription);
    }
}

- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error{
//    if (socialBlock) {
//        socialBlock(nil,error.localizedDescription);
//    }
}

- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController{
//    present from the topmain view controller
    [[self topMostController] presentViewController:viewController animated:YES completion:nil];
}
- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController{
    //    dismiss from the topmain view controller
      [[self topMostController]  dismissViewControllerAnimated:YES completion:nil];
}
-(UIViewController*) topMostController{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

@end
