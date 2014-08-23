//
//  WebServiceEngine.h
//  CarOnline
//
//  Created by James on 14-8-5.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "MKNetworkEngine.h"

@class BaseRequest;

@interface WebServiceEngine : NSObject<NSObject>
{
    
}

@property (nonatomic, strong) LoginUser *user;
@property (nonatomic, strong) VehicleListItem *vehicle;

+ (instancetype)sharedEngine;

- (void)asyncRequest:(BaseRequest *)req;

- (void)asyncRequest:(BaseRequest *)req wait:(BOOL)wait;

@end
