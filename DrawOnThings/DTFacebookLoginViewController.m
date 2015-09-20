//
//  DTFacebookLoginViewController.m
//  DrawOnThings
//
//  Created by Rachit on 9/20/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import "DTFacebookLoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface DTFacebookLoginViewController ()

@end

@implementation DTFacebookLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = self.image;
    // Do any additional setup after loading the view.
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    loginButton.delegate = self;
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    if ([FBSDKAccessToken currentAccessToken])
        [self performSegueWithIdentifier:@"showFacebookView" sender:self];
}

-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    
    [self performSegueWithIdentifier:@"showFacebookView" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
