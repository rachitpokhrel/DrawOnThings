//
//  DTFacebookLoginViewController.h
//  DrawOnThings
//
//  Created by Rachit on 9/20/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface DTFacebookLoginViewController : UIViewController<FBSDKLoginButtonDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;

@end
