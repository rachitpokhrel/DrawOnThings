//
//  AlbumContentsViewController.h
//  DrawOnThings
//
//  Created by Rachit on 9/16/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface DTAlbumContentsViewController : UICollectionViewController
@property (nonatomic, strong) NSMutableArray *assets;
@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@end
