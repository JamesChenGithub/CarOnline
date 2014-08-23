//
//  CarInfoViewController.m
//  CarOnline
//
//  Created by James on 14-7-23.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "CarInfoViewController.h"

@interface CarInfoViewController ()

@end

@implementation CarInfoViewController



- (void)addMenu:(NSString *)title icon:(UIImage *)image class:(Class)viewClass
{
    if (viewClass == Nil)
    {
        MenuItem *menu = [[MenuItem alloc] initWithTitle:title icon:image action:nil];
        [_data addObject:menu];
    }
    else
    {
        MenuItem *menu = [[MenuItem alloc] initWithTitle:title icon:image action:^(id<MenuAbleItem> menu) {
            UIViewController *view = [[viewClass alloc] init];
            view.title = [menu title];
            [[AppDelegate sharedAppDelegate] pushViewController:view];
        }];
        
        [_data addObject:menu];
    }
}


- (void)configOwnViews
{
    _data = [NSMutableArray array];
    

    [self addMenu:@"功能说明" icon:[UIImage imageNamed:@"function_indication.png"] class:[CarInfoFunctionExplainViewController class]];
    [self addMenu:@"里程" icon:[UIImage imageNamed:@"distance_travelled.png"] class:Nil];
    [self addMenu:@"短信取地址" icon:[UIImage imageNamed:@"msg_position.png"] class:Nil];
    [self addMenu:@"超速警示" icon:[UIImage imageNamed:@"speeding.png"] class:Nil];
    [self addMenu:@"跟踪" icon:[UIImage imageNamed:@"tracing.png"] class:Nil];
    [self addMenu:@"回放" icon:[UIImage imageNamed:@"playback.png"] class:Nil];
    [self addMenu:@"电子围栏" icon:[UIImage imageNamed:@"fence.png"] class:Nil];
    
}

