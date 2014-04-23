//
//  ViewController.m
//  testapp
//
//  Created by TNM_ios2 on 11/04/14.
//  Copyright (c) 2014 TNM_ios2. All rights reserved.
//

#import "ViewController.h"
#import "BackViewController.h"
#import "UrlConnection.h"
@interface ViewController ()<UrlConnectionDelegate>

@end

@implementation ViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Animation";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UrlConnection *connection = [[UrlConnection alloc] initWithUrl:@"http://ergast.com/api/f1/2005/last.json" postData:@"" LoadText:@"Loading..." title:@""];
    connection.delegate = self;
    UIBarButtonItem *btnRefresh = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStyleBordered target:self action:@selector(backviewGo)];
    self.navigationItem.rightBarButtonItem = btnRefresh;
}
-(void)backviewGo
{
    UrlConnection *connection = [[UrlConnection alloc] initWithUrl:@"http://ergast.com/api/f1/2005/last.json" postData:@"" LoadText:@"Loading..." title:@""];
    connection.delegate = self;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didFailWithError:(NSError *)error title:(NSString *)title withConnection:(UrlConnection *)urlConnecton
{
    
}
-(void)connectionDidFinishLoad:(id)data title:(NSString *)title withConnection:(UrlConnection *)urlConnecton
{
    
}
@end
