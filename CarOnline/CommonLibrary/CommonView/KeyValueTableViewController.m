//
//  KeyValueTableViewController.m
//  CarOnline
//
//  Created by James on 14-7-22.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "KeyValueTableViewController.h"

@interface KeyValueTableViewController ()

@end

@implementation KeyValueTableViewController

- (void)addOwnViews
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView.backgroundColor = [UIColor clearColor];
    _tableView.rowHeight = 50;

    if ([IOSDeviceConfig sharedConfig].isIOS7)
    {
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    }
    
    [self.view addSubview:_tableView];
}

- (void)layoutOnIPhone
{
    _tableView.frame = self.view.bounds;
}

#define kWTATableCellIdentifier  @"WTATableCellIdentifier"

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWTATableCellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kWTATableCellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = kBlackColor;
        cell.detailTextLabel.textColor = kBlackColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    KeyValue *kv = _data[indexPath.row];
    cell.textLabel.text = kv.key;
    cell.detailTextLabel.text = [kv.value description];
    
    return cell;
}

@end
