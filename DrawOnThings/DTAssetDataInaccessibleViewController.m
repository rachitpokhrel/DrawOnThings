//
//  DTAssetDataInaccessibleViewController.m
//  DrawOnThings
//
//  Created by Rachit on 9/16/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import "DTAssetDataInaccessibleViewController.h"

@interface DTAssetDataInaccessibleViewController ()
@property (nonatomic, strong) IBOutlet UITextView *explanationTextView;
@end

@implementation DTAssetDataInaccessibleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.explanationTextView.text = self.explanation;
}

@end
