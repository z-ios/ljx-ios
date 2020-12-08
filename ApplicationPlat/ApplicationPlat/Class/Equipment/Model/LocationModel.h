//
//  LocationModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationModel : NSObject
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *province_name;
@property(nonatomic,copy)NSString *city_name;
@property(nonatomic,copy)NSString *district_name;
@end

NS_ASSUME_NONNULL_END
