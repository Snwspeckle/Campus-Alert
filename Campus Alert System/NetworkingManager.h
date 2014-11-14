//
//  NetworkingManager.h
//  Campus Alert System
//
//  Created by Anthony on 1/27/14.
//  Copyright (c) 2014 Campus Alert System. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkingResponseHandler <NSObject>

- (void)networkingResponseReceived:(id)response ForMessage:(NSDictionary *)message;
- (void)networkingResponseFailedForMessage:(NSDictionary *)message error:(NSError *)error;

@end

@interface NetworkingManager : NSObject

+ (void)sendDictionary:(NSDictionary *)dictionary responseHandler:(id<NetworkingResponseHandler>)responseHandler;

@end
