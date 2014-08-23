//
//  OBDFloatPanel.m
//  CarOnline
//
//  Created by James on 14-8-21.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "OBDFloatPanel.h"

@implementation OBDFloatPanel

#define kTimerInterval 10

- (void)addOwnViews
{
    UIImage *bg = [UIImage imageNamed:@"button_bg.png"];
    UIImage *bg_press = [UIImage imageNamed:@"button_bg_pressed.png"];
    
    _carManage = [UIButton buttonWithType:UIButtonTypeCustom];
    [_carManage setImage:[UIImage imageNamed:@"button_list.png"] forState:UIControlStateNormal];
    [_carManage setBackgroundImage:bg forState:UIControlStateNormal];
    [_carManage setBackgroundImage:bg_press forState:UIControlStateHighlighted];
    [_carManage addTarget:self action:@selector(toCarManage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_carManage];
    
    _gps = [UIButton buttonWithType:UIButtonTypeCustom];
    [_gps setImage:[UIImage imageNamed:@"gps_button.png"] forState:UIControlStateNormal];
    [_gps setBackgroundImage:bg forState:UIControlStateNormal];
    [_gps setBackgroundImage:bg_press forState:UIControlStateHighlighted];
    [_gps addTarget:self action:@selector(toGPS) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_gps];
    
    _message = [UIButton buttonWithType:UIButtonTypeCustom];
    [_message setImage:[UIImage imageNamed:@"button_msg.png"] forState:UIControlStateNormal];
    [_message setBackgroundImage:bg forState:UIControlStateNormal];
    [_message setBackgroundImage:bg_press forState:UIControlStateHighlighted];
    [_message addTarget:self action:@selector(toMessage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_message];
    
    _info = [UIButton buttonWithType:UIButtonTypeCustom];
    [_info setImage:[UIImage imageNamed:@"system_button.png"] forState:UIControlStateNormal];
    [_info setBackgroundImage:bg forState:UIControlStateNormal];
    [_info setBackgroundImage:bg_press forState:UIControlStateHighlighted];
    [_info addTarget:self action:@selector(toDeviceInfo) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_info];

}

- (void)toCarManage
{
    CarListViewController *car = [NSObject loadClass:[CarListViewController class]];
    [[AppDelegate sharedAppDelegate] pushViewController:car];
}


- (void)toGPS
{
    [[AppDelegate sharedAppDelegate] popToRootViewController];
}

- (void)toMessage
{
    MessageBoxViewController *msg = [NSObject loadClass:[MessageBoxViewController class]];
    [[AppDelegate sharedAppDelegate] pushViewController:msg];
}

- (void)toAppInfo
{
    AppInfoViewController *app = [NSObject loadClass:[AppInfoViewController class]];
    [[AppDelegate sharedAppDelegate] pushViewController:app];
}

- (void)toDeviceInfo
{
    CarInfoViewController *info = [NSObject loadClass:[CarInfoViewController class]];
    [[AppDelegate sharedAppDelegate] pushViewController:info];
}


#define kRightMargin 15
#define kVerPadding 15

- (void)relayoutFrameOfSubViews
{
    [_carManage sizeWith:CGSizeMake(37, 37)];
    [_carManage layoutParentHorizontalCenter];
    
    [_gps sameWith:_carManage];
    [_gps layoutBelow:_carManage margin:kVerPadding];
    
    [_message sameWith:_gps];
    [_message layoutBelow:_gps margin:kVerPadding];
    
    [_info sameWith:_message];
    [_info layoutBelow:_message margin:kVerPadding];
}

- (void)stopRequest
{
    [_timer invalidate];
    _timer = nil;
}


- (void)requestUnreadAlertInfo
{
    WebServiceEngine *we = [WebServiceEngine sharedEngine];
    if (![NSString isEmpty:we.vehicle.VehicleNumber])
    {
        GetUnreadAlarminfoCount *gua = [[GetUnreadAlarminfoCount alloc] initWithHandler:^(BaseRequest *request) {
            
        }];
        gua.VehicleNumbers = we.vehicle.VehicleNumber;
        
        [we asyncRequest:gua wait:NO];
    }
}

- (void)startRequest
{
    
    if (_timer == nil)
    {
        [self requestUnreadAlertInfo];
        
        _timer = [NSTimer timerWithTimeInterval:kTimerInterval target:self selector:@selector(requestUnreadAlertInfo) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    else
    {
        [self stopRequest];
        
        [self startRequest];
    }
}
@end
