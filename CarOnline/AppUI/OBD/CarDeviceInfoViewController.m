//
//  CarDeviceInfoViewController.m
//  CarOnline
//
//  Created by James on 14-7-22.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "CarDeviceInfoViewController.h"

@interface CarDeviceInfoViewController ()

@property (nonatomic, assign) NSInteger setTag;
@property (nonatomic, copy) NSString *setValue;
@property (nonatomic, strong) GetDevInfoResponseBody *devInfoBody;



@end

@implementation CarDeviceInfoViewController


typedef NS_ENUM(NSInteger, CarDeviceInfoType)
{
    ECarDevice_IMET,
    ECarDevice_UnitType,
    ECarDevice_URL,
    ECarDevice_Name,
    ECarDevice_SOS,
    ECarDevice_UpdatePeriod
};

- (void)reloadOnGetDevInfo:(GetDevInfoResponseBody *)body
{
    self.devInfoBody = body;
    _data = [NSMutableArray array];
    KeyValue *kv = [KeyValue key:@"IMEI" value:body.IMEI];
    [_data addObject:kv];
    
    kv = [KeyValue key:@"设备型号" value:body.DeviceType];
    [_data addObject:kv];
    
//    VehicleListItem *vehicle = [WebServiceEngine sharedEngine].vehicle;
    kv = [KeyValue key:@"最新地址" value:@"Test"];
    [_data addObject:kv];
    
    kv = [KeyValue key:@"设备名称" value:body.DeviceName];
    [_data addObject:kv];
    
    kv = [KeyValue key:@"SOS号码" value:body.SOSNumber];
    [_data addObject:kv];
    
    kv = [KeyValue key:@"数据更新周期" value:body.UpdatePeriod];
    [_data addObject:kv];
    
    [_tableView reloadData];
}

- (void)configOwnViews
{
    __weak typeof(self) weakSelf = self;
    GetDevInfo *gdi = [[GetDevInfo alloc] initWithHandler:^(BaseRequest *request) {
        GetDevInfoResponseBody *body = (GetDevInfoResponseBody *)request.response.Body;
        [weakSelf reloadOnGetDevInfo:body];
        
    }];
    [[WebServiceEngine sharedEngine] asyncRequest:gdi];
    
}

#define kWTATableCellIdentifier @"WTATableCellIdentifier"

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWTATableCellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kWTATableCellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = kBlackColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIButton *button = [UIButton buttonWithTip:@"设置"];
        button.tag = 1000 + indexPath.row;
        [button setTitleColor:kBlackColor forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"key_bg.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"key_bg_on.png"] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"key_bg_on.png"] forState:UIControlStateHighlighted];
        
        [button addTarget:self action:@selector(onSetting:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
        
    }
    
    KeyValue *kv = _data[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@：%@", kv.key, kv.value ? [kv.value description] : @""];
    
    UIView *button = [cell.contentView viewWithTag:1000 + indexPath.row];
    button.hidden = indexPath.row <= ECarDevice_URL;
    [button sizeWith:CGSizeMake(60, 30)];
    [button layoutParentVerticalCenter];
    [button alignParentRightWithMargin:15];
    return cell;
}

- (void)onSetting:(UIButton *)button
{
    NSInteger tag = button.tag - 1000;
    KeyValue *kv = _data[tag];
    [self onSetting:kv withTag:tag];
}

- (void)onSetting:(KeyValue *)kv withTag:(NSInteger)tag
{
    self.setTag = tag;
    __block KeyValue *bkv = kv;
    __weak typeof(self) weakSelf = self;
    InputPopupContentView *popup = [[InputPopupContentView alloc] initWith:kv.key editText:kv.value doneAction:^(PopupContentView *pop, NSString *editText) {
        
        
        switch (tag)
        {
            case ECarDevice_Name:
            {
                if (![NSString isEmpty:editText] && ![editText isEqualToString:bkv.value])
                {
                    weakSelf.setValue = editText;
                    SetDevInfo *sdi = [[SetDevInfo alloc] initWithHandler:^(BaseRequest *request) {
                        bkv.value = weakSelf.setValue;
                        [weakSelf.tableView reloadData];
                    } failHandler:^(BaseRequest *request) {
                        [weakSelf.tableView reloadData];
                    } deviceName:editText];
                    
                    [[WebServiceEngine sharedEngine] asyncRequest:sdi];
                    [pop closePopup];
                }
                else
                {
                    if ([NSString isEmpty:editText])
                    {
                        [[HUDHelper sharedInstance] tipMessage:@"设备名称不能为空！"];
                    }
                    else if ([editText isEqualToString:bkv.value])
                    {
                        [[HUDHelper sharedInstance] tipMessage:@"所输入内容跟当前设备名称相同！"];
                    }
                }
            }
                
                break;
            case ECarDevice_SOS:
            {
                if (![NSString isEmpty:editText] && ![editText isEqualToString:bkv.value])
                {
                    weakSelf.setValue = editText;
                    SetDevInfo *sdi = [[SetDevInfo alloc] initWithHandler:^(BaseRequest *request) {
                        bkv.value = weakSelf.setValue;
                        [weakSelf.tableView reloadData];
                    } failHandler:^(BaseRequest *request) {
                        [weakSelf.tableView reloadData];
                    } SOSNumber:editText];
                    
                    [[WebServiceEngine sharedEngine] asyncRequest:sdi];
                    [pop closePopup];
                }
                else
                {
                    if ([NSString isEmpty:editText])
                    {
                        [[HUDHelper sharedInstance] tipMessage:@"SOS号码不能为空！"];
                    }
                    else if ([editText isEqualToString:bkv.value])
                    {
                        [[HUDHelper sharedInstance] tipMessage:@"所输入内容跟当前SOS号码相同！"];
                    }
                }
            }
                break;
            case ECarDevice_UpdatePeriod:
            {
                if (![NSString isEmpty:editText] && ![editText isEqualToString:bkv.value])
                {
                    NSInteger dur = [(NSString *)bkv.value integerValue];
                    NSInteger inp = [editText integerValue];
                    
                    if (dur != inp && inp > 0)
                    {
                        weakSelf.setValue = editText;
                        SetDevInfo *sdi = [[SetDevInfo alloc] initWithHandler:^(BaseRequest *request) {
                            bkv.value = weakSelf.setValue;
                            [weakSelf.tableView reloadData];
                        } failHandler:^(BaseRequest *request) {
                            [weakSelf.tableView reloadData];
                        } SOSNumber:editText];
                        
                        [[WebServiceEngine sharedEngine] asyncRequest:sdi];
                        [pop closePopup];
                    }
                    else if (dur == inp)
                    {
                        [[HUDHelper sharedInstance] tipMessage:@"所输入内容跟当前数据更新周期相同！"];
                    }
                    else
                    {
                        [[HUDHelper sharedInstance] tipMessage:@"所输入内容不合规则！"];
                    }
                    
                }
                else
                {
                    if ([NSString isEmpty:editText])
                    {
                        [[HUDHelper sharedInstance] tipMessage:@"数据更新周期不能为空！"];
                    }
                    else if ([editText isEqualToString:bkv.value])
                    {
                        [[HUDHelper sharedInstance] tipMessage:@"所输入内容跟当前数据更新周期相同！"];
                    }
                }
                
            }
                break;
            default:
                break;
        }
        
        
    }];
    
    if (tag == ECarDevice_UpdatePeriod)
    {
        popup.edit.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    [PopupView alertInWindow:popup];
}

@end
