//
//  UserView.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/8.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN
@protocol UserViewDelegate <NSObject>

- (void)loginOut;
- (void)nextUpdateVc;
- (void)checkUpdateVersion;
- (void)notOpen;
@end

@interface UserView : UIView
@property(nonatomic, assign)id <UserViewDelegate>delegate;
@property(nonatomic, strong) UIImageView *versionBtn;
@end

NS_ASSUME_NONNULL_END
