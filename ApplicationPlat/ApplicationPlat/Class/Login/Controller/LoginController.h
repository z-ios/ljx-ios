//
//  LoginController.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/8/27.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LoginControllerDelegate <NSObject>

- (void)loginSuccessBack;

@end


@interface LoginController : UIViewController
@property(nonatomic, assign)id<LoginControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
