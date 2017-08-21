//
//  ViewController.m
//  socialhelper
//
//  Created by Jignesh Bhensadadiya on 8/21/17.
//  Copyright © 2017 Jignesh Bhensadadiya. All rights reserved.
//

#import "ViewController.h"
#import "FbHelper.h"
#import "GoogleHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)facebookClicked:(id)sender {
    [[FbHelper Instance] authenticateWithBlock:^(id result, NSString *error) {
        if (!error) {
            NSLog(@"%@",result);
        }
        else{
        
        }
    }];
}
- (IBAction)googleClicked:(id)sender {
    [[GoogleHelper Instance] authenticateWithBlock:^(id result, NSString *error) {
        if (!error) {
            
        }
        else{
        
        }
    }];
}
@end
