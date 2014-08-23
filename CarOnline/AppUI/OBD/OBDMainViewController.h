//
//  OBDMainViewController.h
//  CarOnline
//
//  Created by James on 14-7-22.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "BaseViewController.h"

@interface OBDMainViewController : BaseViewController<CarStatusFloatViewDelegate>
{
    CarStatusFloatView *_floatView;
    
    NSMutableArray *_OBDItems;
    
    UIScrollView *_scrollView;
    
    NSMutableArray *_OBDButtons;

    OBDFloatPanel *_floatPanel;
}

@end
