//
//  UIColor+Utils.m
//  Minnaz
//
//  Created by Jignesh Bhensadadiya on 7/5/17.
//  Copyright © 2017 app. All rights reserved.
//

#import "UIColor+Utils.h"

#define RGB(r,g,b) \
{ \
static UIColor *rgb; \
if(!rgb) \
rgb = [UIColor colorWithRed: r / 255.0 green: g / 255.0 blue: b / 255.0 alpha: 1.0]; \
return rgb; \
}

#define RGBA(r,g,b,a) \
{ \
static UIColor *rgb; \
if(!rgb) \
rgb = [UIColor colorWithRed: r / 255.0 green: g / 255.0 blue: b / 255.0 alpha: a]; \
return rgb; \
}

@implementation UIColor (Utils)
+ (UIColor *)appBlueColor                     RGB(41, 62, 83)

@end
