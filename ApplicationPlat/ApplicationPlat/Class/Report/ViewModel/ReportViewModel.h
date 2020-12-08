//
//  ReportViewModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/3.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IOTHubRegisterModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReportViewModel : UIView
//获取系统中所有IoTHub文档 按名称正序排列
- (void)iotHubDataCompletion:(void (^ __nullable)(BOOL success,NSArray *dataList, NSString *errorMsg))completion;

// IoTHub注册验证
- (void)iotHubRegisterWithParams:(NSDictionary *)params Completion:(void (^ __nullable)(BOOL success,NSString *msg,IOTHubRegisterModel *model))completion;

// 设备 注册
- (void)deviceRegisterWithParams:(NSDictionary *)params Completion:(void (^ __nullable)(BOOL success,NSString *msg,NSString *iId))completion;

@end

NS_ASSUME_NONNULL_END
