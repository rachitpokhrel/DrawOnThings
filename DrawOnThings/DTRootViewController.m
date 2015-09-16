//
//  RootViewController.m
//  DrawOnThings
//
//  Created by Rachit on 9/16/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import "DTRootViewController.h"
#import "DTAlbumContentsViewController.h"
#import "DTAssetDataInaccessibleViewController.h"

@interface DTRootViewController ()
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSMutableArray *groups;
@end

@implementation DTRootViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.assetsLibrary == nil) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    if (self.groups == nil) {
        _groups = [[NSMutableArray alloc] init];
    } else {
        [self.groups removeAllObjects];
    }
    
    // setup our failure view controller in case enumerateGroupsWithTypes fails
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        
        DTAssetDataInaccessibleViewController *assetsDataInaccessibleViewController =
        [self.storyboard instantiateViewControllerWithIdentifier:@"inaccessibleViewController"];
        
        NSString *errorMessage = nil;
        switch ([error code]) {
            case ALAssetsLibraryAccessUserDeniedError:
            case ALAssetsLibraryAccessGloballyDeniedError:
                errorMessage = @"The user has declined access to it.";
                break;
            default:
                errorMessage = @"Reason unknown.";
                break;
        }
        
        assetsDataInaccessibleViewController.explanation = errorMessage;
        [self presentViewController:assetsDataInaccessibleViewController animated:NO completion:nil];
    };
    
    // emumerate through our groups and only add groups that contain photos
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        
        ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
        [group setAssetsFilter:onlyPhotosFilter];
        if ([group numberOfAssets] > 0)
        {
            [self.groups addObject:group];
        }
        else
        {
            [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        }
    };
    
    // enumerate only photos
    NSUInteger groupTypes = ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupSavedPhotos;
    [self.assetsLibrary enumerateGroupsWithTypes:groupTypes usingBlock:listGroupBlock failureBlock:failureBlock];
    
    /*
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *theImagePath = [defaults objectForKey:@"cachedImagePath"];
    if (theImagePath)
        [self.groups addObject:theImagePath];
    */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

// determine the number of rows in the table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groups.count;
}

// determine the appearance of table view cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if ([self.groups[indexPath.row] isKindOfClass:[ALAssetsGroup class]])
    {
        ALAssetsGroup *groupForCell = self.groups[indexPath.row];
        CGImageRef posterImageRef = [groupForCell posterImage];
        UIImage *posterImage = [UIImage imageWithCGImage:posterImageRef];
        cell.imageView.image = posterImage;
        cell.textLabel.text = [groupForCell valueForProperty:ALAssetsGroupPropertyName];
        cell.detailTextLabel.text = [@(groupForCell.numberOfAssets) stringValue];
    }
    if ([self.groups[indexPath.row] isKindOfClass:[NSString class]])
    {
        cell.textLabel.text = @"Saved Photos";
        cell.detailTextLabel.text = @"saved photos can not be edited";
    }
    
    
    return cell;
}

#pragma mark - Segue support

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        if (self.groups.count > (NSUInteger)selectedIndexPath.row) {
            
            // hand off the asset group (i.e. album) to the next view controller
            DTAlbumContentsViewController *albumContentsViewController = [segue destinationViewController];
            albumContentsViewController.assetsGroup = self.groups[selectedIndexPath.row];
        }
    }
}

@end
