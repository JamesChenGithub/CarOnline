//
//  MessageBoxTableViewCell.m
//  CarOnline
//
//  Created by James on 14-7-26.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "MessageBoxTableViewCell.h"

@interface MessageBoxTableViewCell ()

@property (nonatomic, copy) AlertListItem *message;

@end

@implementation MessageBoxTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _messageBg = [[UIView alloc] init];
        _messageBg.layer.borderWidth = 1;
        _messageBg.layer.cornerRadius = 6;
        _messageBg.layer.borderColor = kGrayColor.CGColor;
        _messageBg.backgroundColor = [UIColor flatWhiteColor];
        [self.contentView addSubview:_messageBg];
        
        _messageAlert = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"msg_alarm.png"]];
        [_messageBg addSubview:_messageAlert];
        
        _messageText = [[UILabel alloc] init];
        _messageText.font = [UIFont systemFontOfSize:14];
        _messageText.textColor = kBlackColor;
        _messageText.numberOfLines = 0;
        _messageText.lineBreakMode = NSLineBreakByWordWrapping;
        [_messageBg addSubview:_messageText];
        
        _messageDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        [_messageDelete setImage:[UIImage imageNamed:@"msg_del.png"] forState:UIControlStateNormal];
        [_messageDelete addTarget:self action:@selector(onDeleteAlert) forControlEvents:UIControlEventTouchUpInside];
        [_messageBg addSubview:_messageDelete];
        
        
        self.backgroundColor = kClearColor;
    }
    return self;
}

#define kVerMargin 5

#define kVerPadding 10

#define kMinMessageHeight 24

#define kMessageWidth 240

#define kAlarmDelWidth 32

#define kAlarmDelHorMargin 10

+ (CGFloat)heightOf:(NSString *)text
{
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kMessageWidth, HUGE_VALF) lineBreakMode:NSLineBreakByWordWrapping];

    
    if (size.height < kMinMessageHeight)
    {
        size.height = kMinMessageHeight;
    }
    
    return size.height + 2*kVerPadding + 2*kVerMargin;
}

- (void)config:(AlertListItem *)message
{
    self.message = message;
    _messageText.text = message.AlertContent;
}

- (void)onDeleteAlert
{
    DelAlarmInfo *del = [[DelAlarmInfo alloc] initWithHandler:^(BaseRequest *request) {
        
    }];
    del.MessageType = self.message.MessageType;
    del.AlertId = self.message.AlertId;
    [[WebServiceEngine sharedEngine] asyncRequest:del];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self relayoutFrameOfSubViews];
}

#define kAlarmDelSize CGSizeMake(24, 24)

- (void)relayoutFrameOfSubViews
{
    CGRect rect = self.contentView.bounds;
    
    rect = CGRectInset(rect, 8, kVerMargin);
    
    _messageBg.frame = rect;
    
    
    
    [_messageAlert sizeWith:kAlarmDelSize];
    [_messageAlert layoutParentVerticalCenter];
    [_messageAlert alignParentLeftWithMargin:kAlarmDelHorMargin];
    
    [_messageDelete sizeWith:kAlarmDelSize];
    [_messageDelete layoutParentVerticalCenter];
    [_messageDelete alignParentRightWithMargin:kAlarmDelHorMargin];
    
    rect = _messageBg.bounds;
    rect = CGRectInset(rect, kAlarmDelSize.width + 2*kAlarmDelHorMargin, kVerPadding);
    _messageText.frame = rect;
}

@end
