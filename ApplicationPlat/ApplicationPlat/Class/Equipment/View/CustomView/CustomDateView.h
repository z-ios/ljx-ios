//
//  CustomDateView.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/11.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomDateView : UIView
@property(nonatomic,copy)void(^cancleBack)(void);
@property(nonatomic,copy)void(^setTimeBack)(NSString *startDate, NSString *endDate);
@end

NS_ASSUME_NONNULL_END
