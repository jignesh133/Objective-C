//
//  UIImage+ResizeMagick.h
//
//
//  Created by Vlad Andersen on 1/5/13.
//
//
//https://github.com/mustangostang/UIImage-ResizeMagick

#import <UIKit/UIKit.h>


@interface UIImage (ResizeMagick)

+ (void) setInterpolationQuality:(CGInterpolationQuality) quality;
+ (CGInterpolationQuality) interpolationQuality;

- (UIImage *) resizedImageByMagick: (NSString *) spec;
- (UIImage *) resizedImageByWidth:  (NSUInteger) width;
- (UIImage *) resizedImageByHeight: (NSUInteger) height;
- (UIImage *) resizedImageWithMaximumSize: (CGSize) size;
- (UIImage *) resizedImageWithMinimumSize: (CGSize) size;
-(BOOL)isExis;

@end
