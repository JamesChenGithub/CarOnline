//
//  InputPopupContentView.m
//  HKConnect
//
//  Created by James on 4/25/14.
//  Copyright (c) 2014 James. All rights reserved.
//

#import "InputPopupContentView.h"

@implementation InputPopupContentView

- (instancetype)initWith:(NSString *)title editText:(NSString *)edit doneAction:(InputDoneAction)doneAction;
{
    self = [self initWithTitle:title];
    _edit.text = edit;
    _doneAction = doneAction;
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
{
    self = [self init];
    _title.text = title;
    return self;
}

- (instancetype)init
{
    if (self = [super init])
    {
        _showSize = CGSizeMake(280, 200);
        
        self.layer.cornerRadius = 10;
        self.backgroundColor = kWhiteColor;
    }
    return self;
}

- (void)addOwnViews
{
    _title = [[UILabel alloc] init];
    _title.backgroundColor = kClearColor;
    _title.textColor = kBlackColor;
    _title.textAlignment = NSTextAlignmentCenter;
    _title.font = [UIFont systemFontOfSize:20];
    [self addSubview:_title];
    
    _line = [[UIImageView alloc] init];
    _line.backgroundColor = [UIColor flatBlueColor];
    [self addSubview:_line];
    
    _edit = [[UITextField alloc] init];
    _edit.delegate = self;
    _edit.borderStyle = UITextBorderStyleBezel;
    _edit.clearButtonMode = UITextFieldViewModeWhileEditing;
    _edit.backgroundColor = kWhiteColor;
    _edit.font = [[FontHelper shareHelper] fontWithSize:14];
    _edit.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self addSubview:_edit];
    
    _bottomLine = [[UIImageView alloc] init];
    _bottomLine.backgroundColor = kLightGrayColor;
    [self addSubview:_bottomLine];
    
    
    _cancelButton = [[MenuButton alloc] init];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:kBlackColor forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(onCancel) forControlEvents:UIControlEventTouchUpInside];
    _cancelButton.showsTouchWhenHighlighted = YES;
    [self addSubview:_cancelButton];
    
    _splitLine = [[UIImageView alloc] init];
    _splitLine.backgroundColor = kLightGrayColor;
    [self addSubview:_splitLine];
    
    _doneButton = [[MenuButton alloc] init];
    [_doneButton setTitleColor:kBlackColor forState:UIControlStateNormal];
    [_doneButton setTitle:@"确定" forState:UIControlStateNormal];
    [_doneButton addTarget:self action:@selector(onDone) forControlEvents:UIControlEventTouchUpInside];
    _doneButton.showsTouchWhenHighlighted = YES;
    
    [self addSubview:_doneButton];
    
    self.backgroundColor = kWhiteColor;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self addGestureRecognizer:tap];
}

- (void)setWifiSSID:(NSString *)name
{
    _edit.text = name;
}

- (void)hideKeyboard
{
    [_edit resignFirstResponder];
}

- (void)onCancel
{
    [self hideKeyboard];
    [self closePopup];
}

//-(void)shakeDirection:(NSInteger)direction shakeCount:(NSInteger)shakeCount
//{
//    [UIView animateWithDuration:0.08 animations:^{
//        _edit.transform = CGAffineTransformMakeTranslation(direction, 0);
//    } completion:^(BOOL finished) {
//        if(shakeCount >= 6)
//        {
//            _edit.transform = CGAffineTransformIdentity;
//            return;
//        }
//
//        [self shakeDirection:direction*-1 shakeCount:shakeCount+1];
//    }];
//}
//
//- (void)onClickDone
//{
//    if (!_doneAction)
//    {
//        se
//    }
//}
//

- (void)onDone
{
    [self hideKeyboard];
    if (_doneAction)
    {
        _doneAction(self, _edit.text);
    }
    else
    {
        [self closePopup];
    }
}

#define kTitleHeight 60

#define kButtonHeight 40

#define kEditHorMargin 20

#define kEditHeight 36

- (void)relayoutFrameOfSubViews
{
    
    CGRect rect = self.bounds;
    
    [_title sizeWith:CGSizeMake(rect.size.width, kTitleHeight)];
    [_title layoutParentHorizontalCenter];
    
    [_line sizeWith:CGSizeMake(rect.size.width, 2)];
    [_line layoutBelow:_title];
    [_line layoutParentHorizontalCenter];
    
    [_bottomLine sizeWith:CGSizeMake(rect.size.width, 1)];
    [_bottomLine alignParentBottomWithMargin:kButtonHeight];
    
    rect.origin.y = _line.frame.origin.y;
    rect.size.height = _bottomLine.frame.origin.y - rect.origin.y;
    
    
    CGRect editRect = CGRectInset(rect, kEditHorMargin, (rect.size.height - kEditHeight)/2);
    _edit.frame = editRect;
    
    editRect = _bottomLine.frame;
    editRect.origin.y += editRect.size.height;
    editRect.size.height = kButtonHeight;
    
    editRect.size.width /= 2;
    _cancelButton.frame = editRect;
    
    editRect.origin.x += editRect.size.width;
    _doneButton.frame = editRect;
    
    editRect.size.width = 1;
    _splitLine.frame = editRect;
    [_splitLine layoutParentHorizontalCenter];
}

- (void)moveUp
{
    _hasOffset = YES;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.frame;
        rect.origin.y -= 100;
        self.frame = rect;
    }];
}

- (void)moveDown
{
    _hasOffset = NO;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.frame;
        rect.origin.y += 100;
        self.frame = rect;
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _edit)
    {
        [self moveUp];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self hideKeyboard];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == _edit)
    {
        [self moveDown];
        
    }
    
    return YES;
}


@end
