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
#import <MBProgressHUD/MBProgressHUD.h>

@interface DTDrawViewController ()
@property (nonatomic, strong) UIImage *processedImage;
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
    self.processedImage = image;
}

- (IBAction)save:(id)sender
{
    UIImage *image = [self.canvas imageByDrawingOnImageCG:self.imageView.image];
    self.processedImage = image;
    NSData *imageData = UIImagePNGRepresentation(image);
    ALAssetRepresentation *rep = [self.asset defaultRepresentation];
    NSDictionary *dictionary = [rep metadata];
    [self.asset writeModifiedImageDataToSavedPhotosAlbum:imageData metadata:dictionary completionBlock:^(NSURL *assetURL, NSError *error){
        
    }];
     
}

- (IBAction)share:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Share"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* facebookAction = [UIAlertAction actionWithTitle:@"Facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self facebookLogin];
    }];
    UIAlertAction* twitterAction = [UIAlertAction actionWithTitle:@"Twitter" style:
        UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self performSegueWithIdentifier:@"showTwitter" sender:self];
    }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:
                                    UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    
                                    }];
    [alert addAction:cancelAction];
    [alert addAction:facebookAction];
    [alert addAction:twitterAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)twitterLogin
{
    UIAlertController *twitterLogin = [UIAlertController alertControllerWithTitle:@"Login" message:@"Twitter" preferredStyle:UIAlertControllerStyleAlert];
    [twitterLogin addTextFieldWithConfigurationHandler:^(UITextField *textFied){
        textFied.placeholder = @"Username";
    } ];
    [twitterLogin addTextFieldWithConfigurationHandler:^(UITextField *textFied){
        textFied.placeholder = @"Password";
        textFied.secureTextEntry = YES;
    }];
    
    UIAlertAction* loginAction = [UIAlertAction actionWithTitle:@"Sign In" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        NSString *username = twitterLogin.textFields[0];
        NSString *password = twitterLogin.textFields[1];
        
    }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        
    }];
    
    [twitterLogin addAction:loginAction];
    [twitterLogin addAction:cancelAction];
    [self presentViewController:twitterLogin animated:YES completion:nil];
}


-(void)facebookLogin
{
    UIAlertController *facebookLogin = [UIAlertController alertControllerWithTitle:@"Login" message:@"Facebook" preferredStyle:UIAlertControllerStyleAlert];
    [facebookLogin addTextFieldWithConfigurationHandler:^(UITextField *textFied){
        textFied.placeholder = @"Username";
    } ];
    [facebookLogin addTextFieldWithConfigurationHandler:^(UITextField *textFied){
        textFied.placeholder = @"Password";
        textFied.secureTextEntry = YES;
    }];
    
    UIAlertAction* loginAction = [UIAlertAction actionWithTitle:@"Sign In" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        NSString *username = facebookLogin.textFields[0];
        NSString *password = facebookLogin.textFields[1];
        
    }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
    
    }];
    
    [facebookLogin addAction:loginAction];
    [facebookLogin addAction:cancelAction];
    [self presentViewController:facebookLogin animated:YES completion:nil];
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"showTwitter"])
     {
         DTTwitterLoginViewController *controller = [segue destinationViewController];
         controller.image = self.processedImage;
     }
     
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }


@end
