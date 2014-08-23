//
//  OBDMainViewController.m
//  CarOnline
//
//  Created by James on 14-7-22.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "OBDMainViewController.h"

@interface OBDMainViewController ()

@end

@implementation OBDMainViewController

- (void)addMenu:(NSString *)title icon:(UIImage *)image class:(Class)viewClass
{
    MenuItem *menu = [[MenuItem alloc] initWithTitle:title icon:image action:^(id<MenuAbleItem> menu) {
        UIViewController *view = [[viewClass alloc] init];
        view.title = [menu title];
        [[AppDelegate sharedAppDelegate] pushViewController:view];
    }];
    
    [_OBDItems addObject:menu];
}

- (BOOL)hasBackgroundView
{
    return YES;
}

- (void)configBackground
{
    if ([IOSDeviceConfig sharedConfig].isIPhone4)
    {
        _backgroundView.image = [UIImage imageNamed:@"obd_bg_4.jpg"];
    }
    else
    {
        _backgroundView.image = [UIImage imageNamed:@"obd_bg_5.jpg"];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_floatView startRequest];
    [_floatPanel startRequest];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_floatView stopRequest];
    [_floatPanel stopRequest];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIButton *button = [UIButton buttonWithTip:@"/"];
//    UIImage *norImag = [UIImage imageNamed:@"button_bg.png"];
//    [button setBackgroundImage:norImag forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"button_bg_pressed.png"] forState:UIControlStateHighlighted];
//    [button sizeWith:CGSizeMake(37, 37)];
//    [button addTarget:self action:@selector(toAppInfo) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithCustomView:button];
//    //    bar.target = self;
//    //    bar.action = @selector(toAppInfo);
//    self.navigationItem.rightBarButtonItem = bar;
    
    self.title = @"OBD";
}

//- (void)toAppInfo
//{
//    AppInfoViewController *app = [NSObject loadClass:[AppInfoViewController class]];
//    [[AppDelegate sharedAppDelegate] pushViewController:app];
//}

- (void)onGetAddress:(NSString *)address
{
    self.title = address;
}

- (void)addOwnViews
{
    // TODO: add Map View
    _floatView = [[CarStatusFloatView alloc] init];
    [self.view addSubview:_floatView];
    
    _OBDItems = [NSMutableArray array];


    [self addMenu:@"汽车排放" icon:[UIImage imageNamed:@"emission.png"] class:[VehicleEmissionViewController class]];
    
    [self addMenu:@"车安全" icon:[UIImage imageNamed:@"safety.png"] class:[CarSafeViewController class]];
    
    [self addMenu:@"车诊断" icon:[UIImage imageNamed:@"car_diagos.png"] class:[CarDiagnosisViewController class]];
    
    [self addMenu:@"数据监控" icon:[UIImage imageNamed:@"pid_data.png"] class:[CarDataMonitorViewController class]];
    
    [self addMenu:@"保养" icon:[UIImage imageNamed:@"maintance.png"] class:[CarMaintenanceViewController class]];
    
    [self addMenu:@"警示设置" icon:[UIImage imageNamed:@"alarm_setting.png"] class:[CarAlertSettingViewController class]];
    
    [self addMenu:@"胎压" icon:[UIImage imageNamed:@"tpms.png"] class:[CarTyrePressureViewController class]];
    
    [self addMenu:@"设备信息" icon:[UIImage imageNamed:@"device_setting.png"] class:[CarDeviceInfoViewController class]];
    

    _scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollView];
    
    
    _OBDButtons = [NSMutableArray array];
    for (MenuItem *item in _OBDItems)
    {
        OBDButton *btn = [[OBDButton alloc] initWithMenu:item];
        [_OBDButtons addObject:btn];
        [_scrollView addSubview:btn];
        
    }
    
    _floatPanel = [[OBDFloatPanel alloc] init];
    [self.view addSubview:_floatPanel];
}

#define kScrollAlighTopMargin 20

#define kRightMargin 15
#define kVerPadding 15

- (void)layoutSubviewsFrame
{
    [super layoutSubviewsFrame];
    
    CGRect rect = self.view.bounds;
    
    [_floatView sizeWith:CGSizeMake(rect.size.width, kCarStatusFloatViewHeight)];
    [_floatView relayoutFrameOfSubViews];
    
    rect = CGRectInset(rect, 0, kScrollAlighTopMargin);
    
    rect.size.width = 245;
    _scrollView.frame = rect;
    
    rect = _scrollView.bounds;
    rect = CGRectInset(rect, 20, 0);
    
    [_scrollView gridViews:_scrollView.subviews inColumn:2 size:CGSizeMake(100, 100) margin:CGSizeMake(5, 5) inRect:rect];
    
    UIView *last = _OBDButtons.lastObject;
    
    CGFloat lastHeight = last.frame.origin.y + last.frame.size.height;
    if (lastHeight > _scrollView.bounds.size.height)
    {
        _scrollView.contentSize = CGSizeMake(0, lastHeight);
    }
    else
    {
        _scrollView.contentSize = CGSizeMake(0, 0);
    }
    
    [_floatPanel sizeWith:CGSizeMake(40, 37 * 5 + kVerPadding*3 + 1)];
    [_floatPanel alignParentTopWithMargin:20];
    [_floatPanel alignParentRightWithMargin:kRightMargin];
    [_floatPanel relayoutFrameOfSubViews];
}



@end
