//
//  BreakerAlertView.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/16.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BreakerAlertView : UIView
@property(nonatomic, strong)void(^updateAlertHeight)(CGFloat height);

@property(nonatomic, strong)NSArray *array;
@end

NS_ASSUME_NONNULL_END
