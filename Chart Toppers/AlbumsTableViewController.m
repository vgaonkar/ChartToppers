//
//  AlbumsTableViewController.m
//  Chart Toppers
//
//  Created by Vijay R. Gaonkar on 3/26/13.
//  Copyright (c) 2013 Vijay R. Gaonkar. All rights reserved.
//

#import "AlbumsTableViewController.h"
#import "ITunesFetcher.h"

@interface AlbumsTableViewController ()

@end

@implementation AlbumsTableViewController

- (NSArray *)fetchMediaItems
{
    return [ITunesFetcher topAlbums];
}

@end
