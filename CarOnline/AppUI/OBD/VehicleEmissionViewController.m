//
//  VehicleEmissionViewController.m
//  CarOnline
//
//  Created by James on 14-7-22.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "VehicleEmissionViewController.h"

@interface VehicleEmissionViewController ()

@end

@implementation VehicleEmissionViewController

- (void)reloadAfterGetOBDEmission:(GetOBDEmissionResponseBody *)body
{

//    "ExamineStatus":1,
//    "CatalyzeStatus":1,
//    "EGRStatus":0,
//    "EVARStatus":0,
//    "MercuryStatus":0,
//    "HotSensorStatus":0,
//    "HotCatalyzeStatus":0,
//    "FireStatus":0
    
    
    _data = [NSMutableArray array];
    KeyValue *kv = [KeyValue key:@"排放检测结果：" value:body.ExamineStatus ? @"不合格" : @"合格"];
    [_data addObject:kv];

    kv = [KeyValue key:@"催化剂：" value:body.CatalyzeStatus ? @"异常" : @"正常"];
    [_data addObject:kv];

    kv = [KeyValue key:@"EGR：" value:body.EGRStatus ? @"异常" : @"正常"];
    [_data addObject:kv];

    kv = [KeyValue key:@"EVAP：" value:body.EVARStatus ? @"异常" : @"正常"];
    [_data addObject:kv];

    kv = [KeyValue key:@"泵检测：" value:body.MercuryStatus ? @"异常" : @"正常"];
    [_data addObject:kv];

    kv = [KeyValue key:@"热氧传感器组：" value:body.HotSensorStatus ? @"异常" : @"正常"];
    [_data addObject:kv];

    kv = [KeyValue key:@"热催化剂：" value:body.HotCatalyzeStatus ? @"正常" : @"异常"];
    [_data addObject:kv];

    kv = [KeyValue key:@"失火：" value:body.FireStatus ? @"产生" : @"未发生"];
    [_data addObject:kv];
    
    [_tableView reloadData];
    
}

- (void)configOwnViews
{
    __weak typeof(self) weakSelf = self;
    GetOBDEmission *goe = [[GetOBDEmission alloc] initWithHandler:^(BaseRequest *request) {
        GetOBDEmissionResponseBody *body = (GetOBDEmissionResponseBody *)request.response.Body;
        [weakSelf reloadAfterGetOBDEmission:body];
    }];
    [[WebServiceEngine sharedEngine] asyncRequest:goe];
    

}


@end
