//
//  CarDiagnosisViewController.m
//  CarOnline
//
//  Created by James on 14-7-22.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "CarDiagnosisViewController.h"

@interface CarDiagnosisViewController ()

@end

@implementation CarDiagnosisViewController


- (void)reloadAfterGetOBDFault:(GetOBDFaultResponseBody *)body
{
    _data = [NSMutableArray array];
    
    NSString *value = [NSString isEmpty:body.Value] ? @"正常" : body.Value;
    KeyValue *kv = [KeyValue key:@"论断结果：" value:value];
    [_data addObject:kv];
    [_tableView reloadData];
}
- (void)configOwnViews
{
    __weak typeof(self) weakself = self;
    GetOBDFault *gof = [[GetOBDFault alloc] initWithHandler:^(BaseRequest *request) {
        GetOBDFaultResponseBody *body = (GetOBDFaultResponseBody *)request.response.Body;
        [weakself reloadAfterGetOBDFault:body];
    }];
    [[WebServiceEngine sharedEngine] asyncRequest:gof];
    
}


@end
