//
//  ITunesMediaItemDetailViewController.m
//  Chart Toppers
//
//  Created by Vijay R. Gaonkar on 3/26/13.
//  Copyright (c) 2013 Vijay R. Gaonkar. All rights reserved.
//

#import "ITunesMediaItemDetailViewController.h"
#import "FavoritesManager.h"

#define TITLE_CELL          0
#define SUMMARY_CELL        2
#define TITLE_CELL_HEIGHT   112.0
#define SUMMARY_CELL_WIDTH  260.0
#define DEFAULT_CELL_HEIGHT 45.0
#define CELL_PADDING        20.0
#define BACKGROUND_IMAGE    @"3-oak-wood-background.jpg"

@interface ITunesMediaItemDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView             *artworkImage;
@property (weak, nonatomic) IBOutlet UILabel                 *appTitle;
@property (weak, nonatomic) IBOutlet UILabel                 *artist;
@property (weak, nonatomic) IBOutlet UIButton                *price;
@property (weak, nonatomic) IBOutlet UILabel                 *rank;
@property (weak, nonatomic) IBOutlet UILabel                 *category;
@property (weak, nonatomic) IBOutlet UILabel                 *released;
@property (weak, nonatomic) IBOutlet UITableViewCell         *titleCell;
@property (weak, nonatomic) IBOutlet UITextView              *summary;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UITableViewCell         *summaryCell;
@property (weak, nonatomic) IBOutlet UIButton                *favoriteButton;


@end

@implementation ITunesMediaItemDetailViewController

static NSString *directoryPath;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureDetailViewController];
    self.titleCell.backgroundColor  = nil;

    // set the background to custom image
    self.tableView.backgroundView   = nil;
    self.tableView.backgroundColor  = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND_IMAGE]];
    self.tableView.separatorColor   = [UIColor clearColor];
    self.tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated
{
    //set the favorite button image
    if ([[FavoritesManager sharedFavoritesManager] isFavorite:self.mediaItem]) {
        [self.favoriteButton setImage:[UIImage imageNamed:@"favorite.png"]
                             forState:UIControlStateNormal];
    }
    else {
        [self.favoriteButton setImage:[UIImage imageNamed:@"notFavorite.png"]
                             forState:UIControlStateNormal];
    }
}

- (IBAction)makeFavorite:(UIButton *)sender
{    
    if ([[FavoritesManager sharedFavoritesManager] isFavorite:self.mediaItem]) {
        [self.favoriteButton setImage:[UIImage imageNamed:@"notFavorite.png"]
                             forState:UIControlStateNormal];
        [[FavoritesManager sharedFavoritesManager] removeFavorite:self.mediaItem];
    }
    else {
        [self.favoriteButton setImage:[UIImage imageNamed:@"favorite.png"]
                             forState:UIControlStateNormal];
        [[FavoritesManager sharedFavoritesManager] addFavorite:self.mediaItem];
    }
    
    if (directoryPath == nil) {
        directoryPath = [self returnArchivePath];
    }
    
    NSString *archivePath = [directoryPath stringByAppendingPathComponent:@"Archive.txt"];
    [NSKeyedArchiver archiveRootObject:[[FavoritesManager sharedFavoritesManager] allFavorites] toFile:archivePath];
}


- (NSString *)returnArchivePath
{
    NSArray *path              = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *archiveDirectory = [path objectAtIndex:0];
    archiveDirectory           = [archiveDirectory stringByAppendingPathComponent:@"ArchivedFavorites"];
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:archiveDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    return archiveDirectory;
}


- (IBAction)buyItem:(id)sender {
    [[UIApplication sharedApplication]openURL:self.mediaItem.storeURL];
}


- (IBAction)shareApp:(UIBarButtonItem *)sender {
    NSArray *share = @[self.mediaItem.storeURL, self.mediaItem.artworkImage];
    UIActivityViewController *activityController = [[UIActivityViewController alloc]
                                                    initWithActivityItems:share
                                                    applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}


- (void)configureDetailViewController
{
    self.appTitle.text = self.mediaItem.title;
    self.artist.text   = self.mediaItem.artist;
    self.rank.text     = [NSString stringWithFormat:@"%d", self.mediaItem.rank];
    self.category.text = self.mediaItem.category;
    self.released.text = self.mediaItem.releaseDate;
    
    [self.price setTitle:self.mediaItem.price forState:UIControlStateSelected];
    [self.price setTitle:self.mediaItem.price forState:UIControlStateNormal];

    [self.spinner startAnimating];
    dispatch_queue_t imageDownloader = dispatch_queue_create("Get Image", NULL);
    dispatch_async(imageDownloader, ^{
        UIImage *image = [self.mediaItem artworkImage];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (image) {
                self.artworkImage.image = image;
            }
            //if network connectivity is lost while trying to fetch artwork image, show default artwork
            else {
                self.artworkImage.image = [UIImage imageNamed:@"defaultIcon.png"];
            }
        });
        [self.spinner stopAnimating];
    });
    
    //set the summary
    CGRect frame       = self.summary.frame;
    frame.size.height  = self.summary.contentSize.height;
    self.summary.frame = CGRectMake(0.0, 0.0, SUMMARY_CELL_WIDTH, frame.size.height);
    
    if (self.mediaItem.summary)
        self.summary.text = self.mediaItem.summary;
    else
        self.summaryCell.hidden = YES;
}


- (void)setMediaItem:(ITunesMediaItem *)mediaItem
{
    if (_mediaItem != mediaItem) {
        _mediaItem  = mediaItem;
    }
    [self configureDetailViewController];    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == TITLE_CELL) {
        return TITLE_CELL_HEIGHT;
    }
    
    else if (indexPath.section == SUMMARY_CELL) {
        return self.summary.contentSize.height + CELL_PADDING;
    }
    
    return DEFAULT_CELL_HEIGHT;
}

@end