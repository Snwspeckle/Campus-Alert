//
//  CASRequestHelpViewController.m
//  Campus Alert System
//
//  Created by Anthony on 4/5/14.
//  Copyright (c) 2014 CAS. All rights reserved.
//

#import "CASRequestHelpViewController.h"

@interface CASRequestHelpViewController ()
{
    CLLocationManager *locationManager;
    CLLocation *location;
    CLLocationCoordinate2D coordinate;
}

@end

@implementation CASRequestHelpViewController
@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[_btnRequestHelp layer] setMasksToBounds:NO];
    [[_btnRequestHelp layer] setShadowColor:[UIColor blackColor].CGColor];
    [[_btnRequestHelp layer] setShadowOpacity:0.5f];
    [[_btnRequestHelp layer] setShadowRadius:3.0f];
    [[_btnRequestHelp layer] setShadowOffset:CGSizeMake(0, 2)];
    
    [[mapView layer] setMasksToBounds:NO];
    [[mapView layer] setShadowColor:[UIColor blackColor].CGColor];
    [[mapView layer] setShadowOpacity:0.5f];
    [[mapView layer] setShadowRadius:3.0f];
    [[mapView layer] setShadowOffset:CGSizeMake(0, 2)];
    
    locationManager = [[CLLocationManager alloc] init];
    mapView.delegate = self;
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    mapView.showsUserLocation = YES;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnRequestHelp:(id)sender {
    
    coordinate = [self getLocation];
    CASRequestProgressViewController *requestProgressController = [self.storyboard instantiateViewControllerWithIdentifier:@"RequestProgressController"];
    
    NSString *passLatitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *passLongitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    
    requestProgressController.latitude = passLatitude;
    requestProgressController.longitude = passLongitude;
    
    [self presentModalViewController:requestProgressController animated:YES];
}

// Tells the locationManager delegate that the users location could not be updated
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

// Tells the locationManager delegate that a new location is available
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        
        // Zooms in when the user clicks the "Request a Ride" button
        [self.mapView setRegion:MKCoordinateRegionMake(currentLocation.coordinate, MKCoordinateSpanMake(0.010, 0.010)) animated:YES];
    }
    [locationManager stopUpdatingLocation];
}

-(CLLocationCoordinate2D) getLocation {
    location = [locationManager location];
    coordinate = [location coordinate];
    
    return coordinate;
}
@end
