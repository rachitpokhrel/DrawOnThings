//
//  DTTwitterViewController.m
//  DrawOnThings
//
//  Created by Rachit on 9/19/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import "DTTwitterViewController.h"
#import <TwitterKit/TwitterKit.h>

@interface DTTwitterViewController ()

@end

@implementation DTTwitterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageView.image = self.image;
    NSString *authToken = [Twitter sharedInstance].session.authToken;
    NSString *authSecret = [Twitter sharedInstance].session.authTokenSecret;
    NSString *ID = [Twitter sharedInstance].session.userID;
    NSString *username = [Twitter sharedInstance].session.userName;
    
    [[Twitter sharedInstance] logInWithExistingAuthToken:authToken authTokenSecret:authSecret completion:^(TWTRSession *session, NSError *error) {
        if (session)
        {
            TWTRComposer *composer = [[TWTRComposer alloc] init];
            
            [composer setText:@""];
            [composer setImage:self.image];
            
            // Called from a UIViewController
            [composer showFromViewController:self completion:^(TWTRComposerResult result) {
                if (result == TWTRComposerResultCancelled) {
                    NSLog(@"Tweet composition cancelled");
                    [self performSegueWithIdentifier:@"backToGallery" sender:self];
                }
                else {
                    NSLog(@"Sending Tweet!");
                    [self performSegueWithIdentifier:@"backToGallery" sender:self];
                }
            }];
        }
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"backToGallery"])
    {
        
    }
}


@end
