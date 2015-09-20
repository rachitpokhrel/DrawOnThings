//
//  DTTwitterShare.h
//  DrawOnThings
//
//  Created by Rachit on 9/19/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TwitterKit/TwitterKit.h>

@interface DTTwitterShare : NSObject

@property (nonatomic, strong) NSString *authToken;
@property (nonatomic, strong) NSString *authTokenSecret;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userID;


-(void)authorizeUser:(NSString*)username password:(NSString*)password toTwitter:(void (^)(NSString *response))block;
@end
