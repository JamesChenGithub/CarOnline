//
//  CarSafeViewController.m
//  CarOnline
//
//  Created by James on 14-7-22.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "CarSafeViewController.h"

@interface CarSafeViewController ()

@property (nonatomic, strong) GetSafetyResponseBody *safetyBody;
@property (nonatomic, strong) GetSecurityResponseBody *securityBody;

@end

@implementation CarSafeViewController

- (void)onGetSafety:(GetSafetyResponseBody *)body
{
    self.safetyBody = body;
}

- (void)onGetSecurity:(GetSecurityResponseBody *)body
{
    self.securityBody = body;
}

- (void)configOwnViews
{
    
    __weak typeof(self) weakSelf = self;
    GetSafety *gs = [[GetSafety alloc] initWithHandler:^(BaseRequest *request) {
        GetSafetyResponseBody *body = (GetSafetyResponseBody *)request.response.Body;
        [weakSelf onGetSafety:body];
    }];
    [[WebServiceEngine sharedEngine] asyncRequest:gs];
    
    GetSecurity *gsc = [[GetSecurity alloc] initWithHandler:^(BaseRequest *request) {
        GetSecurityResponseBody *body = (GetSecurityResponseBody *)request.response.Body;
        [weakSelf onGetSecurity:body];
    }];
    [[WebServiceEngine sharedEngine] asyncRequest:gsc];
}

@end
