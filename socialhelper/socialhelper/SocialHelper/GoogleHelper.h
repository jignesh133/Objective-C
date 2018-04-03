
#import <Foundation/Foundation.h>
#import <GoogleSignIn/GoogleSignIn.h>


typedef void (^SocialBlock)(id result, NSString *error);

@interface GoogleHelper : NSObject <GIDSignInUIDelegate,GIDSignInDelegate> {
     SocialBlock socialBlock;
}

// AUTHENTICATE THE GOOLE
- (void)authenticateWithBlock:(SocialBlock)block;

+ (id)Instance;



@end
