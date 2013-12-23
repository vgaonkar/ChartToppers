//
//  MoviesTableViewController.m
//  Chart Toppers
//
//  Created by Vijay R. Gaonkar on 3/26/13.
//  Copyright (c) 2013 Vijay R. Gaonkar. All rights reserved.
//

#import "MoviesTableViewController.h"
#import "ITunesFetcher.h"

@interface MoviesTableViewController ()

@end

@implementation MoviesTableViewController

- (NSArray *)fetchMediaItems
{
    return [ITunesFetcher topMovies];
}

@end
