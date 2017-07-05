//
//  SLPhotoViewController.m
//  SLPhotoSelection
//
//  Created by Agustin De Leon on 22/4/17.
//  Copyright © 2017 Agustin De Leon. All rights reserved.
//

#import "SLPhotoViewController.h"
#import "SLPhotoView.h"

#define kItemsPerLine       3
#define kWidthImageView     (self.view.frame.size.width / kItemsPerLine)

@interface SLPhotoViewController ()

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *photoArray;

@property (nonatomic, strong) NSMutableArray *selectedPhotoArray;

@end

@implementation SLPhotoViewController

#pragma mark - LifeCycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initializeAttributes];
    [self setUpPhotoImages];
    [self setUpNavigationBarButton];
    
    [self setUpScrollImages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initialize methods

- (void)initializeAttributes
{
    self.selectedPhotoArray = [NSMutableArray array];
}

#pragma mark - Setup methods

- (void)setUpPhotoImages
{
    self.photoArray = [SLPhotoManager getPHAssetsForAssetCollection:self.assetCollections
                                                      withFilesType:self.selectionType];
}

- (void)setUpNavigationBarButton
{
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                   target:self
                                                                                   action:@selector(doneAction)];
    [self.navigationItem setRightBarButtonItem:doneBarButton];
}

- (void)setUpScrollImages
{
    for (int i = 0; i < [self.photoArray count]; i++) {
        CGRect frame = CGRectMake((i % kItemsPerLine) * kWidthImageView,
                                  kWidthImageView * (int)(i/kItemsPerLine), kWidthImageView, kWidthImageView);
        
        SLPhotoView *photoView;
        
        photoView = [[SLPhotoView alloc] initWithFrame:frame
                                            withAssets:self.photoArray[i]
                                        selectionBlock:^(PHAsset *asset) {
                                            [self selection:asset];
                                        } deselectBlock:^(PHAsset *asset) {
                                            [self deselection:asset];
                                        }];
        
        [self.scrollView addSubview:photoView];
    }
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, kWidthImageView * self.photoArray.count)];
}

#pragma mark - Actions methods

- (void)selection:(id)object
{
    [self.selectedPhotoArray addObject:object];
}

- (void)deselection:(id)object
{
    [self.selectedPhotoArray removeObject:object];
}

- (void)doneAction
{
    if (self.multipleCompletionBlock) {
        self.multipleCompletionBlock(YES, self.selectedPhotoArray);
        self.multipleCompletionBlock = nil;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
