//
//  ViewController.m
//  DrawOnThings
//
//  Created by Rachit on 9/15/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import "DTDrawViewController.h"
#import "DTCanvas.h"
#import "DTTwitterLoginViewController.h"
#import "DTTwitterViewController.h"
#import "DTFacebookLoginViewController.h"
#import "DTFacebookViewController.h"
#import <TwitterKit/TwitterKit.h>


@interface DTDrawViewController ()
@property (nonatomic, strong) UIImage *processedImage;
@end

@implementation DTDrawViewController{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView.image = self.image;
    self.processedImage = self.image;
    self.canvas.backgroundColor = [UIColor clearColor];    
}


- (IBAction)save:(id)sender
{
    UIImage *image = [self.canvas imageByDrawingOnImageCG:self.imageView.image];
    self.processedImage = image;
    NSData *imageData = UIImagePNGRepresentation(image);
    //ALAssetRepresentation *rep = [self.asset defaultRepresentation];
    //NSDictionary *dictionary = [rep metadata];
    //[self.asset writeModifiedImageDataToSavedPhotosAlbum:imageData metadata:dictionary completionBlock:^(NSURL *assetURL, NSError *error){
        
    //}];
     
}

- (IBAction)share:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Share"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* facebookAction = [UIAlertAction actionWithTitle:@"Facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        if ([FBSDKAccessToken currentAccessToken])
            [self performSegueWithIdentifier:@"directShareFacebook" sender:self];
        else
            [self performSegueWithIdentifier:@"showFacebook" sender:self];
    }];
    UIAlertAction* twitterAction = [UIAlertAction actionWithTitle:@"Twitter" style:
        UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
         if ([Twitter sharedInstance].session.authToken)
             [self performSegueWithIdentifier:@"directShareTwitter" sender:self];
        else
            [self performSegueWithIdentifier:@"showTwitter" sender:self];
    }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:
                                    UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    
                                    }];
    [alert addAction:facebookAction];
    [alert addAction:twitterAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}



 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     NSArray *segues = @[@"showTwitter",@"showFacebook",@"directShareTwitter",@"directShareFacebook"];
     void (^segueBlock) (id, NSUInteger) = ^(id seguesArray, NSUInteger index){
         [segue.identifier isEqualToString:seguesArray[0]] ? ((DTTwitterLoginViewController*)[segue destinationViewController]).image = self.processedImage:nil;
         [segue.identifier isEqualToString:seguesArray[1]] ? ((DTFacebookLoginViewController*)[segue destinationViewController]).image = self.processedImage:nil;
         [segue.identifier isEqualToString:seguesArray[2]] ? ((DTTwitterViewController*)[segue destinationViewController]).image = self.processedImage:nil;
         [segue.identifier isEqualToString:seguesArray[3]] ? ((DTFacebookViewController*)[segue destinationViewController]).image = self.processedImage:nil;
         index > -1 ? segueBlock(seguesArray,index -1):nil;
     };
      segueBlock(segues,segues.count -1);
 }


@end
