//
//  TVEpisodesTableViewController.m
//  Chart Toppers
//
//  Created by Vijay R. Gaonkar on 3/26/13.
//  Copyright (c) 2013 Vijay R. Gaonkar. All rights reserved.
//

#import "TVEpisodesTableViewController.h"
#import "ITunesFetcher.h"

@interface TVEpisodesTableViewController ()

@end

@implementation TVEpisodesTableViewController

- (NSArray *)fetchMediaItems
{
    return [ITunesFetcher topTVEpisodes];
}

@end
