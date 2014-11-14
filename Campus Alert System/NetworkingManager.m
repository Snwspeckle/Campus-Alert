//
//  NetworkingManager.m
//  NightRide
//
//  Created by Anthony on 1/27/14.
//  Copyright (c) 2014 NightRide. All rights reserved.
//

#import "NetworkingManager.h"
#import <AFNetworking.h>

@implementation NetworkingManager

+ (void)sendDictionary:(NSDictionary *)dictionary responseHandler:(id<NetworkingResponseHandler>)responseHandler {
		
	NSDictionary *message = [dictionary copy];
		
	// Sends request to server to login, server sends response via JSON
    NSURL *URL = [NSURL URLWithString:@"http://nightride.edu.arvixe.com/NightRide/"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:URL];
    [manager POST:@"login" parameters:message success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [responseHandler networkingResponseReceived:responseObject ForMessage:message];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [responseHandler networkingResponseFailedForMessage:message error:error];
    }];
}
@end