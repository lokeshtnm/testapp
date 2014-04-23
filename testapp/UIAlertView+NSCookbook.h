//
//  UIAlertView+NSCookbook.h
//  Restaurant
//
//  Created by TNM_ios2 on 15/11/13.
//  Copyright (c) 2013 TNM_ios2. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface UIAlertView (NSCookbook)

- (void)showWithCompletion:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))completion;
- (void)showWithCompletion:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))completion andViewApper:(void(^) (UIAlertView *alertView))viewWillapper;
@end
