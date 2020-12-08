//
//  SearchModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/15.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchModel : NSObject
@property(nonatomic, copy)NSString *mac;
@property(nonatomic, copy)NSString *start_datetime;
@property(nonatomic, copy)NSString *end_datetime;
@property(nonatomic, copy)NSString *province_adcode;
@property(nonatomic, copy)NSString *city_adcode;

@property(nonatomic, copy)NSString *district_adcode;
@property(nonatomic, copy)NSString *street_adcode;
@property(nonatomic, copy)NSString *page_number;
@property(nonatomic, copy)NSString *page_size;

@end

NS_ASSUME_NONNULL_END
