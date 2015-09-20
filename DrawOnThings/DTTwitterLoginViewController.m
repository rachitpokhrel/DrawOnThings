//
//  DTTwitterLoginViewController.m
//  DrawOnThings
//
//  Created by Rachit on 9/19/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import "DTTwitterLoginViewController.h"
#import "DTTwitterViewController.h"
#import <TwitterKit/TwitterKit.h>
#import "DTTwitterShare.h"

@interface DTTwitterLoginViewController ()

@end

@implementation DTTwitterLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = self.image;
    // Do any additional setup after loading the view.
    TWTRLogInButton *logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
        // play with Twitter session
        if (session)
        {
            [self performSegueWithIdentifier:@"showTwitterView" sender:self];
        }
    }];
    logInButton.center = self.view.center;
    [self.view addSubview:logInButton];
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
    if ([segue.identifier isEqualToString:@"showTwitterView"])
    {
        DTTwitterViewController *controller = [segue destinationViewController];
        controller.image = self.image;
    }
}

@end
