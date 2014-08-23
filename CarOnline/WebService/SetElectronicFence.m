//
//  SetElectronicFence.m
//  CarOnline
//
//  Created by James on 14-8-6.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "SetElectronicFence.h"

@implementation SetElectronicFence

- (NSDictionary *)bodyDictionary
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic addString:self.VehicleNumber forKey:@"VehicleNumber"];
    [dic addCGFloat:self.Enclosure forKey:@"Enclosure"];
    [dic addCGFloat:self.Latidude forKey:@"Latidude"];
    [dic addCGFloat:self.Longitude forKey:@"Longitude"];
    [dic addBOOL:self.IsEnable forKey:@"IsEnable"];
    
    return dic;
}

@end
