//
//  CarListViewController.m
//  CarOnline
//
//  Created by James on 14-7-26.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "CarListViewController.h"

@implementation CarListItem



@end

@implementation CarListSectionItem



@end

// =========================================

@interface CarListViewController ()

@end

@implementation CarListViewController

#define kRowHeight 50

- (void)addOwnViews
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView.backgroundColor = [UIColor clearColor];
    _tableView.rowHeight = kRowHeight;
    [self.view addSubview:_tableView];
    
    if ([IOSDeviceConfig sharedConfig].isIOS7)
    {
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    
    _multiMonitor = [UIButton buttonWithType:UIButtonTypeCustom];
    [_multiMonitor setTitle:@"多车监控" forState:UIControlStateNormal];
    [_multiMonitor setTitleColor:kBlackColor forState:UIControlStateNormal];
    [_multiMonitor setBackgroundColor:kLightGrayColor];
    
    [_multiMonitor addTarget:self action:@selector(onMultiMonitor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_multiMonitor];
}

- (void)onMultiMonitor
{
    [[AppDelegate sharedAppDelegate] popToRootViewController];
}

- (void)configOwnViews
{
    _carList = [NSMutableArray array];
    
    CarListItem *item11 = [[CarListItem alloc] init];
    CarListItem *item12 = [[CarListItem alloc] init];
    CarListItem *item13 = [[CarListItem alloc] init];
    CarListItem *item14 = [[CarListItem alloc] init];
    
    CarListSectionItem *sectionItem1 = [[CarListSectionItem alloc] init];
    sectionItem1.sectionName = @"James Chen";
    sectionItem1.isExpand = YES;
    sectionItem1.list = [NSMutableArray arrayWithArray:@[item11, item12, item13, item14]];
    [_carList addObject:sectionItem1];
    

    CarListItem *item21 = [[CarListItem alloc] init];
    CarListItem *item22 = [[CarListItem alloc] init];
    CarListItem *item23 = [[CarListItem alloc] init];
    
    CarListSectionItem *sectionItem2 = [[CarListSectionItem alloc] init];
    sectionItem2.sectionName = @"ywchen";
    sectionItem2.isExpand = YES;
    sectionItem2.list = [NSMutableArray arrayWithArray:@[item21, item22, item23]];
    [_carList addObject:sectionItem2];
    
    CarListItem *item31 = [[CarListItem alloc] init];
    CarListItem *item32 = [[CarListItem alloc] init];
    CarListItem *item33 = [[CarListItem alloc] init];
    
    CarListSectionItem *sectionItem3 = [[CarListSectionItem alloc] init];
    sectionItem3.sectionName = @"Section3";
    sectionItem3.isExpand = YES;
    sectionItem3.list = [NSMutableArray arrayWithArray:@[item31, item32, item33]];
    [_carList addObject:sectionItem3];
    
    CarListItem *item41 = [[CarListItem alloc] init];
    CarListItem *item42 = [[CarListItem alloc] init];
    CarListItem *item43 = [[CarListItem alloc] init];
    
    CarListSectionItem *sectionItem4 = [[CarListSectionItem alloc] init];
    sectionItem4.sectionName = @"Test";
    sectionItem4.isExpand = YES;
    sectionItem4.list = [NSMutableArray arrayWithArray:@[item41, item42, item43]];
    [_carList addObject:sectionItem4];
}

- (void)layoutOnIPhone
{
    CGRect rect = self.view.bounds;
    
    CGRect monitorRect = rect;
    monitorRect.origin.y += rect.size.height - kRowHeight;
    monitorRect.size.height = kRowHeight;
    _multiMonitor.frame = monitorRect;
    
    rect.size.height -= kRowHeight;
    _tableView.frame = rect;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _carList.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CarListSectionItem *sectionItem = _carList[section];
    if (sectionItem.isExpand)
    {
        return sectionItem.list.count;
    }
    return  0;
}

- (CGFloat)tableView:(UITableView *)tableView  heightForHeaderInSection:(NSInteger)section
{
    return kRowHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CarListSectionView *sectionView = [[CarListSectionView alloc] init];
    [sectionView configWith:_carList[section] clickAction:^(CarListSectionView *view) {
        [tableView reloadData];
    }];
    return sectionView;
}

#define kWTATableCellIdentifier @"WTATableCellIdentifier"

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarListItemTableViewCell *cell = (CarListItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kWTATableCellIdentifier];
    if (!cell)
    {
        cell = [[CarListItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kWTATableCellIdentifier];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarListItemTableViewCell *cell = (CarListItemTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.location.hidden = NO;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarListItemTableViewCell *cell = (CarListItemTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.location.hidden = YES;
}




@end
