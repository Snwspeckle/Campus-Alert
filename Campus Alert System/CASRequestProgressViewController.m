//
//  CASRequestProgressViewController.m
//  Campus Alert System
//
//  Created by Anthony on 4/5/14.
//  Copyright (c) 2014 CAS. All rights reserved.
//

#import "CASRequestProgressViewController.h"

@interface CASRequestProgressViewController ()
{
    CLLocationManager *locationManager;
    CLLocation *location;
    CLLocationCoordinate2D coordinate;
}

@end

@implementation CASRequestProgressViewController
@synthesize latitude, longitude;

int counterRequestTimer = 9;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [[_viewTimer layer] setMasksToBounds:NO];
    [[_viewTimer layer] setShadowColor:[UIColor blackColor].CGColor];
    [[_viewTimer layer] setShadowOpacity:0.5f];
    [[_viewTimer layer] setShadowRadius:3.0f];
    [[_viewTimer layer] setShadowOffset:CGSizeMake(0, 2)];
    
    [[_btnRequestNow layer] setMasksToBounds:NO];
    [[_btnRequestNow layer] setShadowColor:[UIColor blackColor].CGColor];
    [[_btnRequestNow layer] setShadowOpacity:0.5f];
    [[_btnRequestNow layer] setShadowRadius:3.0f];
    [[_btnRequestNow layer] setShadowOffset:CGSizeMake(0, 2)];

    [[_btnCancel layer] setMasksToBounds:NO];
    [[_btnCancel layer] setShadowColor:[UIColor blackColor].CGColor];
    [[_btnCancel layer] setShadowOpacity:0.5f];
    [[_btnCancel layer] setShadowRadius:3.0f];
    [[_btnCancel layer] setShadowOffset:CGSizeMake(0, 2)];
    
    locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];

}
- (void)viewDidAppear:(BOOL)animated
{
    _requestTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateRequestTimeLabel:) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnRequestNow:(id)sender {
    
    counterRequestTimer = 0;
    [self contactServer];
}

- (IBAction)btnCancelRequest:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [_requestTimer invalidate];
    [_gpsServerTimer invalidate];
    counterRequestTimer = 9;
}

- (void)updateRequestTimeLabel:(id)sender
{
    if (counterRequestTimer >= 0) {
        NSMutableString *stringFormatted = [NSMutableString stringWithFormat:@"00:0%d", counterRequestTimer];
        _lblTimer.text = stringFormatted;
        NSLog(@"TIMER VALUE%d", counterRequestTimer);
        counterRequestTimer--;
    } else {
        
        [self contactServer];
    }
}

- (void)updateUserLocation:(id)sender
{
    coordinate = [self getLocation];
    latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    SixTwo = [[NSUserDefaults standardUserDefaults] objectForKey:@"CLS"];
    NSString *firstName = [[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"];
    NSString *lastName = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastName"];
    NSString *preFirstName = [firstName stringByAppendingString:@" "];
    NSString *Name = [preFirstName stringByAppendingString:lastName];
    NSString *Email = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
    Tel = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    
    // DATA PARAMETERS IN JSON FORM
    NSDictionary *params = @{@"lat" :latitude,
                             @"lon" :longitude,
                             @"SixTwo" :SixTwo,
                             @"Name" :Name,
                             @"Email" :Email,
                             @"Tel" :Tel};
    
    // DATA PARAMETERS IN POST FORM
    /*NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            latitude, @"lat",
                            longitude, @"lon",
                            SixTwo, @"SixTwo",
                            Name, @"Name",
                            Email, @"Email",
                            Tel, @"Tel",
                            nil];*/
    
    NSLog(@"PARAMS%@", params);
    
    [NetworkingManager sendDictionary:params responseHandler:self];
}

- (void)contactServer
{
    _lblTimer.text = @"Alerted UCPD";
    [_btnRequestNow setEnabled:NO];
    [_requestTimer invalidate];
    counterRequestTimer = 9;
    
    _gpsServerTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(updateUserLocation:) userInfo:nil repeats:YES];
}

- (void)networkingResponseReceived:(id)response ForMessage:(NSDictionary *)message {
	
	NSLog(@"Latitude: %@", [response valueForKeyPath:@"lat"]);
    NSLog(@"Longitude: %@", [response valueForKeyPath:@"lon"]);
	NSLog(@"Error: %@", [response valueForKeyPath:@"error"]);
	
    NSNumber *errorNumber = (NSNumber *)[response valueForKeyPath:@"error"];
	if ([errorNumber boolValue] == FALSE) {
        
        NSLog(@"HANDSHAKE SUCCESS");
        
	} else {
		UIAlertView *loginAlert = [[UIAlertView alloc] initWithTitle:@"Error Logging In" message:@"Invalid email or password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		
		[loginAlert show];
	}
}

- (void)networkingResponseFailedForMessage:(NSDictionary *)message error:(NSError *)error {
    
	UIAlertView *loginAlert = [[UIAlertView alloc] initWithTitle:@"Error Loading Game Data" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[loginAlert show];
    
	NSLog(@"Error with request");
	NSLog(@"%@", [error localizedDescription]);
}

-(CLLocationCoordinate2D) getLocation {
    location = [locationManager location];
    coordinate = [location coordinate];
    
    return coordinate;
}
@end
