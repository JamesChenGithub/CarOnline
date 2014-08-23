//
//  WebServiceDatas.h
//  CarOnline
//
//  Created by James on 14-8-19.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  GroupListItem: NSObject

@property (nonatomic, copy) NSString *GroupCode;
@property (nonatomic, copy) NSString *GroupName;
@property (nonatomic, strong) NSMutableArray *VehicleList;

@end


//"VehicleNumber": "253501101103709",
//"VehicleStatus": "0",
//"Distance": 0,
//"SpeedAlert": 0,
//"Enclosure": 0,
//"DeviceName": "TEST709"
@interface VehicleListItem : NSObject

@property (nonatomic, copy) NSString *VehicleNumber;
@property (nonatomic, copy) NSString *VehicleStatus;
@property (nonatomic, assign) CGFloat Distance;
@property (nonatomic, assign) CGFloat SpeedAlert;
@property (nonatomic, assign) CGFloat Enclosure;
@property (nonatomic, copy) NSString *DeviceName;

@end

//{
//    "ID": 828980,
//    "VehicleNumber": "253501101103709",
//    "VehicleSpeed": 0,
//    "Longitude": 114.110640666667,
//    "Latidude": 22.6170116666667,
//    "Date": "2014-08-03 10:12:28",
//    "Status": "0",
//    "Direction": null,
//    "DirectionDegree": 17,
//    "DeviceName": "TEST709",
//    "Address": "中国广东省深圳市龙岗区大靓花园三区一巷3号",
//    "SpeedAlert": 90,
//    "Distance": 3260.15
//}
@interface VehicleGPSListItem : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *VehicleNumber;
@property (nonatomic, assign) CGFloat VehicleSpeed;
@property (nonatomic, assign) CGFloat Longitude;
@property (nonatomic, assign) CGFloat Latidude;
@property (nonatomic, copy) NSString *Date;
@property (nonatomic, copy) NSString *Status;
@property (nonatomic, copy) NSString *Direction;
@property (nonatomic, assign) CGFloat DirectionDegree;
@property (nonatomic, copy) NSString *DeviceName;
@property (nonatomic, copy) NSString *Address;
@property (nonatomic, assign) CGFloat SpeedAlert;
@property (nonatomic, assign) CGFloat Distance;


@end

@interface AlertListItem : NSObject

//"AlertId": "165",
//"AlertType": "",
//"AlertOn": "2014-08-15 10:57:52",
//"VehicleNumber": "",
//"AlertContent": "童心铃?网络视频心率体温仪（英文名：ipBCS）是一项高科技专利产品，是一件用于监护宝宝的可穿戴利器。\r\n\r\n      ipBCS将宝宝心率体温及所处环境的音视频等主要信息通过英特网实现对宝宝的远程监护。按照以下步骤将轻松掌握ipBCS的使用。",
//"AlertAddress": "",
//"DeviceName": "",
//"MessageType": "2"

@property (nonatomic, copy) NSString *AlertId;
@property (nonatomic, copy) NSString *AlertType;
@property (nonatomic, copy) NSString *AlertOn;
@property (nonatomic, copy) NSString *VehicleNumber;
@property (nonatomic, copy) NSString *AlertContent;
@property (nonatomic, copy) NSString *AlertAddress;
@property (nonatomic, copy) NSString *DeviceName;
@property (nonatomic, copy) NSString *MessageType;

@end