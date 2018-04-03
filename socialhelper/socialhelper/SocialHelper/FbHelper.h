

#import <Foundation/Foundation.h>
#import <FBSDKCoreKit/FBSDKAccessToken.h>
#import <FBSDKCoreKit/FBSDKGraphRequest.h>
#import <FBSDKLoginKit/FBSDKLoginManager.h>
#import <FBSDKLoginKit/FBSDKLoginManagerLoginResult.h>

typedef void (^SocialBlock)(id result, NSString *error);

@interface FbHelper : NSObject{
    SocialBlock socialBlock;
    FBSDKLoginManager *login;
}


// INITILIZE INSTANCE
+ (id) Instance;


// authenticateWithBlock
- (void) authenticateWithBlock:(SocialBlock)block;



@end
