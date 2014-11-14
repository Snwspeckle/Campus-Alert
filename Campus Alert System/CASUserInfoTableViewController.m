//
//  CASUserInfoTableViewController.m
//  Campus Alert System
//
//  Created by Anthony on 4/6/14.
//  Copyright (c) 2014 CAS. All rights reserved.
//

#import "CASUserInfoTableViewController.h"

@interface CASUserInfoTableViewController ()

@end

@implementation CASUserInfoTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self populateUserInfo];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)populateUserInfo
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    _txtCLS.text = [prefs objectForKey:@"CLS"];
    _txtFirstName.text = [prefs objectForKey:@"firstName"];
    _txtLastName.text = [prefs objectForKey:@"lastName"];
    _txtEmail.text = [prefs objectForKey:@"email"];
    _txtPhone.text = [prefs objectForKey:@"phone"];
}

- (IBAction)btnSave:(id)sender {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:_txtCLS.text forKey:@"CLS"];
    [prefs setObject:_txtFirstName.text forKey:@"firstName"];
    [prefs setObject:_txtLastName.text forKey:@"lastName"];
    [prefs setObject:_txtEmail.text forKey:@"email"];
    [prefs setObject:_txtPhone.text forKey:@"phone"];
    
    [self populateUserInfo];
    
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
