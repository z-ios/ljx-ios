//
//  AlertTypeView.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/13.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertTypeView : UIView
@property (nonatomic, copy) void(^determineBlock)(void);

@property(nonatomic, strong)NSArray *array;
@end

NS_ASSUME_NONNULL_END
