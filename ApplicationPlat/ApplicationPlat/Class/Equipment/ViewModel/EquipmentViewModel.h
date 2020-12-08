//
//  EquipmentViewModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/9.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EquipmentViewModel : NSObject
//设备查询
- (void)deviceCheckDataCompletion:(void (^ __nullable)(BOOL success,NSArray *dataList))completion;

//获取断路器集合
- (void)breakerDatasWithParams:(NSDictionary *)params Completion:(void (^ __nullable)(BOOL success,NSArray *dataList, NSString *total, NSString *errorMsg))completion;
//断路器查询个数
- (void)breakerCountWithParams:(NSString *)node_Id Completion:(void (^ __nullable)(BOOL success,NSString *count, NSString *errorMsg))completion;
// 删除整套断路器
- (void)deleteBreakerWithParams:(NSString *)iId Completion:(void (^ __nullable)(BOOL success, NSString *errorMsg))completion;

// 更改位置
- (void)updateBreakerLocationWithParams:(NSDictionary *)params Completion:(void (^ __nullable)(BOOL success, NSString *errorMsg))completion;

@end

NS_ASSUME_NONNULL_END
