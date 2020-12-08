//
//  IothubModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/3.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IothubModel : NSObject
@property(nonatomic, copy)NSString *instance_name;
@property(nonatomic, copy)NSString *root_ip;
@property(nonatomic, copy)NSString *api_port;
@property(nonatomic, copy)NSString *mqtt_port;
@property(nonatomic, copy)NSString *http_protocol;
@property(nonatomic, copy)NSString *version;
@property(nonatomic, copy)NSString *username;
@property(nonatomic, copy)NSString *password;
@property(nonatomic, copy)NSString *iId;
@property(nonatomic, assign)BOOL isDefault;


//"instance_name": "阿里云-研发部-2",
//   "root_ip": "47.92.138.208",
//   "api_port": "8080",
//   "mqtt_port": "1883",
//   "http_protocol": "http",
//   "version": "v1",
//   "username": "root",
//   "password": "toor",
//   "isDefault": false,
//   "id": "5f964272c4a0d249660994f3"
@end

NS_ASSUME_NONNULL_END
