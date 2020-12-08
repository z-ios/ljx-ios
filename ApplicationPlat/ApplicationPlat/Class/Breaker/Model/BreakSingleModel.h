//
//  BreakSingleModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GatewayModel.h"
#import "MainbreakerModel.h"
//#import "BreakSingleModel.h"
#import "KnobswitchModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BreakSingleModel : NSObject


@property(nonatomic, strong)GatewayModel *gateway;
@property(nonatomic, strong)MainbreakerModel *main_breaker;
@property(nonatomic, strong)KnobswitchModel *knob_switch;
@property(nonatomic, strong)NSArray<MainbreakerModel *> *branch_breakers;

//{
//  "location": {
//    "lat": "39.915085",
//    "lng": "116.3683244",
//    "country_name": "中华人民共和国",
//    "country_adcode": 100000,
//    "province_name": "天津市",
//    "province_adcode": 120000,
//    "city_name": "天津城区",
//    "city_adcode": 120100,
//    "district_name": "西青区",
//    "district_adcode": 120111,
//    "street_name": "西青开发区",
//    "street_adcode": 120111,
//    "address": "天津市西青区西青经济开发区赛达四支路12号"
//  },
//  "edit_info": {
//    "installation_user": "系统管理员",
//    "installation_datetime": "2020-01-01T10:10:10Z",
//    "lastest_edit_user": "系统管理员",
//    "lastest_edit_datetime": "2020-01-01T10:10:15Z"
//  },
//  "state": {
//    "onlineState": {
//      "online_state": 1,
//      "description": "在线",
//      "record_time": "0001-01-01T00:00:00"
//    },
//    "alarmState": {
//      "alarm_state": 0,
//      "description": "正常",
//      "record_time": "0001-01-01T00:00:00"
//    }
//  },
//  "knob_switch": {
//    "current_mode": 1,
//    "description": "自动"
//  },
//  "gateway": {
//    "node_Id": "6043552190",
//    "model": "GW400-0001506",
//    "state": {
//      "online_state": 1,
//      "description": "在线",
//      "record_time": "0001-01-01T00:00:00"
//    },
//    "iothub_regist_info": {
//      "thing_type": "mqtt.generic",
//      "thing_id": 27,
//      "thing_title": "Mqtt: Generic (6043552190)",
//      "instance": {
//        "instance_name": "阿里云-研发部-1",
//        "root_ip": "47.105.62.95",
//        "api_port": "80",
//        "mqtt_port": "1885",
//        "http_protocol": "http",
//        "version": "v2",
//        "username": "admin",
//        "password": "elco",
//        "id": null
//      }
//    },
//    "data_items": [
//      {
//        "origin_data": "9021554360",
//        "converted_data": "6043552190",
//        "protocol_key": "EE010102",
//        "protocol_desc": "MAC地址",
//        "protocol": null
//      },
//      {
//        "origin_data": "80000010",
//        "converted_data": "-80",
//        "protocol_key": "02800101",
//        "protocol_desc": "信号强度",
//        "protocol": null
//      }
//    ]
//  },
//  "main_breaker": {
//    "address_485": 0,
//    "data_items": [
//      {
//        "origin_data": "",
//        "converted_data": "自动",
//        "protocol_key": "ED000301",
//        "protocol_desc": "模式",
//        "protocol": null
//      },
//      {
//        "origin_data": "00",
//        "converted_data": "合闸",
//        "protocol_key": "E1010201",
//        "protocol_desc": "开合闸状态",
//        "protocol": null
//      },
//      {
//        "origin_data": "9590050017303219",
//        "converted_data": "590.95,2020-01-01 10:10:10",
//        "protocol_key": "00000000",
//        "protocol_desc": "电量",
//        "protocol": null
//      },
//      {
//        "origin_data": "000000E0",
//        "converted_data": "0",
//        "protocol_key": "02030000",
//        "protocol_desc": "功率",
//        "protocol": null
//      },
//      {
//        "origin_data": "29000000",
//        "converted_data": "29",
//        "protocol_key": "02800007",
//        "protocol_desc": "温度",
//        "protocol": null
//      },
//      {
//        "origin_data": "552300A0",
//        "converted_data": "230.55",
//        "protocol_key": "02010100",
//        "protocol_desc": "电压",
//        "protocol": null
//      },
//      {
//        "origin_data": "000000C0",
//        "converted_data": "0",
//        "protocol_key": "02020100",
//        "protocol_desc": "电流",
//        "protocol": null
//      }
//    ]
//  },
//  "branch_breakers": [
//    {
//      "address_485": 1,
//      "data_items": [
//        {
//          "origin_data": "",
//          "converted_data": "自动",
//          "protocol_key": "ED000301",
//          "protocol_desc": "模式",
//          "protocol": null
//        },
//        {
//          "origin_data": "00",
//          "converted_data": "合闸",
//          "protocol_key": "E1010201",
//          "protocol_desc": "开合闸状态",
//          "protocol": null
//        },
//        {
//          "origin_data": "9590050017303219",
//          "converted_data": "590.95,2020-01-01 10:10:10",
//          "protocol_key": "00000000",
//          "protocol_desc": "电量",
//          "protocol": null
//        },
//        {
//          "origin_data": "000000E0",
//          "converted_data": "0",
//          "protocol_key": "02030000",
//          "protocol_desc": "功率",
//          "protocol": null
//        },
//        {
//          "origin_data": "29000000",
//          "converted_data": "29",
//          "protocol_key": "02800007",
//          "protocol_desc": "温度",
//          "protocol": null
//        },
//        {
//          "origin_data": "552300A0",
//          "converted_data": "230.55",
//          "protocol_key": "02010100",
//          "protocol_desc": "电压",
//          "protocol": null
//        },
//        {
//          "origin_data": "000000C0",
//          "converted_data": "0",
//          "protocol_key": "02020100",
//          "protocol_desc": "电流",
//          "protocol": null
//        }
//      ]
//    },
//    {
//      "address_485": 2,
//      "data_items": [
//        {
//          "origin_data": "",
//          "converted_data": "自动",
//          "protocol_key": "ED000301",
//          "protocol_desc": "模式",
//          "protocol": null
//        },
//        {
//          "origin_data": "00",
//          "converted_data": "合闸",
//          "protocol_key": "E1010201",
//          "protocol_desc": "开合闸状态",
//          "protocol": null
//        },
//        {
//          "origin_data": "9590050017303219",
//          "converted_data": "590.95,2020-01-01 10:10:10",
//          "protocol_key": "00000000",
//          "protocol_desc": "电量",
//          "protocol": null
//        },
//        {
//          "origin_data": "000000E0",
//          "converted_data": "0",
//          "protocol_key": "02030000",
//          "protocol_desc": "功率",
//          "protocol": null
//        },
//        {
//          "origin_data": "29000000",
//          "converted_data": "29",
//          "protocol_key": "02800007",
//          "protocol_desc": "温度",
//          "protocol": null
//        },
//        {
//          "origin_data": "552300A0",
//          "converted_data": "230.55",
//          "protocol_key": "02010100",
//          "protocol_desc": "电压",
//          "protocol": null
//        },
//        {
//          "origin_data": "000000C0",
//          "converted_data": "0",
//          "protocol_key": "02020100",
//          "protocol_desc": "电流",
//          "protocol": null
//        }
//      ]
//    },
//    {
//      "address_485": 3,
//      "data_items": [
//        {
//          "origin_data": "",
//          "converted_data": "自动",
//          "protocol_key": "ED000301",
//          "protocol_desc": "模式",
//          "protocol": null
//        },
//        {
//          "origin_data": "00",
//          "converted_data": "合闸",
//          "protocol_key": "E1010201",
//          "protocol_desc": "开合闸状态",
//          "protocol": null
//        },
//        {
//          "origin_data": "9590050017303219",
//          "converted_data": "590.95,2020-01-01 10:10:10",
//          "protocol_key": "00000000",
//          "protocol_desc": "电量",
//          "protocol": null
//        },
//        {
//          "origin_data": "000000E0",
//          "converted_data": "0",
//          "protocol_key": "02030000",
//          "protocol_desc": "功率",
//          "protocol": null
//        },
//        {
//          "origin_data": "29000000",
//          "converted_data": "29",
//          "protocol_key": "02800007",
//          "protocol_desc": "温度",
//          "protocol": null
//        },
//        {
//          "origin_data": "552300A0",
//          "converted_data": "230.55",
//          "protocol_key": "02010100",
//          "protocol_desc": "电压",
//          "protocol": null
//        },
//        {
//          "origin_data": "000000C0",
//          "converted_data": "0",
//          "protocol_key": "02020100",
//          "protocol_desc": "电流",
//          "protocol": null
//        }
//      ]
//    }
//  ],
//  "device_category": {
//    "dc_id": 1,
//    "name": "智能断路器",
//    "description": "数据项以DL/T 645-2007《多功能电能表》为依据。",
//    "web_icon_url": "/images/icons/pc/weixingduanluqi.svg",
//    "phone_icon_url": "/images/icons/phone/weixingduanluqi.svg"
//  },
//  "id": "5f8414f60b7f6c4c826a6d02"
//}
@end

NS_ASSUME_NONNULL_END
