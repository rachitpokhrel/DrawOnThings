//
//  UIView+Screenshot.h
//  DrawOnThings
//
//  Created by Rachit on 9/17/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Screenshot)
- (UIImage *)pb_takeSnapshot;
- (UIImage *)imageByDrawingOnImageCG:(UIImage *)image;
@end
