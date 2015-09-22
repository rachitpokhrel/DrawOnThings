//
//  AlbumContentsViewController.h
//  DrawOnThings
//
//  Created by Rachit on 9/16/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface DTAlbumContentsViewController : UICollectionViewController<ELCImagePickerControllerDelegate, UINavigationControllerDelegate,UICollectionViewDataSource>

-(IBAction)unwindToAlbumViewController:(UIStoryboardSegue*)storyboard;
- (IBAction)loadCamera:(id)sender;
- (IBAction)loadPhotoLibrary:(id)sender;
@end
