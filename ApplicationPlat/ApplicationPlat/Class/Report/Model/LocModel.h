//
//  LocModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/10.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocModel : NSObject
@property(nonatomic, copy)NSString *lat;
@property(nonatomic, copy)NSString *lng;
@property(nonatomic, copy)NSString *country_name;
@property(nonatomic, copy)NSString *country_adcode;
@property(nonatomic, copy)NSString *province_name;
@property(nonatomic, copy)NSString *province_adcode;
@property(nonatomic, copy)NSString *city_name;
@property(nonatomic, copy)NSString *city_adcode;
@property(nonatomic, copy)NSString *district_name;
@property(nonatomic, copy)NSString *district_adcode;
@property(nonatomic, copy)NSString *street_name;
@property(nonatomic, copy)NSString *street_adcode;
@property(nonatomic, copy)NSString *address;
@end

NS_ASSUME_NONNULL_END
