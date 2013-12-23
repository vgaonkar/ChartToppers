//
//  iTunesMediaItemsTableViewController.m
//  Chart Toppers
//
//  Created by Vijay R. Gaonkar on 3/26/13.
//  Copyright (c) 2013 Vijay R. Gaonkar. All rights reserved.
//

#import "ITunesMediaItemsTableViewController.h"
#import "ITunesMediaItemTableViewCell.h"
#import "ITunesFetcher.h"
#import "ITunesMediaItemDetailViewController.h"

#define NETWORK_ERROR    @"Network Error"
#define MESSAGE          @"A network connection cannot be detected. Please confirm that you have an active network connection and try again."
#define CANCEL_BUTTON    @"OK"
#define BACKGROUND_IMAGE @"3-oak-wood-background.jpg"


@interface ITunesMediaItemsTableViewController ()

@end

@implementation ITunesMediaItemsTableViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor        = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND_IMAGE]];
    dispatch_queue_t fetchMediaItems = dispatch_queue_create("Fetch Media Items", NULL);
    dispatch_async(fetchMediaItems, ^{
        NSArray *temparray = [self fetchMediaItems];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.chartToppers = temparray;
        });
    });
    //pull to refresh
    [self.refreshControl addTarget:self
                            action:@selector(refresh)
                  forControlEvents:UIControlEventValueChanged];
}


- (IBAction)refresh
{
    //show the spinner if its not already showing
    [self.refreshControl beginRefreshing];
    dispatch_queue_t refreshQueue = dispatch_queue_create("Refresh Table View", NULL);
    dispatch_async(refreshQueue, ^{
        NSArray *temparray = [self fetchMediaItems];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.chartToppers = temparray;
            [self.refreshControl endRefreshing];
        });
    });
}


- (NSArray *)fetchMediaItems
{
    return @[];
}


- (void)setChartToppers:(NSArray *)chartToppers
{
    _chartToppers = chartToppers;
    if (!_chartToppers) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NETWORK_ERROR
                                                        message:MESSAGE
                                                       delegate:nil
                                              cancelButtonTitle:CANCEL_BUTTON
                                              otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self.tableView reloadData];
    }
}


#pragma mark - Prepare for Segue

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Show Details"]) {
                if ([segue.destinationViewController respondsToSelector:@selector(setMediaItem:)]) {
                    ITunesMediaItem *mediaItem = [self.chartToppers objectAtIndex:indexPath.row];
                    [segue.destinationViewController performSelector:@selector(setMediaItem:) withObject:mediaItem];
                    [segue.destinationViewController setTitle:[[self.chartToppers objectAtIndex:indexPath.row] title]];
                }
            }
        }
        
    }
    
}


#pragma mark - Table view data source

//Number of sections is 1, hence numberOfSections() not implemented

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.chartToppers count];
}


- (NSString *)titleForRow:(NSUInteger)row
{
    return [self.chartToppers[row] valueForKey:@"_title"];
}


- (NSString *)artistForRow:(NSUInteger)row
{
    return [self.chartToppers[row] valueForKey:@"_artist"];
}


- (NSString *)rankForRow:(NSUInteger)row
{
    return [self.chartToppers[row] valueForKey:@"_rank"];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Media Item";
    ITunesMediaItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.mediaItemImage.image    = nil;
    cell.mediaItemTitle.text     = [self titleForRow:indexPath.row];
    cell.mediaItemArtist.text    = [self artistForRow:indexPath.row];
    cell.mediaItemRank.text      = [NSString stringWithFormat:@"# %@",[self rankForRow:indexPath.row]];
    
    [cell.spinner startAnimating];
    dispatch_queue_t imageDownloader = dispatch_queue_create("Get Image", NULL);
    dispatch_async(imageDownloader, ^{
        UIImage *image = [[self.chartToppers objectAtIndex:indexPath.row]artworkImage];
        dispatch_async(dispatch_get_main_queue(), ^{
            ITunesMediaItemTableViewCell *correctCell = (ITunesMediaItemTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            if (image) {
                correctCell.mediaItemImage.image = image;
            }
            //if network connectivity is lost while trying to fetch artwork image, show default artwork
            else {
                correctCell.mediaItemImage.image = [UIImage imageNamed:@"defaultIcon.png"];
            }
        });
        [cell.spinner stopAnimating];
    });
    return cell;
}

@end

