

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^SocialBlock)(id result, NSString *error);

@interface FbHelper : NSObject{
    SocialBlock socialBlock;
}

+ (id) Instance;

- (void) authenticateWithBlock:(SocialBlock)block;

- (void) getAllMyFBPhotoWithBlock:(SocialBlock)block;

- (UIViewController*) topMostController ;
@end
