
#import "KGModalWrapper.h"

@implementation KGModalWrapper

+ (void)showWithContentView:(id)view{
   // [KGModal sharedInstance].showCloseButton = NO;
    [[KGModal sharedInstance] setTapOutsideToDismiss:YES];
    UIView * aView = view;
    aView.layer.cornerRadius = 5;
    [[KGModal sharedInstance] showWithContentView:aView andAnimated:true];
}

+ (void)showViewUntilFinish:(id)view{
    //[KGModal sharedInstance].showCloseButton = NO;
    [[KGModal sharedInstance] setTapOutsideToDismiss:NO];
    UIView * aView = view;
    aView.layer.cornerRadius = 10;
    [[KGModal sharedInstance] showWithContentView:aView andAnimated:true];
}

+ (void)hideView{
    [[KGModal sharedInstance] hide];
}

+ (void)tapCloseAction:(id)sender{
    if([KGModal sharedInstance].tapOutsideToDismiss){
        [[KGModal sharedInstance] hideAnimated:[KGModal sharedInstance].animateWhenDismissed];
    }
}
@end
