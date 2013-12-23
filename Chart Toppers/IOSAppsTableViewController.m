//
//  IOSAppsTableViewController.m
//  Chart Toppers
//
//  Created by Vijay R. Gaonkar on 3/26/13.
//  Copyright (c) 2013 Vijay R. Gaonkar. All rights reserved.
//

#import "IOSAppsTableViewController.h"
#import "ITunesFetcher.h"

@interface IOSAppsTableViewController ()

@end

@implementation IOSAppsTableViewController

- (NSArray *)fetchMediaItems
{
    return [ITunesFetcher topFreeApps];
}

@end
