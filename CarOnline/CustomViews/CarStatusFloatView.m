//
//  CarStatusFloatView.m
//  CarOnline
//
//  Created by James on 14-7-25.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "CarStatusFloatView.h"
#import <CoreText/CoreText.h>

@implementation CarStatusFloatView

#define kTimerInterval 10

static NSInteger _sharedCount = kTimerInterval;


- (void)addOwnViews
{
    CGFloat font = 12;
    UIColor *textColor = kWhiteColor;
    _name = [UILabel centerlabelWith:nil font:font textColor:textColor];
    [self addSubview:_name];
    
    _status = [UILabel centerlabelWith:nil font:font textColor:textColor];
    [self addSubview:_status];
    
    _time = [UILabel centerlabelWith:nil font:font textColor:textColor];
    [self addSubview:_time];
    
//    _update = [UILabel centerlabelWith:@"" font:font];
    _update = [[UILabel alloc] init];
    _update.textColor = kWhiteColor;
    _update.font = [UIFont systemFontOfSize:font];;
    _update.backgroundColor = kClearColor;

    [self addSubview:_update];
    
    self.backgroundColor = [UIColor flatDarkGreenColor];
}

- (void)configOwnViews
{
}

- (void)stopRequest
{
    [_timer invalidate];
    _timer = nil;
}

- (void)setGPSListItem:(VehicleGPSListItem *)gps
{
//    {"VehicleGPSList":[{"ID":828980,"VehicleNumber":"253501101103709","VehicleSpeed":0,"Longitude":114.110640666667,"Latidude":22.6170116666667,"Date":"2014-08-03 10:12:28","Status":"0","Direction":null,"DirectionDegree":17,"DeviceName":"TEST709","Address":"中国广东省深圳市龙岗区大靓花园三区一巷3号","SpeedAlert":85,"Distance":3260.15}]}
    _name.text = gps.DeviceName;
    
    _status.text = gps.Status.integerValue == 0 ?  @"离线" :  gps.VehicleSpeed == 0 ? @"静止" : @"运动";
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *date = [dateFormat dateFromString:gps.Date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    int hour = (int)[comps hour];
    int min = (int)[comps minute];
    int sec = (int)[comps second];
    _time.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hour, min,sec];
    
    if ([_delegate respondsToSelector:@selector(onGetAddress:)]) {
        [_delegate onGetAddress:gps.Address];
    }
}

- (void)startRequest
{
    [self stopRequest];
    
//    [self updateText];
    
    if (_sharedCount >= kTimerInterval)
    {
        [self requestGPS];
    }
    
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateCount) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];

}

- (void)updateCount
{
    _sharedCount--;
    [self updateText];
}

- (void)updateText
{
    NSString *countStr = [NSString stringWithFormat:@"%ld", (long)_sharedCount];
    NSString *updateStr = @"秒后刷新";
    
    NSString *info = [NSString stringWithFormat:@"%@%@", countStr, updateStr];
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:info];
    
    //把countStr的字体颜色变为红色
    [attriString addAttribute:(NSString *)kCTForegroundColorAttributeName
                        value:(id)kRedColor.CGColor
                        range:NSMakeRange(0, countStr.length)];
    
    //改变countStr的字体，value必须是一个CTFontRef
    [attriString addAttribute:(NSString *)kCTFontAttributeName
                        value:[UIFont systemFontOfSize:12]
                        range:NSMakeRange(0, countStr.length)];
    
    //把updateStr变为黄色
    [attriString addAttribute:(NSString *)kCTForegroundColorAttributeName
                        value:(id)kWhiteColor.CGColor
                        range:NSMakeRange(countStr.length, updateStr.length)];
    
    [attriString addAttribute:(NSString *)kCTFontAttributeName
                        value:[UIFont systemFontOfSize:12]
                        range:NSMakeRange(countStr.length, updateStr.length)];
    _update.text = nil;
    _update.attributedText = attriString;
    
    if (_sharedCount == 0) {
        // TODO:请求数据
        
        [self requestGPS];
        
        _sharedCount = kTimerInterval + 1;
    }
}

- (void)requestGPS
{
    WebServiceEngine *eng = [WebServiceEngine sharedEngine];
    
    if (![NSString isEmpty:eng.vehicle.VehicleNumber])
    {
        __weak typeof(self) weakSelf = self;
        GetGpsData *gps = [[GetGpsData alloc] initWithHandler:^(BaseRequest *request) {
            GetGpsDataResponseBody *body = (GetGpsDataResponseBody *)request.response.Body;
            if (body.VehicleGPSList.count)
            {
                [weakSelf setGPSListItem:body.VehicleGPSList[0]];
            }
        }];
        
        gps.VehicleNumbers = eng.vehicle.VehicleNumber;
        [eng asyncRequest:gps wait:NO];
    }
}

#define kLineCount 1

- (void)relayoutFrameOfSubViews
{
    CGRect rect = self.bounds;
    
    NSInteger colum = 4/kLineCount;

    [self gridViews:self.subviews inColumn:colum size:CGSizeMake(rect.size.width / colum, kCarStatusFloatViewHeight/(4/colum)) margin:CGSizeZero inRect:rect];
}

@end
