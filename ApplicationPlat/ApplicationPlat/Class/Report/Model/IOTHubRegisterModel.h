//
//  IOTHubRegisterModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/5.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IothubModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface IOTHubRegisterModel : UIView

@property(nonatomic, copy)NSString *thing_type;
@property(nonatomic, copy)NSString *thing_id;
@property(nonatomic, copy)NSString *thing_title;
@property(nonatomic, strong)IothubModel *instance;

//{
//  "thing_type": "mqtt.generic",
//  "thing_id": 27,
//  "thing_title": "Mqtt: Generic (6043552190)",
//  "instance": {
//    "instance_name": "阿里云-研发部-1",
//    "root_ip": "47.105.62.95",
//    "api_port": "80",
//    "mqtt_port": "1885",
//    "http_protocol": "http",
//    "version": "v2",
//    "username": "admin",
//    "password": "elco",
//    "id": "5f964167c4a0d249660994f2"
//  }
//}
@end

NS_ASSUME_NONNULL_END
