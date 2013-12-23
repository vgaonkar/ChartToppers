//
//  ITunesMediaItem.h
//  Chart Toppers
//
//  Created by Vijay R. Gaonkar on 3/21/13.
//  Copyright (c) 2013 Vijay R. Gaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITunesMediaItem : NSObject <NSCoding>

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *category;
@property (nonatomic, readonly) NSString *artist;
@property (nonatomic, readonly) NSString *releaseDate;
@property (nonatomic, readonly) NSString *price;
@property (nonatomic, readonly) NSURL    *artworkURL;
@property (nonatomic, readonly) UIImage  *artworkImage;
@property (nonatomic, readonly) NSURL    *storeURL;
@property (nonatomic, readonly) int       rank;
@property (nonatomic, readonly) NSString *summary;

- (id)initWithJSONAttributes:(NSDictionary *)jsonAttributes
                        rank:(int)rank;

@end
