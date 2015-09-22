//
//  Photo.m
//  DrawOnThings
//
//  Created by Rachit on 9/21/15.
//  Copyright © 2015 Rachit. All rights reserved.
//

@import AssetsLibrary;
#import "DTPhoto.h"
#import "UIImage+Resize.h"



@interface __p_AssetPhoto : DTPhoto
@property (nonatomic, strong) ALAsset *asset;
@end

@implementation __p_AssetPhoto

-(id)init
{
    if (self = [super init])
    {
        
    }
    return self;
}

- (UIImage *)thumbnail
{
    ALAsset *asset = self.asset;
    CGImageRef cgImage = [asset thumbnail];
    UIImage *thumbnail = [UIImage imageWithCGImage:cgImage];
    return thumbnail;
}

- (UIImage *)image
{
    ALAssetRepresentation *representation = [self.asset defaultRepresentation];
    UIImage *image = [UIImage imageWithCGImage:[representation fullScreenImage]];
    return image;
}

@end

@interface DTPhoto()

@end


@implementation DTPhoto
- (instancetype)initWithAsset:(ALAsset *)asset
{
    NSAssert(asset, @"Assset is nil");
    __p_AssetPhoto *assetPhoto;
    assetPhoto = [[__p_AssetPhoto alloc] init];
    if (assetPhoto) {
        assetPhoto.asset = asset;
    }
    
    return assetPhoto;
}


- (UIImage *)image
{
    NSAssert(NO, @"Use One of Photo's public initializer methods"); return nil;
}

- (UIImage *)thumbnail
{
    NSAssert(NO, @"Use One of Photo's public initializer methods");
    return nil;
}
@end
