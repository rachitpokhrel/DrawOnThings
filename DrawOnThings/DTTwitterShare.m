//
//  DTTwitterShare.m
//  DrawOnThings
//
//  Created by Rachit on 9/19/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import "DTTwitterShare.h"

@implementation DTTwitterShare

-(void)authorizeUser:(NSString*)username password:(NSString*)password toTwitter:(void (^)(NSString *response))block
{
    NSString *consumerKey = @"NbTX26FIT19Aggrou8RJttZIc";
    NSString *callbackURL = @"";
    NSString *appOnlyAuthenticationURL = @"https://api.twitter.com/oauth2/token";
    NSString *requestTokenURL = @"https://api.twitter.com/oauth/request_token";
    NSString *authorizeURL = @"https://api.twitter.com/oauth/authorize";
    NSString *accessTokenURL = @"https://api.twitter.com/oauth/access_token";
    
    
}

@end
