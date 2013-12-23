//
//  NetworkActivityTracker.m
//  Chart Toppers
//
//  Created by Vijay R. Gaonkar on 4/12/13.
//  Copyright (c) 2013 Vijay R. Gaonkar. All rights reserved.
//

#import "NetworkActivityTracker.h"

@implementation NetworkActivityTracker

int counter;

+ (NetworkActivityTracker *)sharedInstance
{
    static NetworkActivityTracker *sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkActivityTracker alloc] init];
    });
    return sharedInstance;
}

- (void)showActivityIndicator
{
    if (counter == 0) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
    counter++;
}

- (void)hideActivityIndicator
{
    counter--;
    if (counter == 0) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}

@end
