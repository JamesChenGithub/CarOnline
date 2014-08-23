//
//  MessageBoxViewController.m
//  CarOnline
//
//  Created by James on 14-7-26.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "MessageBoxViewController.h"

@interface MessageBoxViewController ()

@end

@implementation MessageBoxViewController

- (void)addOwnViews
{
    [super addOwnViews];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)configOwnViews
{
    _startIndex = 1;
    WebServiceEngine *we = [WebServiceEngine sharedEngine];
    
    if (![NSString isEmpty:we.vehicle.VehicleNumber])
    {
        GetAlarminfoList *gal = [[GetAlarminfoList alloc] initWithHandler:^(BaseRequest *request) {
            
        }];
        gal.StartRecord = _startIndex;
        gal.VehicleNumbers = we.vehicle.VehicleNumber;
        [[WebServiceEngine sharedEngine] asyncRequest:gal];
    }
    
    
    
//    _data = [NSMutableArray array];
//    
//    [_data addObject:@"Test Message"];
//    [_data addObject:@"Test Message, Test Message, Test Message, Test Message, Test Message, Test Message, Test Message, Test Message, Test Message, Test Message, Test Message"];
}

#define kTableViewCellIdentifier @"MessageBoxTableViewCell"

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id kv = _data[indexPath.row];
    return [MessageBoxTableViewCell heightOf:[kv description]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageBoxTableViewCell *cell = (MessageBoxTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifier];
    if (!cell)
    {
        cell = [[MessageBoxTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kTableViewCellIdentifier];
    }
    
    AlertListItem *kv = _data[indexPath.row];
    [cell config:kv];
    return cell;
}
@end
