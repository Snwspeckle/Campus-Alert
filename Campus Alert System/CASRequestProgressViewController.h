//
//  CASRequestProgressViewController.h
//  Campus Alert System
//
//  Created by Anthony on 4/5/14.
//  Copyright (c) 2014 CAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "NetworkingManager.h"

@interface CASRequestProgressViewController : UIViewController <CLLocationManagerDelegate, NetworkingResponseHandler>
{
    NSString *latitude;
    NSString *longitude;
    NSString *SixTwo;
    NSString *Tel;
}

- (IBAction)btnRequestNow:(id)sender;
- (IBAction)btnCancelRequest:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnRequestNow;
@property (strong, nonatomic) IBOutlet UIView *viewTimer;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UILabel *lblTimer;

@property (retain, nonatomic) NSString *latitude;
@property (retain, nonatomic) NSString *longitude;

@property (strong, nonatomic) NSTimer *requestTimer;
@property (strong, nonatomic) NSTimer *gpsServerTimer;

@end
