//
//  ViewController.h
//  DrawOnThings
//
//  Created by Rachit on 9/15/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "DTCanvas.h"

@interface DTDrawViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet DTCanvas *canvas;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) ALAsset *asset;
@property (weak, nonatomic) IBOutlet UIPickerView *socialPickerView;
- (IBAction)save:(id)sender;
- (IBAction)share:(id)sender;


@end

