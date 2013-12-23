//
//  ITunesMediaItem.m
//  Chart Toppers
//
//  Created by Vijay R. Gaonkar on 3/21/13.
//  Copyright (c) 2013 Vijay R. Gaonkar. All rights reserved.
//

#import "ITunesMediaItem.h"
#import "NetworkActivityTracker.h"

#define TITLE        @"title"
#define CATEGORY     @"category"
#define ARTIST       @"artist"
#define RELEASE_DATE @"releaseDate"
#define PRICE        @"price"
#define ARTWORK_URL  @"artworkURL"
#define STORE_URL    @"storeURL"
#define RANK         @"rank"
#define SUMMARY      @"summary"

@implementation ITunesMediaItem

//since artworkImage is readonly
@synthesize artworkImage = _artworkImage;

- (UIImage *)artworkImage
{
    if (!_artworkImage) {
        if (self.artworkURL) {
            [[NetworkActivityTracker sharedInstance] showActivityIndicator];
            [NSThread sleepForTimeInterval:drand48() * 3.0];
            NSData *imageData = [[NSData alloc] initWithContentsOfURL:self.artworkURL];
            [[NetworkActivityTracker sharedInstance] hideActivityIndicator];
            _artworkImage     = [[UIImage alloc] initWithData:imageData];
        }
        else
            _artworkImage = [UIImage imageNamed:@"defaultIcon.png"];
    }
    
    return _artworkImage;
}


- (id)initWithJSONAttributes:(NSDictionary *)jsonAttributes
                        rank:(int)rank
{
    self = [super init];
    
    if (self){
        _title          = jsonAttributes[@"im:name"]          [@"label"];
        _category       = jsonAttributes[@"category"]       [@"attributes"] [@"label"];
        _artist         = jsonAttributes[@"im:artist"]      [@"label"];
        _releaseDate    = jsonAttributes[@"im:releaseDate"] [@"attributes"] [@"label"];
        _price          = jsonAttributes[@"im:price"]       [@"label"];
        _artworkURL     = [NSURL URLWithString:[[[jsonAttributes objectForKey:@"im:image"] objectAtIndex:2] objectForKey:@"label"]];
        _storeURL       = [NSURL URLWithString:jsonAttributes [@"id"][@"label"]];
        _rank           = rank;
        _summary        = jsonAttributes[@"summary"] [@"label"];
    }
    return self;
}


- (BOOL)isEqual:(ITunesMediaItem *)otherItem
{
    return [self.storeURL isEqual:otherItem.storeURL];
}


- (NSUInteger)hash
{
    return [[self storeURL] hash];
}


- (void)encodeWithCoder:(NSCoder *)encode
{
    [encode encodeObject:self.title       forKey:TITLE];
    [encode encodeObject:self.category    forKey:CATEGORY];
    [encode encodeObject:self.artist      forKey:ARTIST];
    [encode encodeObject:self.releaseDate forKey:RELEASE_DATE];
    [encode encodeObject:self.price       forKey:PRICE];
    [encode encodeObject:self.artworkURL  forKey:ARTWORK_URL];
    [encode encodeObject:self.storeURL    forKey:STORE_URL];
    [encode    encodeInt:self.rank        forKey:RANK];
    [encode encodeObject:self.summary     forKey:SUMMARY];

}


- (id)initWithCoder:(NSCoder *)decode
{
    _title       = [decode decodeObjectForKey:TITLE];
    _category    = [decode decodeObjectForKey:CATEGORY];
    _artist      = [decode decodeObjectForKey:ARTIST];
    _releaseDate = [decode decodeObjectForKey:RELEASE_DATE];
    _price       = [decode decodeObjectForKey:PRICE];
    _artworkURL  = [decode decodeObjectForKey:ARTWORK_URL];
    _storeURL    = [decode decodeObjectForKey:STORE_URL];
    _rank        = [decode    decodeIntForKey:RANK];
    _summary     = [decode decodeObjectForKey:SUMMARY];

    return self;
}


@end
