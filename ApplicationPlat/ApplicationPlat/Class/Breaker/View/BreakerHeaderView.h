//
//  BreakerHeaderView.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/12.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropertyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BreakerHeaderView : UIView
@property(nonatomic, copy)NSString *onLine;
@property(nonatomic, copy)PropertyModel *signal;
@property(nonatomic, copy)NSString *cycleStr;
@property(nonatomic, copy)NSString *iId;
@end

NS_ASSUME_NONNULL_END
