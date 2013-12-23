//
//  ITunesMediaItemTableViewCell.h
//  Chart Toppers
//
//  Created by Vijay R. Gaonkar on 3/21/13.
//  Copyright (c) 2013 Vijay R. Gaonkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITunesMediaItemTableViewCell : UITableViewCell
 
@property (weak, nonatomic) IBOutlet UILabel                 *mediaItemTitle;
@property (weak, nonatomic) IBOutlet UILabel                 *mediaItemArtist;
@property (weak, nonatomic) IBOutlet UILabel                 *mediaItemRank;
@property (weak, nonatomic) IBOutlet UIImageView             *mediaItemImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end
