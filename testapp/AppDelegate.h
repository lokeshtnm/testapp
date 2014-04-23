//
//  AppDelegate.h
//  testapp
//
//  Created by TNM_ios2 on 11/04/14.
//  Copyright (c) 2014 TNM_ios2. All rights reserved.
//

#import <UIKit/UIKit.h>
#define appDelegate (AppDelegate*)[[UIApplication sharedApplication] delegate]
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
- (NSString *)loadVimeoAccessToken;
- (void)storeVimeoAccessToken:(NSString *)accessToken;
@end
