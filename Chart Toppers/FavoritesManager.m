//
//  FavoritesManager.m
//  Chart Toppers
//
//  Created by Vijay R. Gaonkar on 4/15/13.
//  Copyright (c) 2013 Vijay R. Gaonkar. All rights reserved.
//

#import "FavoritesManager.h"

@interface FavoritesManager()

@property (strong, nonatomic) NSMutableSet *favoriteMediaItems;

@end


@implementation FavoritesManager

-(NSMutableSet *)favoriteMediaItems
{
    if (!_favoriteMediaItems) {        
        NSArray *path              = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *archiveDirectory = [path objectAtIndex:0];
        archiveDirectory           = [archiveDirectory stringByAppendingPathComponent:@"ArchivedFavorites"];
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:archiveDirectory
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&error];
        NSString *archivePath      = [archiveDirectory stringByAppendingPathComponent:@"Archive.txt"];
        NSArray  *mediaItems       = [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
        
        _favoriteMediaItems = [[NSMutableSet alloc] initWithArray:mediaItems];
    }
    return _favoriteMediaItems;
}

+ (FavoritesManager *)sharedFavoritesManager
{
    static FavoritesManager *sharedFavoritesManager;
    
    static dispatch_once_t favoritesToken;
    dispatch_once(&favoritesToken, ^{
        sharedFavoritesManager = [[FavoritesManager alloc] init];
    });
    return sharedFavoritesManager;
}

- (void)addFavorite:(ITunesMediaItem *)mediaItem
{
    [[FavoritesManager sharedFavoritesManager].favoriteMediaItems addObject:mediaItem];
}

- (void)removeFavorite:(ITunesMediaItem *)mediaItem
{
    [[FavoritesManager sharedFavoritesManager].favoriteMediaItems removeObject:mediaItem];
}

- (BOOL)isFavorite:(ITunesMediaItem *)mediaItem
{
    return [self.favoriteMediaItems containsObject:mediaItem];
}

- (NSArray *)allFavorites
{
    return [[FavoritesManager sharedFavoritesManager].favoriteMediaItems allObjects];
}

@end
