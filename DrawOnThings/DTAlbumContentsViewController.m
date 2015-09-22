//
//  AlbumContentsViewController.m
//  DrawOnThings
//
//  Created by Rachit on 9/16/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import "DTAlbumContentsViewController.h"
#import "DTDrawViewController.h"
#import "DTPhotoManager.h"

@interface DTAlbumContentsViewController ()
@property (nonatomic, strong) ALAssetsLibrary *library;
@end

@implementation DTAlbumContentsViewController

#pragma mark - View lifecycle

+ (ALAssetsLibrary *)defaultAssetsLibrary {
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // Background image setup
    //UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    //backgroundImageView.alpha = kBackgroundImageOpacity;
    //backgroundImageView.contentMode = UIViewContentModeCenter;
    //[self.collectionView setBackgroundView:backgroundImageView];
    self.library = [[ALAssetsLibrary alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentChangedNotification:)
                                                 name:kPhotoManagerContentUpdateNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentChangedNotification:) name:kPhotoManagerAddedContentNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self showOrHideNavPrompt];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    NSInteger count = [[[DTPhotoManager sharedManager] photos] count];
    return count;
}

#define kImageViewTag 1 // the image view inside the collection view cell prototype is tagged with "1"

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"photoCell";
    
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // load the asset for this cell
    
    NSArray *photosArray = [[DTPhotoManager sharedManager] photos];
    DTPhoto *photo = photosArray[indexPath.row];
    
    // apply the image to the cell
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:kImageViewTag];
    imageView.image = [photo thumbnail];
    
    return cell;
}


#pragma mark - Segue support

-(IBAction)unwindToAlbumViewController:(UIStoryboardSegue*)storyboard
{
    
}

- (IBAction)loadCamera:(id)sender {
}

- (IBAction)loadPhotoLibrary:(id)sender {
    ELCImagePickerController *imagePickerController = [[ELCImagePickerController alloc] init];
    [imagePickerController setImagePickerDelegate:self];
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showPhoto"]) {
        DTDrawViewController *drawViewController = [segue destinationViewController];
        NSIndexPath *selectedCell = [self.collectionView indexPathsForSelectedItems][0];
        DTPhoto *photo = [[DTPhotoManager sharedManager] photos][selectedCell.row];
        drawViewController.image = [photo image];
    }
}

#pragma mark update add notifications
- (void)contentChangedNotification:(NSNotification *)notification
{
    [self.collectionView reloadData];
    [self showOrHideNavPrompt];
}

- (void)showOrHideNavPrompt
{
    // Implement me!
    NSUInteger count = [[DTPhotoManager sharedManager] photos].count;
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)); // 1
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){ // 2
        if (!count) {
            [self.navigationItem setPrompt:@"Add photos"];
        } else {
            [self.navigationItem setPrompt:nil];
        }
    });
}


#pragma mark picker delegate methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    for (NSDictionary *dictionary in info) {
        [self.library assetForURL:dictionary[UIImagePickerControllerReferenceURL] resultBlock:^(ALAsset *asset) {
            DTPhoto *photo = [[DTPhoto alloc] initWithAsset:asset];
            [[DTPhotoManager sharedManager] addPhoto:photo];
        } failureBlock:^(NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Permission Denied"
                                                            message:@"To access your photos, please change the permissions in Settings"
                                                           delegate:nil
                                                  cancelButtonTitle:@"ok"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
    
    
        [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
        [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
