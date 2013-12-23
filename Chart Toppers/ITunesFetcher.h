//
//  ITunesFetcher.h
//  Chart Toppers
//
//  Created by Vijay R. Gaonkar on 3/21/13.
//  Copyright (c) 2013 Vijay R. Gaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MEDIA_ITEM_TITLE    @"_title"
#define MEDIA_ITEM_ARTIST   @"_artist"
#define MEDIA_ITEM_RANK     @"_rank"


@interface ITunesFetcher : NSObject

+ (NSArray *)topFreeApps;
+ (NSArray *)topAlbums;
+ (NSArray *)topPaidBooks;
+ (NSArray *)topMovies;
+ (NSArray *)topTVEpisodes;
+ (NSArray *)topITunesUCourses;

@end
