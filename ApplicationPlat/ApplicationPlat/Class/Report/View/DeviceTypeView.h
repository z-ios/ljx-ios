//
//  DeviceTypeView.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/2.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceTypeView : UIView
@property (nonatomic, copy) void(^determineBlock)(void);
@property(nonatomic, strong)void(^selectTypeBlock)(NSString * name);
@end

NS_ASSUME_NONNULL_END
