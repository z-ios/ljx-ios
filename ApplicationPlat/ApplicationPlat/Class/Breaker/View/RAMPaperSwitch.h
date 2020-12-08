//
//  RAMPaperSwitch.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/23.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RAMPaperSwitch : UISwitch
@property(nonatomic, strong)void(^animationDidStartClosure)(BOOL onAnimation);
@property(nonatomic, strong)void(^animationDidStopClosure)(BOOL onAnimation,BOOL finished);
@property(nonatomic, strong)void(^swithTagBlock)(BOOL onAnimation);

@property(nonatomic, strong) UIView *parentView;
- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView color:(UIColor *)color bgColor:(UIColor *)bgColor;

@end

NS_ASSUME_NONNULL_END
