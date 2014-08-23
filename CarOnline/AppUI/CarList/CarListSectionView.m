//
//  CarListSectionView.m
//  CarOnline
//
//  Created by James on 14-7-26.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "CarListSectionView.h"

@implementation CarListSectionView

- (void)addOwnViews
{
    _expand = [[UIImageView alloc] init];
    [self addSubview:_expand];
    
    _title = [[UILabel alloc] init];
    _title.font = [UIFont systemFontOfSize:16];
    _title.textColor = kBlackColor;
    [self addSubview:_title];
    
    self.backgroundColor = [UIColor flatWhiteColor];
}

- (void)configOwnViews
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
}

- (void)onClick:(UITapGestureRecognizer *)tap
{
    if (tap.state == UIGestureRecognizerStateEnded)
    {
        if (_clickAction)
        {
            _section.isExpand = !_section.isExpand;
            _clickAction(self);
        }
    }
}

- (void)relayoutFrameOfSubViews
{
    [_expand sizeWith:CGSizeMake(20, 20)];
    [_expand alignParentLeftWithMargin:15];
    [_expand layoutParentVerticalCenter];
    
    [_title sizeWith:CGSizeMake(10, self.bounds.size.height)];
    [_title layoutToRightOf:_expand margin:15];
    [_title scaleToParentRightWithMargin:15];
}

- (void)configWith:(CarListSectionItem *)item clickAction:(CarListSectionViewClickBolok)block
{
    _expand.image = item.isExpand ? [UIImage imageNamed:@"group_open.png"] : [UIImage imageNamed:@"group_start.png"];
    
    _title.text = item.sectionName;
    
    _section = item;
    _clickAction = [block copy];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self relayoutFrameOfSubViews];
}

@end
