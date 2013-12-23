//
//  ITunesMediaItemDetailViewController.h
//  Chart Toppers
//
//  Created by Vijay R. Gaonkar on 3/26/13.
//  Copyright (c) 2013 Vijay R. Gaonkar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITunesMediaItem.h"

@interface ITunesMediaItemDetailViewController : UITableViewController <UITableViewDelegate>

@property (strong, nonatomic) ITunesMediaItem       *mediaItem;

@end
