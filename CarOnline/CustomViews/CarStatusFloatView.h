//
//  CarStatusFloatView.h
//  CarOnline
//
//  Created by James on 14-7-25.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VehicleGPSListItem;
@class VehicleListItem;

@protocol CarStatusFloatViewDelegate <NSObject>

- (void)onGetAddress:(NSString *)address;

@end

@interface CarStatusFloatView : UIView
{
    UILabel *_name;
    UILabel *_status;
    UILabel *_time;
    UILabel *_update;
    
    NSTimer *_timer;
   
}

@property (nonatomic, unsafe_unretained) id<CarStatusFloatViewDelegate> delegate;

- (void)startRequest;

- (void)stopRequest;


@end
