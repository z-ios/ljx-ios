//
//  ModeAlertView.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/13.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModeAlertView : UIView
@property (nonatomic, copy) void(^determineBlock)(void);
@property (nonatomic, copy) void(^comBtnActionBlock)(NSString *modeString);
@property(nonatomic, copy)NSString *modeStr;
@end

NS_ASSUME_NONNULL_END
