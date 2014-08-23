//
//  AppDelegate.h
//  CarOnline
//
//  Created by James on 14-7-21.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : BaseAppDelegate<BMKGeneralDelegate>
{
    BMKMapManager *_mapManager;
}


- (void)onLogin;

- (void)onToOBDMain;

- (void)onToCarInfo;

- (void)toGPSMain;

@end
