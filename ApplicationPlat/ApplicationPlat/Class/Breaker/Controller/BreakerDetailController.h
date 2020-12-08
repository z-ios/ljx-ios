//
//  BreakerDetailController.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/22.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollPageViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface BreakerDetailController : ScrollPageViewController <ScrollPageViewControllerProtocol>
@property(nonatomic, copy)NSString *address_485;
@property(nonatomic, copy)NSString *iId;
@end

NS_ASSUME_NONNULL_END
