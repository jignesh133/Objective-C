//
//  CustomButton.h
//  Minnaz
//
//  Created by Jignesh Bhensadadiya on 7/5/17.
//  Copyright © 2017 app. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface CustomButton : UIButton

@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable NSInteger borderWidth;
@property (nonatomic) IBInspectable CGFloat cornerRadious;


@end
