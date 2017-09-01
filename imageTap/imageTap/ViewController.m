//
//  ViewController.m
//  imageTap
//
//  Created by OWNER on 01/09/17.
//  Copyright © 2017 OWNER. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+Utils.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [imageViewProfilePic methodPhotoViewerWithSuperView:self.view];
}



@end
