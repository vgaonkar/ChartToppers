//
//  ITunesFetcher.m
//  Chart Toppers
//
//  Created by Vijay R. Gaonkar on 3/21/13.
//  Copyright (c) 2013 Vijay R. Gaonkar. All rights reserved.
//

#import "ITunesFetcher.h"
#import "ITunesMediaItem.h"
#import "NetworkActivityTracker.h"

#define TOP_FREE_APPS       @"http://itunes.apple.com/us/rss/topfreeapplications/limit=100/json"
#define TOP_ALBUMS          @"http://itunes.apple.com/us/rss/topalbums/limit=100/json"
#define TOP_PAID_BOOKS      @"http://itunes.apple.com/us/rss/toppaidebooks/limit=100/json"
#define TOP_MOVIES          @"http://itunes.apple.com/us/rss/topmovies/limit=100/json"
#define TOP_TV_EPISODES     @"http://itunes.apple.com/us/rss/toptvepisodes/limit=100/json"
#define TOP_ITUNESU_COURSES @"http://itunes.apple.com/us/rss/topitunesucourses/limit=100/json"

@implementation ITunesFetcher


+ (NSArray *)mediaItems:(NSString *)urlString
{
    NSURL   *url = [[NSURL alloc] initWithString:urlString];
    NSError *error;
    
    [[NetworkActivityTracker sharedInstance] showActivityIndicator];
    [NSThread sleepForTimeInterval:drand48() * 3.0];
    NSData *rawJSON = [[NSData alloc] initWithContentsOfURL:url];
    [[NetworkActivityTracker sharedInstance] hideActivityIndicator];
    
    //if no network, return nil
    if (!rawJSON) {
        return nil;
    }
    
    NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:rawJSON
                                                               options:0
                                                                 error:&error];
    if (error) {
        NSLog(@"JSON parsing error: %@", error);
    }
    
    NSArray *entries              = [[parsedJSON valueForKey:@"feed"] valueForKey:@"entry"];
    NSMutableArray *appAttributes = [[NSMutableArray alloc]init];
    
    for (NSUInteger index = 0; index < entries.count; index++) {
        NSDictionary *jsonAttributes = entries [index];
        ITunesMediaItem *mediaItem   = [[ITunesMediaItem alloc]initWithJSONAttributes:jsonAttributes
                                                                               rank:index + 1];
        [appAttributes addObject:mediaItem];
    }
    
    NSArray *mediaItems = [appAttributes copy];
    return mediaItems;
}


+ (NSArray *)topFreeApps
{
    return [self mediaItems:TOP_FREE_APPS];
}


+ (NSArray *)topAlbums
{
    return [self mediaItems:TOP_ALBUMS];
}


+ (NSArray *)topPaidBooks
{
    return [self mediaItems:TOP_PAID_BOOKS];
}


+ (NSArray *)topMovies
{
    return [self mediaItems:TOP_MOVIES];
}


+ (NSArray *)topTVEpisodes
{
    return [self mediaItems:TOP_TV_EPISODES];
}


+ (NSArray *)topITunesUCourses
{
    return [self mediaItems:TOP_ITUNESU_COURSES];
}


@end
