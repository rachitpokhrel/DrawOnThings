//
//  DTFacebookViewController.h
//  DrawOnThings
//
//  Created by Rachit on 9/19/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface DTFacebookViewController : UIViewController<FBSDKSharingDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;
@end
