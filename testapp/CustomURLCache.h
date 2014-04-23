//
//  CustomURLCache.h
//  myCard
//
//  Created by TNM_ios2 on 14/03/14.
//  Copyright (c) 2014 TNM_ios2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomURLCache : NSURLCache
+(CustomURLCache *)activate;
-(NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request;
- (void)storeCachedResponse:(NSCachedURLResponse *)cachedResponse forRequest:(NSURLRequest *)request;
@end
