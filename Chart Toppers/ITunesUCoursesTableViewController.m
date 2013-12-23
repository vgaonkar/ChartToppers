//
//  ITunesUCoursesTableViewController.m
//  Chart Toppers
//
//  Created by Vijay R. Gaonkar on 3/26/13.
//  Copyright (c) 2013 Vijay R. Gaonkar. All rights reserved.
//

#import "ITunesUCoursesTableViewController.h"
#import "ITunesFetcher.h"

@interface ITunesUCoursesTableViewController ()

@end

@implementation ITunesUCoursesTableViewController

- (NSArray *)fetchMediaItems
{
    return [ITunesFetcher topITunesUCourses];
}

@end
