//
//  UrlConnection.h
//  Facial Surgery
//
//  Created by TNM_ios2 on 29/08/13.
//  Copyright (c) 2013 TNM_ios2. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UrlConnection;
@protocol UrlConnectionDelegate <NSObject>
    -(void)didFailWithError:(NSError *)error title:(NSString*)title withConnection:(UrlConnection*)urlConnecton;
    -(void)connectionDidFinishLoad:(id)data title:(NSString*)title withConnection:(UrlConnection*)urlConnecton;
@end

@interface UrlConnection : NSObject<NSURLConnectionDataDelegate>
{
    NSMutableData *jsondata;
    NSURLConnection *connectoin;
    id<UrlConnectionDelegate> delegate;
    BOOL loadView,perView;
    NSString *title;
    NSString *loadText;
}
@property (nonatomic) BOOL loadView;
@property (retain,nonatomic) id<UrlConnectionDelegate> delegate;
@property (retain,nonatomic) NSMutableData *jsondata;
@property (retain,nonatomic) NSURLConnection *connectoin;
-(id)initWithUrl:(NSString *)url postData:(NSString*)postData title:(NSString*)title;
-(id)initWithUrl:(NSString *)url postData:(NSString*)postData LoadText:(NSString*)title title:(NSString*)title;
-(id)initWithUrl:(NSString *)url postData:(NSString*)postData LoadText:(NSString*)title title:(NSString*)title perView:(BOOL)isView;
@end
