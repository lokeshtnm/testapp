//
//  UrlConnection.h
//  GLImageProcessing
//
//  Created by TNM_ios2 on 11/04/14.
//
//

#import <Foundation/Foundation.h>

@interface UrlBlockConnection : NSObject<NSURLConnectionDataDelegate>

typedef void (^didFailBlock)(NSError* error);
typedef void (^didCompleteConnection)(NSMutableData* tData);
typedef void (^didDataReceive)(NSMutableData* tData);

@property (strong,nonatomic) didFailBlock failBlock;
@property (strong,nonatomic) didCompleteConnection completeConnectionBlock;
@property (strong,nonatomic) didDataReceive dataReceiveBlock;
@property (strong,nonatomic) NSMutableData *tData;
@property (strong,nonatomic) NSURLConnection *connection;

-(id)initWithConnectionWithUrl:(NSString*)strurl didFailBlock:(didFailBlock)failblock didCompleteConnection:(didCompleteConnection)completeConnectionblock;

-(id)initWithConnectionWithUrl:(NSString*)strurl didFailBlock:(didFailBlock)failblock didCompleteConnection:(didCompleteConnection)completeConnectionblock didDataReceive:(didDataReceive)dataReceiveblock;

-(id)initWithConnectionWithUrl:(NSString*)strurl postdata:(NSString*)postdata didFailBlock:(didFailBlock)failblock didCompleteConnection:(didCompleteConnection)completeConnectionblock;

-(id)initWithConnectionWithUrl:(NSString*)strurl postdata:(NSString*)postdata didFailBlock:(didFailBlock)failblock didCompleteConnection:(didCompleteConnection)completeConnectionblock didDataReceive:(didDataReceive)dataReceiveblock;
@end
