//
//  DTPhotoManager.h
//  DrawOnThings
//
//  Created by Rachit on 9/21/15.
//  Copyright © 2015 Rachit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTPhoto.h"

extern NSString *const kPhotoManagerAddedContentNotification;

/// Notification when content updates (i.e. Download finishes)
extern NSString *const kPhotoManagerContentUpdateNotification;

@interface DTPhotoManager : NSObject
+ (instancetype)sharedManager;
/// Warning this is not currently thread safe
- (NSArray *)photos;
/// Warning this is not currently thread safe
- (void)addPhoto:(DTPhoto *)photo;
@end
