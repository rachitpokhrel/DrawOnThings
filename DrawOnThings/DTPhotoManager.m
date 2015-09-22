//
//  DTPhotoManager.m
//  DrawOnThings
//
//  Created by Rachit on 9/21/15.
//  Copyright © 2015 Rachit. All rights reserved.
//

@import CoreImage;
@import AssetsLibrary;
#import "DTPhotoManager.h"

NSString *const kPhotoManagerAddedContentNotification = @"com.selander.GooglyPuff.PhotoManagerAddedContent";
NSString *const kPhotoManagerContentUpdateNotification = @"com.selander.GooglyPuff.PhotoMangerContentUpdate";

@interface DTPhotoManager ()
@property (nonatomic, strong) NSMutableArray *photosArray;
@property (nonatomic, strong) dispatch_queue_t concurrentPhotoQueue; ///< Add this
@end

@implementation DTPhotoManager
+ (instancetype)sharedManager
{
    static DTPhotoManager *sharedPhotoManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSThread sleepForTimeInterval:2];
        sharedPhotoManager = [[DTPhotoManager alloc] init];
        NSLog(@"Singleton has memory address at: %@", sharedPhotoManager);
        [NSThread sleepForTimeInterval:2];
        sharedPhotoManager->_photosArray = [NSMutableArray array];
        // ADD THIS:
        sharedPhotoManager->_concurrentPhotoQueue = dispatch_queue_create("com.selander.GooglyPuff.photoQueue",DISPATCH_QUEUE_CONCURRENT);
    });
    return sharedPhotoManager;
}

- (NSArray *)photos
{
    __block NSArray *array;
    dispatch_sync(self.concurrentPhotoQueue, ^{
        array = [NSArray arrayWithArray:_photosArray];
    });
    return _photosArray;
}

- (void)addPhoto:(DTPhoto *)photo
{
    if (photo) {
        dispatch_barrier_async(self.concurrentPhotoQueue, ^{
            [_photosArray addObject:photo];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self postContentAddedNotification];
            });
        });
    }
}

- (void)postContentAddedNotification
{
    static NSNotification *notification = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        notification = [NSNotification notificationWithName:kPhotoManagerAddedContentNotification object:nil];
    });
    
    [[NSNotificationQueue defaultQueue] enqueueNotification:notification postingStyle:NSPostASAP coalesceMask:NSNotificationCoalescingOnName forModes:nil];
}

@end
