//
//  DeviceListCell.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/9.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BreakerModel.h"
#import "MGSwipeTableCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface DeviceListCell : MGSwipeTableCell
@property(nonatomic, strong)BreakerModel *model;
@end

NS_ASSUME_NONNULL_END
