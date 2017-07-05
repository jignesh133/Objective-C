
#import <UIKit/UIKit.h>
#import "KGModal.h"
@interface KGModalWrapper : KGModal
+ (void)showWithContentView:(id)view;
+ (void)showViewUntilFinish:(id)view;
+ (void)hideView;
+ (void)tapCloseAction:(id)sender;
@end
