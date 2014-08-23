//
//  CarDataMonitorViewController.m
//  CarOnline
//
//  Created by James on 14-7-22.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "CarDataMonitorViewController.h"

@interface CarDataMonitorViewController ()

@end

@implementation CarDataMonitorViewController

- (void)reloadAfterGetOBDData:(GetOBDDataResponseBody *)body
{
    
}

- (void)configOwnViews
{
    GetOBDData *god = [[GetOBDData alloc] initWithHandler:^(BaseRequest *request) {
        
    }];
    
    [[WebServiceEngine sharedEngine] asyncRequest:god];
    
    
}

@end
