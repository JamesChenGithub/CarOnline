//
//  OBDButton.m
//  CarOnline
//
//  Created by James on 14-7-22.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "OBDButton.h"

@implementation OBDButton

//- (instancetype)init
//{
//    if (self = [super initWithStyle:EImageTopTitleBottom])
//    {
//        UIImage *icon = [UIImage imageWithColor:kRandomFlatColor size:CGSizeMake(50, 50)];
//        [self setImage:icon forState:UIControlStateNormal];
//        
//        _statusIcon = [UIImage imageWithColor:kRandomFlatColor size:CGSizeMake(16, 16)];
//        _statusIconView = [[UIImageView alloc] initWithImage:_statusIcon];
//        [self addSubview:_statusIconView];
//    }
//    return self;
//}

- (instancetype)initWithTitle:(NSString *)title icon:(UIImage *)icon action:(MenuAction)action
{
    if (self = [super initWithTitle:title icon:icon action:action])
    {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImage *selectIcon = [UIImage imageWithColor:kRandomFlatColor size:CGSizeMake(16, 16)];
        _statusIconView = [[UIImageView alloc] initWithImage:selectIcon];
        _statusIconView.hidden = YES;
        [self insertSubview:_statusIconView atIndex:0];
        
        self.backgroundColor = RGBA(80, 80, 80, 0.5);
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor flatTealColor]] forState:UIControlStateSelected];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    _statusIconView.hidden = !selected;
}


#define kDefaultIconSize CGSizeMake(40, 40)
#define kImageViewTitlePadding 10
#define kTitleHeight 20

- (void)relayoutFrameOfSubViews
{
    CGRect rect = self.bounds;

    
    UIImage *img = [self imageForState:UIControlStateNormal];
    
    
    CGSize size = kDefaultIconSize;
    
    if (!CGSizeEqualToSize(img.size, CGSizeZero))
    {
        size = img.size;
    }

    [self.imageView sizeWith:size];
    [self.imageView layoutParentHorizontalCenter];
    [self.imageView alignParentTopWithMargin:(rect.size.height - size.height - kImageViewTitlePadding - kTitleHeight)/2];
    
    [self.titleLabel sizeWith:CGSizeMake(rect.size.width, kTitleHeight)];
    [self.titleLabel layoutBelow:self.imageView margin:kImageViewTitlePadding];
    
    
    [_statusIconView sizeWith:CGSizeMake(16, 16)];
    [_statusIconView alignParentRight];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self relayoutFrameOfSubViews];
}


@end
