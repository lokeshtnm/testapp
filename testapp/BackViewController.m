//
//  BackViewController.m
//  testapp
//
//  Created by TNM_ios2 on 11/04/14.
//  Copyright (c) 2014 TNM_ios2. All rights reserved.
//

#import "BackViewController.h"
#import "UIAlertView+NSCookbook.h"
@interface BackViewController ()<UINavigationBarDelegate>

@end

@implementation BackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.delegate = self;
    UIButton* back = [UIButton buttonWithType:101];
    [back sizeToFit];
    [back setTitle:@"Lokesh" forState:UIControlStateNormal];
//    
//    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithCustomView:back];
//    self.navigationItem.leftBarButtonItem = btnBack;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL) navigationShouldPopOnBackButton {
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Are want to back?" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alertview showWithCompletion:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    return NO;
}

@end
