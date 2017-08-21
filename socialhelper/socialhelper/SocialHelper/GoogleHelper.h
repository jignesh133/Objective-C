
#import <Foundation/Foundation.h>
#import <GoogleSignIn/GoogleSignIn.h>

typedef void (^SocialBlock)(id result, NSString *error);

@interface GoogleHelper : NSObject <GIDSignInUIDelegate> {
     SocialBlock socialBlock;
}

- (void)authenticateWithBlock:(SocialBlock)block;

+ (id)Instance;

@end
