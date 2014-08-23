//
//  CarInfoFunctionExplainViewController.m
//  CarOnline
//
//  Created by James on 14-7-23.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "CarInfoFunctionExplainViewController.h"

@interface CarInfoFunctionExplainViewController ()

@end

@implementation CarInfoFunctionExplainViewController

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
    
    [self addMenu:@"里程：汽车从上一次停留后连续行驶的里程。" icon:[UIImage imageNamed:@"distance_travelled.png"] class:Nil];
    [self addMenu:@"短信取地址：短信获取汽车当前的位置。" icon:[UIImage imageNamed:@"msg_position.png"] class:Nil];
    [self addMenu:@"超速警示：车速超过所设速度信息后，设备会短信到绑定的手机号码。" icon:[UIImage imageNamed:@"speeding.png"] class:Nil];
    [self addMenu:@"跟踪：实时绘制汽车路径。" icon:[UIImage imageNamed:@"tracing.png"] class:Nil];
    [self addMenu:@"回放：查看某时段汽车行驶路径" icon:[UIImage imageNamed:@"playback.png"] class:Nil];
    [self addMenu:@"电子围栏：汽车超过所寂的范围内后，设备会发短信报警。" icon:[UIImage imageNamed:@"fence.png"] class:Nil];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultTableViewCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultTableViewCell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = kBlackColor;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
    }
    
    MenuItem *menu = _data[indexPath.row];
    cell.textLabel.text = menu.title;
    cell.imageView.image = menu.icon;
    return cell;
}
@end
