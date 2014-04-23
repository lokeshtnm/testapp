//
//  CustomURLCache.m
//  myCard
//
//  Created by TNM_ios2 on 14/03/14.
//  Copyright (c) 2014 TNM_ios2. All rights reserved.
//

#import "CustomURLCache.h"

NSString * const EXPIRES_KEY = @"cache date";
int const CACHE_EXPIRES = -60;

@implementation CustomURLCache

// static method for activating this custom cache
+(CustomURLCache *)activate {
    CustomURLCache *urlCache = [[CustomURLCache alloc] initWithMemoryCapacity:(200*1024*1024) diskCapacity:(200*1024*1024) diskPath:@"nsurlcache"] ;
    [NSURLCache setSharedURLCache:urlCache];
    return urlCache;
}

-(NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request {
    NSCachedURLResponse * cachedResponse = [super cachedResponseForRequest:request];
    if (cachedResponse) {
        NSDate* cacheDate = [[cachedResponse userInfo] objectForKey:EXPIRES_KEY];
        NSLog(@"Catch Time: %f - %d",[cacheDate timeIntervalSinceNow] ,CACHE_EXPIRES);
        if ([cacheDate timeIntervalSinceNow] < CACHE_EXPIRES) {
            [self removeCachedResponseForRequest:request];
            cachedResponse = nil;
        }
    }
    
    return cachedResponse;
}

- (void)storeCachedResponse:(NSCachedURLResponse *)cachedResponse forRequest:(NSURLRequest *)request {
    NSMutableDictionary *userInfo = cachedResponse.userInfo ? [cachedResponse.userInfo mutableCopy] : [NSMutableDictionary dictionary];
    [userInfo setObject:[NSDate date] forKey:EXPIRES_KEY];
    NSCachedURLResponse *newCachedResponse = [[NSCachedURLResponse alloc] initWithResponse:cachedResponse.response data:cachedResponse.data userInfo:userInfo storagePolicy:cachedResponse.storagePolicy];
    
    [super storeCachedResponse:newCachedResponse forRequest:request];
}
/*
 -(void)FunctionPerform:(NSCachedURLResponse*)cachedResponse
 {
 [self connection:nil didReceiveResponse:[cachedResponse response]];
 [self connection:nil didReceiveData:[cachedResponse data]];
 [self connectionDidFinishLoading:nil];
 }
 NSCachedURLResponse *cachedResponse = [[CustomURLCache activate] cachedResponseForRequest:request];
 if (cachedResponse) {
 [self performSelector:@selector(FunctionPerform:) withObject:cachedResponse afterDelay:0.2f];
 } else {
 connectoin = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
 }
 */
@end
