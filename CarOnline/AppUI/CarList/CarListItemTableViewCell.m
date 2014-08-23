//
//  CarListItemTableViewCell.m
//  CarOnline
//
//  Created by James on 14-7-26.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "CarListItemTableViewCell.h"

@implementation CarListItemTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"car_flag.png"];
        [self.contentView addSubview:_icon];
        
        _name = [[UILabel alloc] init];
        _name.textColor = kBlackColor;
        _name.text = @"Test079";
        _name.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_name];
        
        _status = [[UILabel alloc] init];
        _status.textColor = kBlackColor;
        _status.text = @"在线";
        _status.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_status];
        

        _location = [UIButton buttonWithType:UIButtonTypeCustom];
        [_location setImage:[UIImage imageNamed:@"car_selected.png"] forState:UIControlStateNormal];
        [_location addTarget:self action:@selector(toLocate:) forControlEvents:UIControlEventTouchUpInside];
        _location.hidden = YES;
        [self.contentView addSubview:_location];
        
        
        self.backgroundColor = kClearColor;
    }
    return self;
}

- (void)toLocate:(UIButton *)button
{
    [[AppDelegate sharedAppDelegate] popToRootViewController];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self relayoutFrameOfSubViews];
}

- (void)relayoutFrameOfSubViews
{
    CGRect rect = self.contentView.bounds;
    
    [_icon sizeWith:CGSizeMake(20, 20)];
    [_icon layoutParentVerticalCenter];
    [_icon alignParentLeftWithMargin:15];
    
    [_name sizeWith:CGSizeMake(100, rect.size.height)];
    [_name layoutToRightOf:_icon margin:15];
    
    [_status sameWith:_name];
    [_status layoutToRightOf:_name margin:20];
    
    [_location sameWith:_icon];
    [_location alignParentRightWithMargin:15];
    
    
}


@end
