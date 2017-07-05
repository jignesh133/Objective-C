//
//  CustomButton.m
//  Minnaz
//
//  Created by Jignesh Bhensadadiya on 7/5/17.
//  Copyright © 2017 app. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton
@synthesize cornerRadious=_cornerRadious,borderColor=_borderColor,borderWidth=_borderWidth;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.layer.cornerRadius = _cornerRadious;
    self.layer.borderColor = _borderColor.CGColor;
    self.layer.borderWidth = _borderWidth;
    self.layer.masksToBounds  = YES;
    self.clipsToBounds = YES;
}


@end
