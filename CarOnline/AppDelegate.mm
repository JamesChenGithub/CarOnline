//
//  AppDelegate.m
//  CarOnline
//
//  Created by James on 14-7-21.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "AppDelegate.h"




@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 要使用百度地图，请先启动BaiduMapManager
	_mapManager = [[BMKMapManager alloc] init];
	BOOL ret = [_mapManager start:@"ungrjapH96Ycw9M9QhExqhGe" generalDelegate:self];
	if (!ret) {
		NSLog(@"manager start failed!");
	}
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)enterMainUI
{
//    [self enterTestNet];
//    return;
    
    
    LoginViewController *login = [NSObject loadClass:[LoginViewController class]];
    self.window.rootViewController = login;
}

- (void)enterTestNet
{
    TestServerViewController *info = [NSObject loadClass:[TestServerViewController class]];
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:info];
    self.window.rootViewController = nav;
}

- (void)onLogin
{
    AppInfoViewController *info = [NSObject loadClass:[AppInfoViewController class]];
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:info];
    self.window.rootViewController = nav;
}

- (void)onToOBDMain
{
    OBDMainViewController *info = [NSObject loadClass:[OBDMainViewController class]];
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:info];
    self.window.rootViewController = nav;
}

- (void)onToCarInfo
{
    CarInfoViewController *info = [NSObject loadClass:[CarInfoViewController class]];
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:info];
    self.window.rootViewController = nav;
}

- (void)toGPSMain
{
    GPSMainViewController *info = [NSObject loadClass:[GPSMainViewController class]];
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:info];
    self.window.rootViewController = nav;
}

#pragma mark - 

//- (void)onGetNetworkState:(int)iError
//{
//    if (0 == iError) {
//        NSLog(@"联网成功");
//    }
//    else{
//        NSLog(@"onGetNetworkState %d",iError);
//    }
//    
//}
//
//- (void)onGetPermissionState:(int)iError
//{
//    if (0 == iError) {
//        NSLog(@"授权成功");
//    }
//    else {
//        NSLog(@"onGetPermissionState %d",iError);
//    }
//}

@end
