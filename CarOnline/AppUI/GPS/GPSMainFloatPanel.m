//
//  FloatPanel.m
//  CarOnline
//
//  Created by James on 14-8-20.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "GPSMainFloatPanel.h"

@implementation GPSMainFloatPanel

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
    
    _OBD = [UIButton buttonWithType:UIButtonTypeCustom];
    [_OBD setImage:[UIImage imageNamed:@"button_OBD.png"] forState:UIControlStateNormal];
    [_OBD setBackgroundImage:bg forState:UIControlStateNormal];
    [_OBD setBackgroundImage:bg_press forState:UIControlStateHighlighted];
    [_OBD addTarget:self action:@selector(toOBD) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_OBD];
    
    _message = [UIButton buttonWithType:UIButtonTypeCustom];
    [_message setImage:[UIImage imageNamed:@"button_msg.png"] forState:UIControlStateNormal];
    [_message setBackgroundImage:bg forState:UIControlStateNormal];
    [_message setBackgroundImage:bg_press forState:UIControlStateHighlighted];
    [_message addTarget:self action:@selector(toMessage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_message];
    
    _zoomAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    [_zoomAdd setImage:[UIImage imageNamed:@"button_+.png"] forState:UIControlStateNormal];
    [_zoomAdd setBackgroundImage:[UIImage imageNamed:@"+_button_bg.png"] forState:UIControlStateNormal];
    [_zoomAdd setBackgroundImage:[UIImage imageNamed:@"+_button_bg_pressed.png"] forState:UIControlStateHighlighted];
    [_zoomAdd addTarget:self action:@selector(toZoomAddMap) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_zoomAdd];
    
    _zoomDec = [UIButton buttonWithType:UIButtonTypeCustom];
    [_zoomDec setImage:[UIImage imageNamed:@"button_-.png"] forState:UIControlStateNormal];
    [_zoomDec setBackgroundImage:[UIImage imageNamed:@"-_button_bg.png"] forState:UIControlStateNormal];
    [_zoomDec setBackgroundImage:[UIImage imageNamed:@"-_button_bg_pressed.png"] forState:UIControlStateHighlighted];
    [_zoomDec addTarget:self action:@selector(toZoomDecMap) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_zoomDec];

}

- (void)configOwnViews
{
//    [self performSelector:@selector(hide) withObject:nil afterDelay:3];
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

- (void)toCarManage
{
    CarListViewController *car = [NSObject loadClass:[CarListViewController class]];
    [[AppDelegate sharedAppDelegate] pushViewController:car];
}


- (void)toOBD
{
    OBDMainViewController *obd = [NSObject loadClass:[OBDMainViewController class]];
    [[AppDelegate sharedAppDelegate] pushViewController:obd];
}

- (void)toMessage
{
    MessageBoxViewController *msg = [NSObject loadClass:[MessageBoxViewController class]];
    [[AppDelegate sharedAppDelegate] pushViewController:msg];
}

- (void)toZoomAddMap
{
    [self resetHide];
    if ([_delegate respondsToSelector:@selector(toZoomAddMap)])
    {
        [_delegate toZoomAddMap];
    }
    
}

- (void)toZoomDecMap
{
    [self resetHide];
    if ([_delegate respondsToSelector:@selector(toZoomDecMap)])
    {
        [_delegate toZoomDecMap];
    }
}

#define kRightMargin 15
#define kVerPadding 15

- (void)relayoutFrameOfSubViews
{
    [_carManage sizeWith:CGSizeMake(37, 37)];
    [_carManage layoutParentHorizontalCenter];
    
    [_OBD sameWith:_carManage];
    [_OBD layoutBelow:_carManage margin:kVerPadding];
    
    [_message sameWith:_OBD];
    [_message layoutBelow:_OBD margin:kVerPadding];
    
    [_zoomAdd sameWith:_message];
    [_zoomAdd layoutBelow:_message margin:kVerPadding];
    
    [_zoomDec sameWith:_zoomAdd];
    [_zoomDec layoutBelow:_zoomAdd margin:1];
}

- (void)resetHide
{
    [GPSMainFloatPanel cancelPreviousPerformRequestsWithTarget:self selector:@selector(hide) object:nil];
    
    [self hide];
}

- (void)hide
{
    [self slideOutTo:kFTAnimationRight duration:0.3 delegate:nil];
}

- (void)show
{
    [self slideInFrom:kFTAnimationRight duration:0.3 delegate:nil];
    
    [self performSelector:@selector(hide) withObject:nil afterDelay:10];
}

@end
