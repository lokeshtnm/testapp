//
//  UrlConnection.m
//  Facial Surgery
//
//  Created by TNM_ios2 on 29/08/13.
//  Copyright (c) 2013 TNM_ios2. All rights reserved.
//

#import "UrlConnection.h"
#import "ProgressHUD.h"
#define TIMEOUT_INTERVAL 30
#define CONTENT_TYPE @"Content-Type"
#define URL_ENCODED @"application/x-www-form-urlencoded"
#define POST @"POST"

@implementation UrlConnection
@synthesize connectoin,jsondata,delegate,loadView;
-(id)initWithUrl:(NSString *)url postData:(NSString*)postData LoadText:(NSString*)loadtext title:(NSString*)Title perView:(BOOL)isView
{
    NSMutableURLRequest *request = [self getNSMutableURLRequestUsingPOSTMethodWithUrl:url postData:postData];
    connectoin = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    jsondata = [[NSMutableData alloc] init];
    loadView = true;
    title = Title;
    loadText = loadtext;
    [ProgressHUD show:loadtext];
    perView = isView;
    return self;
    
}
-(id)initWithUrl:(NSString *)url postData:(NSString*)postData LoadText:(NSString*)loadtext title:(NSString*)Title
{
    NSMutableURLRequest *request = [self getNSMutableURLRequestUsingPOSTMethodWithUrl:url postData:postData];
    
    connectoin = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    jsondata = [[NSMutableData alloc] init];
    loadView = true;
    title = Title;
    loadText = loadtext;
    [ProgressHUD show:loadtext];
    perView = false;
    [ProgressHUD setProcessValue:@""];
    return self;
}
-(id)initWithUrl:(NSString *)url postData:(NSString*)postData title:(NSString*)Title
{
    NSMutableURLRequest *request = [self getNSMutableURLRequestUsingPOSTMethodWithUrl:url postData:postData];
    connectoin = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    jsondata = [[NSMutableData alloc] init];
    loadView = false;
    title = Title;
    perView = false;
    [ProgressHUD setProcessValue:@""];
    return self;
}
-(NSMutableURLRequest*)getNSMutableURLRequestUsingPOSTMethodWithUrl:(NSString *)url postData:(NSString*)_postData
{
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:TIMEOUT_INTERVAL];
    [req setHTTPMethod:POST];
    [req addValue:URL_ENCODED forHTTPHeaderField:CONTENT_TYPE];
    [req setHTTPBody:[_postData dataUsingEncoding:NSUTF8StringEncoding]];
    return req;
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *errorInJsonParsing;
    if(jsondata)
    {
        
        id json = [NSJSONSerialization JSONObjectWithData:jsondata options:0 error:&errorInJsonParsing];
//         NSLog(@"%@",[[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding]);
        if(!errorInJsonParsing && [json isKindOfClass:[NSDictionary class]] && [json objectForKey:@"ErrorMessage"])
        {
            if([delegate respondsToSelector:@selector(didFailWithError:title:withConnection:)])
            {
                [delegate didFailWithError:json title:title withConnection:self];
            }
            if(loadView)
            {
                [ProgressHUD dismiss];
            }
        }
        else if(!errorInJsonParsing)
        {
            if(loadView)
            {
                [ProgressHUD dismiss];
                
            }
            if([delegate respondsToSelector:@selector(connectionDidFinishLoad:title:withConnection:)])
            {
                [delegate connectionDidFinishLoad:json title:title withConnection:self];
            }
        }
        else
        {
            if(loadView)
            {
                [ProgressHUD dismiss];
                
            }
            if([delegate respondsToSelector:@selector(didFailWithError:title:withConnection:)])
            {
                [delegate didFailWithError:errorInJsonParsing title:title withConnection:self];
            }
        }
    }
    else
    {
        if([delegate respondsToSelector:@selector(didFailWithError:title:withConnection:)])
        {
            [delegate didFailWithError:nil title:title withConnection:self];
        }
    }
}
-(void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    if(loadView && perView)
    {
        float per = ((float)totalBytesWritten / (float)totalBytesExpectedToWrite)*100.0;
        if(per > 99.0)
            per = 99.0;
        [ProgressHUD setProcessValue:[NSString stringWithFormat:@"%0.0f%%",per]];
    }
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if(loadView)
    {
        [ProgressHUD dismiss];
    }
    if([delegate respondsToSelector:@selector(didFailWithError:title:withConnection:)])
    {
        [delegate didFailWithError:error title:title withConnection:self];
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [jsondata appendData:data];
}
@end
