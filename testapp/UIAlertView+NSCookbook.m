//
//  UIAlertView+NSCookbook.m
//  Restaurant
//
//  Created by TNM_ios2 on 15/11/13.
//  Copyright (c) 2013 TNM_ios2. All rights reserved.
//

#import "UIAlertView+NSCookbook.h"
#import <objc/runtime.h>

@interface TNMAlertWrapper : NSObject<UIAlertViewDelegate>

@property (copy) void(^completionBlock)(UIAlertView *alertView, NSInteger buttonIndex);
@property (copy) void(^viewLoadBlock)(UIAlertView *alertView);
@end
@implementation TNMAlertWrapper

#pragma mark - UIAlertViewDelegate

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.completionBlock)
        self.completionBlock(alertView, buttonIndex);
}

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)alertViewCancel:(UIAlertView *)alertView
{
    // Just simulate a cancel button click
    if (self.completionBlock)
        self.completionBlock(alertView, alertView.cancelButtonIndex);
}
- (void)willPresentAlertView:(UIAlertView *)alertView {
    if (self.viewLoadBlock)
        self.viewLoadBlock(alertView);
}
- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
//    if(alertView.alertViewStyle == UIAlertViewStylePlainTextInput)
//        return ([[[alertView textFieldAtIndex:0] text] length]>0)?YES:NO;
    return YES;
}
@end

static const char TNMSAlertWrapper;
@implementation UIAlertView (NSCookbook)
- (void)showWithCompletion:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))completion
{
    TNMAlertWrapper *alertWrapper = [[TNMAlertWrapper alloc] init];
    alertWrapper.completionBlock = completion;
    self.delegate = alertWrapper;
    
    // Set the wrapper as an associated object
    objc_setAssociatedObject(self, &TNMSAlertWrapper, alertWrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // Show the alert as normal
    [self show];
}
- (void)showWithCompletion:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))completion andViewApper:(void(^) (UIAlertView *alertView))viewWillapper
{
    TNMAlertWrapper *alertWrapper = [[TNMAlertWrapper alloc] init];
    alertWrapper.completionBlock = completion;
    alertWrapper.viewLoadBlock = viewWillapper;
    self.delegate = alertWrapper;
    
    // Set the wrapper as an associated object
    objc_setAssociatedObject(self, &TNMSAlertWrapper, alertWrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // Show the alert as normal
    [self show];
}
@end
