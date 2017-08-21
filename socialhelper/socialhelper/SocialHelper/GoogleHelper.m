
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

- (void)authenticateWithBlock:(SocialBlock)block{
    socialBlock = block;
    
    GIDSignIn* signIn = [GIDSignIn sharedInstance];
    signIn.scopes = @[ @"profile", @"email" ];
    signIn.delegate = [GoogleHelper Instance];
    signIn.uiDelegate = self;
    
    [[GIDSignIn sharedInstance] signIn];
}

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    if (error == nil) {
        if (socialBlock) {
            socialBlock(user,nil);
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
    
}
- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController{
    [[self topMostController] presentViewController:viewController animated:YES completion:nil];

}
- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController{
  //  [[self topMostController]dismissViewControllerAnimated:YES completion:nil];

}
- (UIViewController*) topMostController {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    return topController;
}


@end
