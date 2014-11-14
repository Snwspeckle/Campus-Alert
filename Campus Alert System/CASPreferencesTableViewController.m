//
//  CASPreferencesTableViewController.m
//  Campus Alert System
//
//  Created by Anthony on 4/6/14.
//  Copyright (c) 2014 CAS. All rights reserved.
//

#import "CASPreferencesTableViewController.h"

@interface CASPreferencesTableViewController ()

@end

@implementation CASPreferencesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cellClicked = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cellClicked == _cellCallUCPD) {
        NSURL *phoneURLNightRide = [NSURL URLWithString:@"telprompt://513-5567433"];
        [[UIApplication sharedApplication] openURL:phoneURLNightRide];
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    }
}

@end
