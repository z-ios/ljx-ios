//
//  EquipmentModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/9.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EquipmentModel : NSObject
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *descriptions;
@property(nonatomic, copy)NSString *web_icon_url;
@property(nonatomic, copy)NSString *phone_icon_url;
@property(nonatomic, copy)NSString *iId;



//"name": "无线温感",
//   "description": "数据项以DL/T 645-2007《多功能电能表》为依据。",
//   "web_icon_url": "/images/icons/pc/wuxianwengan.svg",
//   "phone_icon_url": "/images/icons/phone/wuxianwengan.svg",
//   "id": 6709011649595007000


@end

NS_ASSUME_NONNULL_END
