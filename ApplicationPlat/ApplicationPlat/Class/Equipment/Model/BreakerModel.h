//
//  BreakerModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/14.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
//@class StateModel,GatewayModel,LocationModel;
#import "StateModel.h"
#import "GatewayModel.h"
#import "LocationModel.h"
#import "EditInfoModel.h"
NS_ASSUME_NONNULL_BEGIN





@interface BreakerModel : NSObject
@property(nonatomic, copy)NSString *iId;
@property(nonatomic, strong)EditInfoModel *edit_info;
@property(nonatomic, strong)GatewayModel *gateway;
@property(nonatomic, strong)LocationModel *location;


//"converted_data": "6043552190",
//"converted_data2": "866280025598641",
//"csq": "-36 db",
//"online_state": 1,
//"online_state_text": "在线",
//"address": "天津市西青区赛达路与赛达北四道交叉路口往东南约50米(赤龙家园南侧)",
//"province_name": "天津市",
//"city_name": "天津城区",
//"district_name": "西青区",
//"province_adcode": 120000,
//"city_adcode": 120100,
//"district_adcode": 120111,
//"device_category_text": "智能断路器",
//"device_category_id": 1,
//"model": "GW400-0001506",
//"production_datetime": "2020-03-21T00:00:00",
//"id": 6709706088503296000

//[
//  {
//    "id": "5f8414f60b7f6c4c826a6d02",
//    "state": {
//      "onlineState": {
//        "online_state": 1,
//        "description": "在线",
//        "record_time": "0001-01-01T00:00:00"
//      },
//      "alarmState": {
//        "alarm_state": 0,
//        "description": "正常",
//        "record_time": "0001-01-01T00:00:00"
//      }
//    },
//    "gateway": {
//      "node_Id": "6043552190",
//      "model": "GW400-0001506",
//      "data_items": [
//        {
//          "origin_data": "9021554360",
//          "converted_data": "6043552190",
//          "protocol_key": "EE010102",
//          "protocol_desc": "MAC地址",
//          "protocol": null
//        },
//        {
//          "origin_data": "80000010",
//          "converted_data": "-80",
//          "protocol_key": "02800101",
//          "protocol_desc": "信号强度",
//          "protocol": null
//        }
//      ]
//    },
//    "location": {
//      "address": "天津市西青区西青经济开发区赛达四支路12号",
//      "province_name": "天津市",
//      "city_name": "天津城区",
//      "district_name": "西青区"
//    }
//  }
//]







@end

NS_ASSUME_NONNULL_END
