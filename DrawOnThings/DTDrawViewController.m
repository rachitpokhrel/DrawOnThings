//
//  ViewController.m
//  DrawOnThings
//
//  Created by Rachit on 9/15/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import "DTDrawViewController.h"
#import "DTCanvas.h"
//#import "UIView+Screenshot.h"

@interface DTDrawViewController ()

@end

@implementation DTDrawViewController{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self image];
    self.canvas.backgroundColor = [UIColor clearColor];
}

-(void)image
{
    ALAssetRepresentation *rep = [self.asset defaultRepresentation];
    CGImageRef imageRef = [rep fullResolutionImage];
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    self.imageView.image = image;
}

- (IBAction)save:(id)sender
{
    UIImage *image = [self.canvas imageByDrawingOnImageCG:self.imageView.image];
    NSData *imageData = UIImagePNGRepresentation(image);
    ALAssetRepresentation *rep = [self.asset defaultRepresentation];
    NSDictionary *dictionary = [rep metadata];
    [self.asset writeModifiedImageDataToSavedPhotosAlbum:imageData metadata:dictionary completionBlock:^(NSURL *assetURL, NSError *error){
        
    }];
     
}



@end