//#define kWTATableCellIdentifier @"WTATableCellIdentifier"
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 2;
//    return _data.count;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row)
    {
        case ECarInfo_FunctionExplain:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ECarInfo_FunctionExplain"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ECarInfo_FunctionExplain"];
                cell.backgroundColor = [UIColor clearColor];
                cell.textLabel.textColor = kBlackColor;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            
            MenuItem *menu = _data[indexPath.row];
            cell.textLabel.text = menu.title;
            cell.imageView.image = menu.icon;
            return cell;
        }
            break;
        case ECarInfo_Distance:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ECarInfo_Distance"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ECarInfo_Distance"];
                cell.backgroundColor = [UIColor clearColor];
                cell.textLabel.textColor = kBlackColor;
                cell.detailTextLabel.textColor = kBlackColor;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            MenuItem *menu = _data[indexPath.row];
            cell.textLabel.text = menu.title;
            cell.imageView.image = menu.icon;
            cell.detailTextLabel.text = @"100km";
            return cell;
        }
            break;
        case ECarInfo_MessageAddress:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ECarInfo_MessageAddress"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ECarInfo_MessageAddress"];
                cell.backgroundColor = [UIColor clearColor];
                cell.textLabel.textColor = kBlackColor;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UIButton *button = [UIButton buttonWithTip:@"获取"];
                button.tag = 1000 + indexPath.row;
                [button setTitleColor:kBlackColor forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"key_bg.png"] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"key_bg_on.png"] forState:UIControlStateSelected];
                [button setBackgroundImage:[UIImage imageNamed:@"key_bg_on.png"] forState:UIControlStateHighlighted];
                [button addTarget:self action:@selector(onMessageAddress:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:button];
                
            }
            
            MenuItem *menu = _data[indexPath.row];
            cell.textLabel.text = menu.title;
            cell.imageView.image = menu.icon;
            
            UIView *button = [cell.contentView viewWithTag:1000 + indexPath.row];
            [button sizeWith:CGSizeMake(60, 30)];
            [button layoutParentVerticalCenter];
            [button alignParentRightWithMargin:15];
            return cell;
        }
            break;
        case ECarInfo_OverSpeed:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ECarInfo_MessageAddress"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ECarInfo_MessageAddress"];
                cell.backgroundColor = [UIColor clearColor];
                cell.textLabel.textColor = kBlackColor;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UIButton *button = [UIButton buttonWithTip:@"设置"];
                button.tag = 1000 + indexPath.row;
                
                [button setTitleColor:kBlackColor forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"key_bg.png"] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"key_bg_on.png"] forState:UIControlStateSelected];
                [button setBackgroundImage:[UIImage imageNamed:@"key_bg_on.png"] forState:UIControlStateHighlighted];
                [cell.contentView addSubview:button];
                
            }
            
            MenuItem *menu = _data[indexPath.row];
            cell.textLabel.text = menu.title;
            cell.imageView.image = menu.icon;
            
            UIView *button = [cell.contentView viewWithTag:1000 + indexPath.row];
            [button sizeWith:CGSizeMake(60, 30)];
            [button layoutParentVerticalCenter];
            [button alignParentRightWithMargin:15];
            return cell;
        }
            break;
        case ECarInfo_Track:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ECarInfo_Track"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ECarInfo_Track"];
                cell.backgroundColor = [UIColor clearColor];
                cell.textLabel.textColor = kBlackColor;
                cell.detailTextLabel.textColor = kBlackColor;
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UISwitch *alert = [[UISwitch alloc] init];
                alert.tag = 3000 + indexPath.row;
                [alert addTarget:self action:@selector(onTrack:) forControlEvents:UIControlEventValueChanged];
                [cell.contentView addSubview:alert];
                
            }
            
            MenuItem *kv = _data[indexPath.row];
            
            cell.imageView.image = kv.icon;
            cell.textLabel.text = kv.title;
            
            
            UISwitch *alert = (UISwitch *)[cell.contentView viewWithTag:3000 + indexPath.row];
            alert.on = YES;
            [alert sizeWith:CGSizeMake(60, 30)];
            [alert layoutParentVerticalCenter];
            [alert alignParentRightWithMargin:15];
            return cell;
        }
            break;
        case ECarInfo_Playback:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ECarInfo_Playback"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ECarInfo_Playback"];
                cell.backgroundColor = [UIColor clearColor];
                cell.textLabel.textColor = kBlackColor;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UIButton *button = [UIButton buttonWithTip:@"设置"];
                button.tag = 1000 + indexPath.row;
                [button setTitleColor:kBlackColor forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"key_bg.png"] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"key_bg_on.png"] forState:UIControlStateSelected];
                [button setBackgroundImage:[UIImage imageNamed:@"key_bg_on.png"] forState:UIControlStateHighlighted];
                [button addTarget:self action:@selector(onPlayback:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:button];
                
            }
            
            MenuItem *menu = _data[indexPath.row];
            cell.textLabel.text = menu.title;
            cell.imageView.image = menu.icon;
            
            UIView *button = [cell.contentView viewWithTag:1000 + indexPath.row];
            [button sizeWith:CGSizeMake(60, 30)];
            [button layoutParentVerticalCenter];
            [button alignParentRightWithMargin:15];
            return cell;
        }
            break;
        case ECarInfo_ElectronicFence:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ECarInfo_ElectronicFence"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ECarInfo_ElectronicFence"];
                cell.backgroundColor = [UIColor clearColor];
                cell.textLabel.textColor = kBlackColor;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UIButton *button = [UIButton buttonWithTip:@"设置"];
                button.tag = 1000 + indexPath.row;
                [button setTitleColor:kBlackColor forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"key_bg.png"] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"key_bg_on.png"] forState:UIControlStateSelected];
                [button setBackgroundImage:[UIImage imageNamed:@"key_bg_on.png"] forState:UIControlStateHighlighted];
                [button addTarget:self action:@selector(onElectronicFence:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:button];
                
            }
            
            MenuItem *menu = _data[indexPath.row];
            cell.textLabel.text = menu.title;
            cell.imageView.image = menu.icon;
            
            UIView *button = [cell.contentView viewWithTag:1000 + indexPath.row];
            [button sizeWith:CGSizeMake(60, 30)];
            [button layoutParentVerticalCenter];
            [button alignParentRightWithMargin:15];
            return cell;
        }
            break;
            
        default:
            return nil;
            break;
    }
    return nil;
}

- (void)onMessageAddress:(UIButton *)button
{
    
}

- (void)onOverspeed:(UIButton *)button
{
    MenuItem *item = _data[button.tag - 1000];
    InputPopupContentView *popup = [[InputPopupContentView alloc] initWith:item.title editText:nil doneAction:^(PopupContentView *pop, NSString *editText) {
        
        
        [pop closePopup];
        [_tableView reloadData];
    }];
    
    [PopupView alertInWindow:popup];
}

- (void)onTrack:(UISwitch *)alert
{
    
}

- (void)onPlayback:(UIButton *)button
{
    
}

- (void)onElectronicFence:(UIButton *)button
{
    
}
#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MenuItem *item = [_data objectAtIndex:indexPath.row];
    [item menuAction];
}

@end
