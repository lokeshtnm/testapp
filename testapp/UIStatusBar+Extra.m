//
//  UIStatusBar+Extra.m
//  testapp
//
//  Created by TNM_ios2 on 11/04/14.
//  Copyright (c) 2014 TNM_ios2. All rights reserved.
//

#import "UIStatusBar+Extra.h"

@interface UIStatusBar (Override)
@end

@implementation UIStatusBar (Override)

- (void) drawRect:(CGRect)rect
{
    NSArray* subviews = self.subviews;
    if(subviews.count < 2)
		return;
    UIView* background = [subviews objectAtIndex:0];
	background.layer.borderWidth = 1;
    background.layer.borderColor = [UIColor lightGrayColor].CGColor;
    background.layer.cornerRadius = 10.0f;
    background.layer.backgroundColor = [UIColor brownColor].CGColor;
    UIView* foreground = [subviews objectAtIndex:1];
    UIView *serviceview = [foreground.subviews objectAtIndex:1];
    UILabel *lable = [[UILabel alloc] initWithFrame:serviceview.frame];
    lable.font = [UIFont fontWithName:@"Helvetica-Light" size: 12.0];
    lable.text = @"Desap";
    [foreground addSubview:lable];
    lable.textColor = [UIColor blackColor];
    [serviceview removeFromSuperview];
//	[self StatusBarRun];
}
-(void)StatusBarRun
{
    NSArray* subviews = self.subviews;
    
	if(subviews.count < 2)
		return;
    UIView* background = [subviews objectAtIndex:0];
	UIView* foreground = [subviews objectAtIndex:1];
    
    CGFloat y = [UIScreen mainScreen].bounds.size.height - 20;
    
    if (foreground.frame.origin.y != 0) {
        y = 0.0f;
    }
	[UIView animateWithDuration:4 animations:^{
		[foreground setFrame:CGRectMake(0.0, y, foreground.frame.size.width, foreground.frame.size.height)];
        [background setFrame:CGRectMake(0.0, y, foreground.frame.size.width, foreground.frame.size.height)];
	} completion:^(BOOL finished) {
        if (finished) {
            [self StatusBarRun];
        }
    }];
}
@end
