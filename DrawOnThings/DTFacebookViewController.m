//
//  DTFacebookViewController.m
//  DrawOnThings
//
//  Created by Rachit on 9/19/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import "DTFacebookViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface DTFacebookViewController ()

@end

@implementation DTFacebookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = self.image;
    
    // Do any additional setup after loading the view.
    FBSDKLoginManager *manager = [[FBSDKLoginManager alloc] init];
    //manager.defaultAudience = 0;
    NSArray *permission = @[@"publish_actions"];
    [manager logInWithPublishPermissions:permission fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error){
        FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
        photo.image = self.image;
        photo.userGenerated = YES;
        photo.imageURL = [NSURL URLWithString:@"http://www.joomlaworks.net/support/docs/simple-image-gallery-pro#sigProIdfe6145fe10"];
        photo.caption = @"Joomla";
        FBSDKSharePhotoContent * photoContent = [[FBSDKSharePhotoContent alloc] init];
        photoContent.photos = @[photo];
        photoContent.contentURL = [NSURL URLWithString:@"http://google.com"];
        FBSDKShareDialog *shareDialog = [[FBSDKShareDialog alloc] init];
        if ([shareDialog canShow])
        {
            shareDialog.shareContent = photoContent;
            [shareDialog setMode:FBSDKShareDialogModeAutomatic];
            shareDialog.delegate = self;
            shareDialog.fromViewController = self;
            NSError * perror = nil;
            BOOL validation = [shareDialog validateWithError:&perror];
            //if (validation) {
            [shareDialog show];
            //}
        }
        
    }];
    
    
    // app not installed in the phone then photo sharing does not work also in the simulator does not work
}

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results {
    // handle
}
- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error{
    // handle
}
- (void)sharerDidCancel:(id<FBSDKSharing>)sharer{
    // handle
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
    photo.image = image;
    photo.userGenerated = YES;
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    content.photos = @[photo];
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
