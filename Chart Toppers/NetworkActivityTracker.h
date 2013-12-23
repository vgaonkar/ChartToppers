//
//  NetworkActivityTracker.h
//  Chart Toppers
//
//  Created by Vijay R. Gaonkar on 4/12/13.
//  Copyright (c) 2013 Vijay R. Gaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkActivityTracker : NSObject

+ (NetworkActivityTracker *)sharedInstance;

- (void)showActivityIndicator;
- (void)hideActivityIndicator;

@end
