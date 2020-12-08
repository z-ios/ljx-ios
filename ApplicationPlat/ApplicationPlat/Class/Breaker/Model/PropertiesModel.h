//
//  PropertiesModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/12/2.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PropertyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PropertiesModel : NSObject
@property(nonatomic, strong)PropertyModel *nominal_voltage;
@property(nonatomic, strong)PropertyModel *rated_current;
@property(nonatomic, strong)PropertyModel *maximum_current;
@property(nonatomic, strong)PropertyModel *active_power_const;
@property(nonatomic, strong)PropertyModel *open_close;
@property(nonatomic, strong)PropertyModel *model;
@property(nonatomic, strong)PropertyModel *mac;
@property(nonatomic, strong)PropertyModel *hardware_datetime;
@property(nonatomic, strong)PropertyModel *electric_quantity;
@property(nonatomic, strong)PropertyModel *voltage;
@property(nonatomic, strong)PropertyModel *electric_current;
@property(nonatomic, strong)PropertyModel *power;
@property(nonatomic, strong)PropertyModel *temperature;
@property(nonatomic, strong)PropertyModel *work_mode;
@property(nonatomic, strong)PropertyModel *signal;

//获取对象的所有属性
- (NSArray *)getAllProperties;
@end

NS_ASSUME_NONNULL_END
