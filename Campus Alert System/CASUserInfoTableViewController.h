//
//  CASUserInfoTableViewController.h
//  Campus Alert System
//
//  Created by Anthony on 4/6/14.
//  Copyright (c) 2014 CAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CASUserInfoTableViewController : UITableViewController
- (IBAction)btnSave:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtCLS;
@property (strong, nonatomic) IBOutlet UITextField *txtFirstName;
@property (strong, nonatomic) IBOutlet UITextField *txtLastName;
@property (strong, nonatomic) IBOutlet UITextField *txtPhone;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;

@end
