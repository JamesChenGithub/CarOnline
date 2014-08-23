//
//  AppInfoViewController.m
//  CarOnline
//
//  Created by James on 14-7-21.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "AppInfoViewController.h"

@interface AppInfoViewController ()

@property (nonatomic, strong) NSMutableArray *settings;

@end

@implementation AppInfoViewController

- (void)addMenu:(NSString *)title icon:(UIImage *)image class:(Class)viewClass
{
    MenuItem *menu = [[MenuItem alloc] initWithTitle:title icon:image action:^(id<MenuAbleItem> menu) {
        UIViewController *view = [[viewClass alloc] init];
        view.title = [menu title];
        [[AppDelegate sharedAppDelegate] pushViewController:view];
    }];
    
    [_settings addObject:menu];
}

- (void)configParams
{
    self.settings = [NSMutableArray array];
    

    [self addMenu:@"意见反馈" icon:[UIImage randomColorImageWith:CGSizeMake(20, 20)] class:[FeedbackViewController class]];

    [self addMenu:@"帮助信息" icon:[UIImage randomColorImageWith:CGSizeMake(20, 20)] class:[HelpInfoViewController class]];
    
    [self addMenu:@"检查更新" icon:[UIImage randomColorImageWith:CGSizeMake(20, 20)] class:[CheckVersionViewController class]];
    
    [self addMenu:@"关于我们" icon:[UIImage randomColorImageWith:CGSizeMake(20, 20)] class:[AboutUsViewController class]];
    
    [self addMenu:@"访问官网" icon:[UIImage randomColorImageWith:CGSizeMake(20, 20)] class:[OfficialWebsiteViewController class]];
    
    [self addMenu:@"微信关注" icon:[UIImage randomColorImageWith:CGSizeMake(20, 20)] class:[FollowWechatViewController class]];
}

#define kSettingTableViewRowHeight 44

- (void)addOwnViews
{

    _appInfoView = [[AppInfoView alloc] initWith:[UIImage randomColorImageWith:CGSizeMake(44, 44)] name:@"汽车远程监控" slogan:@"保护您的汽车生活"];
    [self.view addSubview:_appInfoView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView.backgroundColor = [UIColor clearColor];
    _tableView.rowHeight = kSettingTableViewRowHeight;
    [self.view addSubview:_tableView];
    
    if ([IOSDeviceConfig sharedConfig].isIOS7)
    {
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    }

    _tableView.scrollEnabled = NO;
    
    _logoutButton = [UIButton buttonWithTip:@"退出登陆"];
    _logoutButton.backgroundColor = kRedColor;
    [_logoutButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [self.view addSubview:_logoutButton];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"系统信息";
    self.view.backgroundColor = [UIColor flatDarkGrayColor];
}

#define kAppInfoHeight  60

#define kLogoutButtonHeight 44

- (void)layoutOnIPhone
{
    CGRect rect = self.view.bounds;
    
    [_appInfoView sizeWith:CGSizeMake(200, kAppInfoHeight)];
    [_appInfoView layoutParentHorizontalCenter];
    [_appInfoView relayoutFrameOfSubViews];
    
    [_tableView sizeWith:CGSizeMake(rect.size.width, kSettingTableViewRowHeight * _settings.count)];
    [_tableView layoutBelow:_appInfoView];
    

    
    [_logoutButton sizeWith:CGSizeMake(290, kLogoutButtonHeight)];
    [_logoutButton layoutBelow:_tableView margin:10];
    [_logoutButton layoutParentHorizontalCenter];
    
}


#pragma mark - UITableViewDatasource Methods

#define kWTATableCellIdentifier  @"WTATableCellIdentifier"

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.settings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWTATableCellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kWTATableCellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.textLabel.textColor = kBlackColor;
    }
    
    MenuItem *item = [self.settings objectAtIndex:indexPath.row];
    cell.textLabel.text = [item title];
    cell.imageView.image = [item icon];
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MenuItem *item = [self.settings objectAtIndex:indexPath.row];
    [item menuAction];
}

@end
