//
//  ViewController.m
//  DrawOnThings
//
//  Created by Rachit on 9/15/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import "DTDrawViewController.h"
#import "DTCanvas.h"

@interface DTDrawViewController ()

@end

@implementation DTDrawViewController{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView.image = self.image;
    self.canvas.backgroundColor = [UIColor clearColor];
}

- (IBAction)save:(id)sender
{
    /*
    UIImage *image = [self.canvas dtsnapshot];
    NSData *imageData = UIImagePNGRepresentation(image);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",@"cached"]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:imagePath forKey:@"cachedImagePath"];
    
    
    NSLog((@"pre writing to file"));
    if (![imageData writeToFile:imagePath atomically:NO])
    {
        NSLog((@"Failed to cache image data to disk"));
    }
    else
    {
        NSLog((@"the cachedImagedPath is %@",imagePath));
    }
     */
}



@end
