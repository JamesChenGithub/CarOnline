//
//  LoginViewController.m
//  CarOnline
//
//  Created by James on 14-7-21.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor flatDarkGrayColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapBlank:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)onTapBlank:(UITapGestureRecognizer *)ges
{
    if (ges.state == UIGestureRecognizerStateEnded)
    {
        [_accountEditView resignFirstResponder];
        [_pwdEditView resignFirstResponder];
    }
}

- (void)addOwnViews
{
    _appLogoIcon = [UIImageView imageViewWithColor:kRedColor];
    [self.view addSubview:_appLogoIcon];
    
    _appNameLabel = [UILabel centerlabelWith:@"汽车远程监控" boldFont:24];
    [self.view addSubview:_appNameLabel];
    
    _appSloganLabel = [UILabel centerlabelWith:@"保护你的车生活" boldFont:16];
    [self.view addSubview:_appSloganLabel];
    
//    _editBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_edit_bg.png"]];
//    [self.view addSubview:_editBg];
    
    _accountEditView = [[EditView alloc] initSingleLineWithTitle:@"帐号：" startAction:nil doneAction:nil];
    _accountEditView.titleWidth = 60;
    _accountEditView.placeHolder = @"请输入帐号";
    [self.view addSubview:_accountEditView];
    
    _pwdEditView = [[EditView alloc] initSingleLineWithTitle:@"密码：" startAction:nil doneAction:nil];
    [_pwdEditView setSecurity:YES];
    _pwdEditView.titleWidth = 60;
    _pwdEditView.placeHolder = @"请输入密码";
    [self.view addSubview:_pwdEditView];
    
    
    __weak typeof(self) weakSelf = self;
    _isRememberPwd = [[CheckButton alloc] initNormal:[UIImage imageWithColor:kWhiteColor size:CGSizeMake(40, 40)] selectedImage:[UIImage imageWithColor:kRedColor size:CGSizeMake(40, 40)] title:@"自动登录" checkAction:^(CheckButton *btn) {
        [weakSelf rememberPwd:btn.isCheck];
    }];
    _isRememberPwd.title.font = [UIFont systemFontOfSize:14];
    _isRememberPwd.isCheck = YES;
    [self.view addSubview:_isRememberPwd];
    
    _loginButton = [UIButton buttonWithTip:@"登陆"];
    [_loginButton setBackgroundImage:[UIImage imageNamed:@"login_normal.png"] forState:UIControlStateNormal];
    [_loginButton setBackgroundImage:[UIImage imageNamed:@"login_pressed.png"] forState:UIControlStateNormal];
    [_loginButton setTitleColor:kBlackColor forState:UIControlStateNormal];
    [_loginButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [_loginButton addTarget:self action:@selector(onLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
}


- (void)rememberPwd:(BOOL)check
{
    
}



- (void)configOwnViews
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *userid = (NSString *)[ud valueForKey:kAppLoginUserIDKey];
    NSString *pwd = (NSString *)[ud valueForKey:kAppLoginUserPWDKey];
    NSNumber *isRem = (NSNumber *)[ud valueForKey:kAppLoginRememberPWDKey];
    
    _accountEditView.text = userid;
    _pwdEditView.text = pwd;
    _isRememberPwd.isCheck = isRem ? isRem.boolValue : YES;
    
    if (![NSString isEmpty:userid] && ![NSString isEmpty:pwd])
    {
        [self onLogin];
    }
}

- (void)onLogin
{
    if ([NSString isEmpty:_accountEditView.text])
    {
        [[HUDHelper sharedInstance] tipMessage:_accountEditView.placeHolder];
        return;
    }
    
    if ([NSString isEmpty:_pwdEditView.text])
    {
        [[HUDHelper sharedInstance] tipMessage:_pwdEditView.placeHolder];
        return;
    }
    

    
    APPLogin *applogin = [[APPLogin alloc] initWithHandler:^(BaseRequest *request) {
        
        if (_isRememberPwd.isCheck)
        {
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:_accountEditView.text forKey:kAppLoginUserIDKey];
            if (_isRememberPwd.isCheck)
            {
                [ud setObject:_pwdEditView.text forKey:kAppLoginUserPWDKey];
                [ud setObject:[NSNumber numberWithBool:_isRememberPwd.isCheck] forKey:kAppLoginRememberPWDKey];
            }
            [ud synchronize];
        }
        WebServiceEngine *wse = [WebServiceEngine sharedEngine];
        APPLoginResponseBody *body = (APPLoginResponseBody *)request.response.Body;
        wse.user.UserName = body.UserName;
        wse.user.UserCode = body.UserCode;
        wse.user.Password = _pwdEditView.text;
        
        [[AppDelegate sharedAppDelegate] toGPSMain];
    }];
    applogin.UserName = _accountEditView.text;
    applogin.Password = _pwdEditView.text;

    [[WebServiceEngine sharedEngine] asyncRequest:applogin];
    
    
}

- (void)layoutOnIPhone
{
    CGRect rect = self.view.bounds;
    
    [_appLogoIcon sizeWith:CGSizeMake(60, 60)];
    [_appLogoIcon layoutParentHorizontalCenter];
    [_appLogoIcon alignParentTopWithMargin:60];
    
    [_appNameLabel sizeWith:CGSizeMake(rect.size.width, 30)];
    [_appNameLabel layoutBelow:_appLogoIcon];
    
    [_appSloganLabel sameWith:_appNameLabel];
    [_appSloganLabel layoutBelow:_appNameLabel];
    
    [_accountEditView sizeWith:CGSizeMake(rect.size.width, 35)];
    [_accountEditView layoutBelow:_appSloganLabel margin:10];
    [_accountEditView scaleToParentRightWithMargin:20];
    [_accountEditView relayoutFrameOfSubViews];
    
    [_pwdEditView sameWith:_accountEditView];
    [_pwdEditView layoutBelow:_accountEditView margin:10];
    [_pwdEditView relayoutFrameOfSubViews];
    
//    [_editBg sizeWith:CGSizeMake(rect.size.width - 40, 85)];
//    [_editBg alignParentLeftWithMargin:20];
//    [_editBg alignTop:_accountEditView margin:0];

    
    
    [_isRememberPwd sizeWith:CGSizeMake(100, 40)];
    [_isRememberPwd layoutBelow:_pwdEditView];
    [_isRememberPwd alignParentLeftWithMargin:60];
    [_isRememberPwd relayoutFrameOfSubViews];
    
    [_loginButton sizeWith:CGSizeMake(rect.size.width - 40, 44)];
    [_loginButton layoutBelow:_isRememberPwd margin:20];
    [_loginButton layoutParentHorizontalCenter];
    
}


@end
