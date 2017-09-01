//
//  UIImageView+Utils.m
//  imageTap
//
//  Created by OWNER on 01/09/17.
//  Copyright © 2017 OWNER. All rights reserved.
//

#import "UIImageView+Utils.h"
#import <objc/runtime.h>


@implementation UIImageView (Utils)

// SYSNTHESIZE PROPERTY
-(UIView *)viewbg{
    return objc_getAssociatedObject (self, @selector(viewbg));
}
-(void)setViewbg:(UIView *)viewbg{
    objc_setAssociatedObject(self, @selector(viewbg), viewbg, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIView *)view{
    return objc_getAssociatedObject (self, @selector(view));
}
-(void)setView:(UIView *)view{
    objc_setAssociatedObject(self, @selector(view), view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIImageView *)temptumb{
    return objc_getAssociatedObject (self, @selector(temptumb));
}
-(void)setTemptumb:(UIImageView *)temptumb{
    objc_setAssociatedObject(self, @selector(temptumb), temptumb, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIImageView *)fullimageview{
    return objc_getAssociatedObject (self, @selector(fullimageview));
}
-(void)setFullimageview:(UIImageView *)fullimageview{
    objc_setAssociatedObject(self, @selector(fullimageview), fullimageview, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// SET PHOTO VIEWER
-(void)methodPhotoViewerWithSuperView:(UIView *)view{
    
    if (self.image == nil){
        return;
    }
    
    self.temptumb = self;
    self.view = view;
    
    // MAKE ON USER INTERCATINO ON
    [self.temptumb setUserInteractionEnabled:YES];
    
    // ADD GESTURE
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bannerTapped:)];
    gesture.numberOfTapsRequired = 1;
    gesture.cancelsTouchesInView = YES;
    [self.temptumb addGestureRecognizer:gesture];
    
}
- (void)bannerTapped:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"%@", [gestureRecognizer view]);
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    self.temptumb=(UIImageView *)gestureRecognizer.view;
    self.fullimageview=[[UIImageView alloc]init];
    
    [self.fullimageview setContentMode:UIViewContentModeScaleAspectFit];
    self.fullimageview.image = [(UIImageView *)gestureRecognizer.view image];
    
    
    // SET THE POINT
    CGPoint point  = [gestureRecognizer locationInView:self.view];
    
    
    // SET THE FRAME
    CGRect frame = gestureRecognizer.view.frame;
    
    self.fullimageview.frame = frame;
    [self.fullimageview setCenter:point];
    
    // ADD TRANSPARANT BG
    self.viewbg = [[UIView alloc] initWithFrame:self.view.frame];
    self.viewbg.backgroundColor = [UIColor blackColor];//[UIColor colorWithPatternImage:self.temptumb.image];
    self.viewbg.alpha = 0.6;
    
    
    [self.view addSubview:self.viewbg];
    [self.view addSubview:self.fullimageview];
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self.fullimageview setFrame:CGRectMake(0,
                                                                 0,
                                                                 screenRect.size.width,
                                                                 screenRect.size.height)];
                         [self.fullimageview setFrame:screenRect];
                     }];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fullimagetapped:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [self.fullimageview addGestureRecognizer:singleTap];
    [self.fullimageview setUserInteractionEnabled:YES];
}
-(void)fullimagetapped:(UIGestureRecognizer *)gestureRecognizer {
    gestureRecognizer.view.backgroundColor=[UIColor clearColor];
    [UIView animateWithDuration:0.5
                     animations:^{
                     
                         UIImageView *imgView = (UIImageView *)gestureRecognizer.view;
                         [imgView setFrame:CGRectMake(self.view.center.x, self.view.center.y, 0, 0)];
                     }];
    [self performSelector:@selector(animationDone:) withObject:[gestureRecognizer view] afterDelay:0.4];
}

//Remove view after animation of remove
-(void)animationDone:(UIView  *)view
{
    [self.viewbg removeFromSuperview];
    [self.fullimageview removeFromSuperview];
}
@end
