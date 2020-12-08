//
//  LoginViewModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/8/28.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject
// 登录
- (void)loginPhoneStr:(NSString *)phoneStr pwdStr:(NSString *)pwdStr success:(void (^)(BOOL isSuccess, NSString *errorMsg))success;

// 测试服务器
- (void)testingWithIp:(NSString *)str success:(void (^)(BOOL isSuccess, NSString *errorMsg))success;
// 设置默认IP地址
- (void)judgeIpOrAdress;
@end

NS_ASSUME_NONNULL_END
