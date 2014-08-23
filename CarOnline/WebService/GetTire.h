//
//  GetTire.h
//  CarOnline
//
//  Created by James on 14-8-6.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "BaseRequest.h"

@interface GetTire : OBDBaseRequest

@end


//{"Tpms1":35,"Temp1":112,"Tpms2":69,"Temp2":128,"Tpms3":103,"Temp3":144,"Tpms4":137,"Temp4":160}}

@interface GetTireResponseBody : BaseResponseBody

@property (nonatomic, assign) NSInteger Tpms1;
@property (nonatomic, assign) NSInteger Temp1;
@property (nonatomic, assign) NSInteger Tpms2;
@property (nonatomic, assign) NSInteger Temp2;
@property (nonatomic, assign) NSInteger Tpms3;
@property (nonatomic, assign) NSInteger Temp3;
@property (nonatomic, assign) NSInteger Tpms4;
@property (nonatomic, assign) NSInteger Temp4;

@end
