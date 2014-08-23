//
//  LoginViewController.h
//  CarOnline
//
//  Created by James on 14-7-21.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController
{
    UIImageView *_appLogoIcon;
    UILabel *_appNameLabel;
    UILabel *_appSloganLabel;
    
    UIImageView *_editBg;
    
    EditView *_accountEditView;
    EditView *_pwdEditView;
    
    CheckButton *_isRememberPwd;
    UIButton *_loginButton;
}

@end
