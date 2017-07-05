//
//  CustomTextField.m
//  Minnaz
//
//  Created by Jignesh Bhensadadiya on 7/5/17.
//  Copyright © 2017 app. All rights reserved.
//

#import "CustomTextField.h"
#import <QuartzCore/QuartzCore.h>
IB_DESIGNABLE
@implementation CustomTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@synthesize padding;

-(CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, padding, padding);
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    return [self textRectForBounds:bounds];
}


- (id)initWithCoder:(NSCoder*)coder {
    self = [super initWithCoder:coder];
    
    if (self) {
        self.layer.cornerRadius = _cornerRadious;
        self.layer.borderColor = _borderColor.CGColor;
        self.layer.borderWidth = _borderWidth;
        self.layer.masksToBounds  = YES;
        self.clipsToBounds = YES;
    }
    
    return self;
}


@end
