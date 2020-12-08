//
//  SenceViewModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/8.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SenceViewModel : NSObject
// 获取版本列表
- (void)setUpdateListCallBack:(void (^)(NSUInteger statuCode,BOOL isSuccess ,NSError * error))callBack;
@end

NS_ASSUME_NONNULL_END
