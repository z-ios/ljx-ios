//
//  LoginView.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/8/27.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol LoginViewDelegate <NSObject>

- (void)pushTestLineController;
- (void)loginSuccess;

@end

@interface LoginView : UIView
@property(nonatomic, assign)id<LoginViewDelegate> delegate;
// 读取ip地址
- (void)readIp;
@end

NS_ASSUME_NONNULL_END
