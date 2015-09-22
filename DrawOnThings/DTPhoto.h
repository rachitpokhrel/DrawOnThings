//
//  Photo.h
//  DrawOnThings
//
//  Created by Rachit on 9/21/15.
//  Copyright © 2015 Rachit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALAsset;
@interface DTPhoto : NSObject
/// The original image
- (UIImage *)image;

/// Scaled down image of the original image
- (UIImage *)thumbnail;

- (instancetype)initWithAsset:(ALAsset *)asset;
@end
