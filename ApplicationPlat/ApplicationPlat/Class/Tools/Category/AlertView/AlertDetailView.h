//
//  AlertDetailView.h
//  light
//
//  Created by ljxMac on 2019/11/28.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertDetailView : UIView
- (instancetype)initWithFrame:(CGRect)frame type:(NSString *)type;
@property (nonatomic, copy) void(^determineBlock)(void);
@property (nonatomic, copy) void(^comBtnActionBlock)(void);

@property (nonatomic, copy)NSString *textStr;
@property (nonatomic, copy)NSString *btnStr;
@property (nonatomic, copy)NSString *cancleBtnTitle;

@end

NS_ASSUME_NONNULL_END
