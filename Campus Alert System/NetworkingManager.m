//
//  NetworkingManager.m
//  Campus Alert System
//
//  Created by Anthony on 1/27/14.
//  Copyright (c) 2014 Campus Alert System. All rights reserved.
//

#import "NetworkingManager.h"
#import "AFNetworking.h"

@implementation NetworkingManager

+ (void)sendDictionary:(NSDictionary *)dictionary responseHandler:(id<NetworkingResponseHandler>)responseHandler {
		
	NSDictionary *message = [dictionary copy];
		
	// Sends request to server to login, server sends response via JSON
    NSURL *URL = [NSURL URLWithString:@"http://10.90.2.49/MapServer/"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:URL];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:@"sendLocation" parameters:message success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [responseHandler networkingResponseReceived:responseObject ForMessage:message];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [responseHandler networkingResponseFailedForMessage:message error:error];
    }];
}
@end