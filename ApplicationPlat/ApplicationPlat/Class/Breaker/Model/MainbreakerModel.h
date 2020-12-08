//
//  MainbreakerModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataItemModel.h"
#import "PropertiesModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MainbreakerModel : NSObject
@property(nonatomic, copy)NSString *address_485;
@property(nonatomic, copy)NSString *address_mac;
@property(nonatomic, copy)NSString *address_485_pad;
@property(nonatomic, strong)PropertiesModel *data_properties;
//@property(nonatomic, strong)NSArray *data_items;
//"address_485": 0,
//    "address_mac": "8590234560",
//    "address_485_pad": "00",
@end

NS_ASSUME_NONNULL_END
