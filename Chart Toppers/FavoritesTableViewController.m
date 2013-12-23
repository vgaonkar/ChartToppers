//
//  FavoritesTableViewController.m
//  Chart Toppers
//
//  Created by Vijay R. Gaonkar on 4/17/13.
//  Copyright (c) 2013 Vijay R. Gaonkar. All rights reserved.
//

#import "FavoritesTableViewController.h"
#import "FavoritesManager.h"

@interface FavoritesTableViewController ()

@end

@implementation FavoritesTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.chartToppers = [self fetchMediaItems];
}

- (NSArray *)fetchMediaItems
{
    return [[FavoritesManager sharedFavoritesManager] allFavorites];
}

@end
