//
//  ViewController.h
//  DrawOnThings
//
//  Created by Rachit on 9/15/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTCanvas.h"

@interface DTDrawViewController : UIViewController

@property (weak, nonatomic) IBOutlet DTCanvas *canvas;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;
- (IBAction)save:(id)sender;


@end

