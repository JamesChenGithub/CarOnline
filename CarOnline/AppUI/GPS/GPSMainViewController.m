//
//  GPSMainViewController.m
//  CarOnline
//
//  Created by James on 14-7-25.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "GPSMainViewController.h"

@interface GPSMainViewController ()

@end

@implementation GPSMainViewController

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.navigationController.navigationBar.hidden = YES;
//}
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
//}


- (void)notifyFloatViewRequest
{
    _hadGetDevList = YES;
    
    [_floatView startRequest];
    
    [_floatPanel startRequest];
    
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
////    bar.target = self;
////    bar.action = @selector(toAppInfo);
//    self.navigationItem.rightBarButtonItem = bar;
    
    __weak typeof(self) weakSelf = self;
    
    GetDevList *getDevList = [[GetDevList alloc] initWithHandler:^(BaseRequest *request) {
        
        GetDevListResponseBody *body = (GetDevListResponseBody *)request.response.Body;
        NSMutableArray *groupList = body.GroupList;
        
        if (groupList.count)
        {
            GroupListItem *item = groupList[0];
            
            if (item.VehicleList.count)
            {
                VehicleListItem *veh = item.VehicleList[0];
                [WebServiceEngine sharedEngine].vehicle = veh;
                [weakSelf notifyFloatViewRequest];
            }
        }
        
    }];
    
    [[WebServiceEngine sharedEngine] asyncRequest:getDevList];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_hadGetDevList)
    {
        [_floatView startRequest];
        [_floatPanel startRequest];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_floatView stopRequest];
    [_floatPanel stopRequest];
}

- (void)toAppInfo
{
    AppInfoViewController *app = [NSObject loadClass:[AppInfoViewController class]];
    [[AppDelegate sharedAppDelegate] pushViewController:app];
}

- (void)onGetAddress:(NSString *)address
{
    self.title = address;
}

- (void)addOwnViews
{
    _mapView = [[BMKMapView alloc] init];
    [self.view addSubview:_mapView];
    
    // TODO: add Map View
    _floatView = [[CarStatusFloatView alloc] init];
    _floatView.delegate = self;
    [self.view addSubview:_floatView];
    
    
    _floatPanel = [[GPSMainFloatPanel alloc] init];
    _floatPanel.delegate = self;
    [self.view addSubview:_floatPanel];
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
    
}

- (void)toZoomDecMap
{
    
}

#define kRightMargin 15
#define kVerPadding 15

- (void)layoutOnIPhone
{
    CGRect rect = self.view.bounds;
    
    _mapView.frame = rect;
    
    [_floatView sizeWith:CGSizeMake(rect.size.width, kCarStatusFloatViewHeight)];
    [_floatView relayoutFrameOfSubViews];
    
    [_floatPanel sizeWith:CGSizeMake(40, 37 * 5 + kVerPadding*3 + 1)];
    [_floatPanel alignParentTopWithMargin:20];
    [_floatPanel alignParentRightWithMargin:kRightMargin];
    [_floatPanel relayoutFrameOfSubViews];
}
@end
