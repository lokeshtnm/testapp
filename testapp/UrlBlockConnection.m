//
//  UrlConnection.m
//  GLImageProcessing
//
//  Created by TNM_ios2 on 11/04/14.
//
//

#import "UrlBlockConnection.h"
#import "CustomURLCache.h"
#define TIMEOUT_INTERVAL 30
#define CONTENT_TYPE @"Content-Type"
#define URL_ENCODED @"application/x-www-form-urlencoded"
#define POST @"POST"
@implementation UrlBlockConnection
-(id)initWithConnectionWithUrl:(NSString*)strurl didFailBlock:(didFailBlock)failblock didCompleteConnection:(didCompleteConnection)completeConnectionblock
{
    self = [super init];
    if (self) {
        self.failBlock = failblock;
        self.completeConnectionBlock = completeConnectionblock;
        NSMutableURLRequest *request = [self getNSMutableURLRequestUsingPOSTMethodWithUrl:strurl postData:nil];
        [NSURLProtocol setProperty:@YES forKey:@"CacheSet" inRequest:request];
        NSCachedURLResponse *cachedResponse = [[CustomURLCache activate] cachedResponseForRequest:request];
        if (cachedResponse) {
            [self performSelector:@selector(FunctionPerform:) withObject:cachedResponse afterDelay:0.2f];
        } else {
            self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
            [self.connection start];
        }
        self.tData = [[NSMutableData alloc] init];
    }
    return self;
}
-(id)initWithConnectionWithUrl:(NSString*)strurl didFailBlock:(didFailBlock)failblock didCompleteConnection:(didCompleteConnection)completeConnectionblock didDataReceive:(didDataReceive)dataReceiveblock
{
    self = [super init];
    if (self) {
        self.failBlock = failblock;
        self.completeConnectionBlock = completeConnectionblock;
        self.dataReceiveBlock = dataReceiveblock;
        NSMutableURLRequest *request = [self getNSMutableURLRequestUsingPOSTMethodWithUrl:strurl postData:@""];
        [NSURLProtocol setProperty:@YES forKey:@"CacheSet" inRequest:request];
        NSCachedURLResponse *cachedResponse = [[CustomURLCache activate] cachedResponseForRequest:request];
        if (cachedResponse) {
            [self performSelector:@selector(FunctionPerform:) withObject:cachedResponse afterDelay:0.2f];
        } else {
            self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
            [self.connection start];
        }
        self.tData = [[NSMutableData alloc] init];
    }
    return self;
}//postdata:(NSString*)postdata
-(id)initWithConnectionWithUrl:(NSString*)strurl postdata:(NSString*)postdata didFailBlock:(didFailBlock)failblock didCompleteConnection:(didCompleteConnection)completeConnectionblock
{
    self = [super init];
    if (self) {
        self.failBlock = failblock;
        self.completeConnectionBlock = completeConnectionblock;
        NSMutableURLRequest *request = [self getNSMutableURLRequestUsingPOSTMethodWithUrl:strurl postData:postdata];
        [NSURLProtocol setProperty:@YES forKey:@"CacheSet" inRequest:request];
        NSCachedURLResponse *cachedResponse = [[CustomURLCache activate] cachedResponseForRequest:request];
        if (cachedResponse) {
            [self performSelector:@selector(FunctionPerform:) withObject:cachedResponse afterDelay:0.2f];
        } else {
            self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
            [self.connection start];
        }
        self.tData = [[NSMutableData alloc] init];
    }
    return self;
}
-(id)initWithConnectionWithUrl:(NSString*)strurl postdata:(NSString*)postdata didFailBlock:(didFailBlock)failblock didCompleteConnection:(didCompleteConnection)completeConnectionblock didDataReceive:(didDataReceive)dataReceiveblock
{
    self = [super init];
    if (self) {
        self.failBlock = failblock;
        self.completeConnectionBlock = completeConnectionblock;
        self.dataReceiveBlock = dataReceiveblock;
        NSMutableURLRequest *request = [self getNSMutableURLRequestUsingPOSTMethodWithUrl:strurl postData:postdata];
        [NSURLProtocol setProperty:@YES forKey:@"CacheSet" inRequest:request];
        NSCachedURLResponse *cachedResponse = [[CustomURLCache activate] cachedResponseForRequest:request];
        if (cachedResponse) {
            [self performSelector:@selector(FunctionPerform:) withObject:cachedResponse afterDelay:0.2f];
        } else {
            self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
            [self.connection start];
        }
        self.tData = [[NSMutableData alloc] init];
    }
    return self;
}
-(void)FunctionPerform:(NSCachedURLResponse*)cachedResponse
{
    [self connection:nil didReceiveResponse:[cachedResponse response]];
    [self connection:nil didReceiveData:[cachedResponse data]];
    [self connectionDidFinishLoading:nil];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (self.failBlock) {
        self.failBlock(error);
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.tData appendData:data];
    if (self.dataReceiveBlock) {
        self.dataReceiveBlock(self.tData);
    }
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (self.completeConnectionBlock) {
        self.completeConnectionBlock(self.tData);
    }
    
}
-(NSMutableURLRequest*)getNSMutableURLRequestUsingPOSTMethodWithUrl:(NSString *)url postData:(NSString*)_postData
{
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:TIMEOUT_INTERVAL];
    [req setHTTPMethod:POST];
    [req addValue:URL_ENCODED forHTTPHeaderField:CONTENT_TYPE];
    [req setHTTPBody:[_postData dataUsingEncoding:NSUTF8StringEncoding]];
    return req;
}
@end
