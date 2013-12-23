//
//  BooksTableViewController.m
//  Chart Toppers
//
//  Created by Vijay R. Gaonkar on 3/26/13.
//  Copyright (c) 2013 Vijay R. Gaonkar. All rights reserved.
//

#import "BooksTableViewController.h"
#import "ITunesFetcher.h"

@interface BooksTableViewController ()

@end

@implementation BooksTableViewController

- (NSArray *)fetchMediaItems
{
    return [ITunesFetcher topPaidBooks];
}

@end
