//
//  CustomAlert.h
//  light
//
//  Created by ljxMac on 2019/11/28.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomAlert : NSObject
- (instancetype)initAlert:(NSString *)title;
- (instancetype)initAlert:(NSString *)title btnTitle:(NSString *)btnTitle cancleTitle:(NSString *)cancleBtnTitle;
- (void)show;
@property (nonatomic, copy) void(^determineBlock)(void);

+ (void)alertVcWithMessage:(NSString *)msg Vc:(UIViewController *)vc;
@end

NS_ASSUME_NONNULL_END
