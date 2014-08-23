//
//  GPSMainViewController.h
//  CarOnline
//
//  Created by James on 14-7-25.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "BaseViewController.h"
#import "BMKMapView.h"

@interface GPSMainViewController : BaseViewController<CarStatusFloatViewDelegate, GPSMainFloatPanelDelegate>
{
    BMKMapView *_mapView;
    
    CarStatusFloatView *_floatView;
    
    GPSMainFloatPanel *_floatPanel;
    
    BOOL _hadGetDevList;
    
//    UIButton *_carManage;
//    UIButton *_OBD;
//    UIButton *_message;
//    UIButton *_zoomAdd;
//    UIButton *_zoomDec;
    
    
    
}

@end
