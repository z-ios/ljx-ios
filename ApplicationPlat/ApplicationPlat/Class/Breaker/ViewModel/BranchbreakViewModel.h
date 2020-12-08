//
//  BranchbreakViewModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BreakSingleModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BranchbreakViewModel : NSObject
// 获取单个断路器集合
- (void)breakerWithParams:(NSString *)iId Completion:(void (^ __nullable)(BOOL success,BreakSingleModel *model, NSString *errorMsg))completion;

// 绑定子断路器
- (void)bindBreakerWithParams:(NSDictionary *)params Completion:(void (^ __nullable)(BOOL success, NSString *errorMsg))completion;
// 解绑子断路器
- (void)deleteChildBreakerWithParams:(NSDictionary *)params Completion:(void (^ __nullable)(BOOL success, NSString *errorMsg))completion;

// 合闸
- (void)breakerOpenWithParams:(NSDictionary *)params Completion:(void (^ __nullable)(BOOL success, NSString *errorMsg))completion;

// 跳闸
- (void)breakerCloseWithParams:(NSDictionary *)params Completion:(void (^ __nullable)(BOOL success, NSString *errorMsg))completion;
// 更改上报周期
- (void)setPeriodWithParams:(NSDictionary *)params Completion:(void (^ __nullable)(BOOL success, NSString *errorMsg))completion;

// 更新模式下发-手动和自动
- (void)breakerModeWithParams:(NSDictionary *)params isAuto:(BOOL )isAuto Completion:(void (^ __nullable)(BOOL success, NSString *errorMsg))completion;





@end

NS_ASSUME_NONNULL_END
