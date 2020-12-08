//
//  UILabel+Addition.h
//  ddd
//
//  Created by elco on 2018/4/23.
//  Copyright © 2018年 elco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Addition)

/// 创建文本标签
///
/// @param text     文本
/// @param fontSize 字体大小
/// @param color    颜色
///
/// @return UILabel
+ (instancetype)z_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color;
+ (instancetype)frame:(CGRect)frame title:(NSString *)title font:(UIFont *)font color:(UIColor *)color line:(NSInteger)line addView:(UIView *)addView;
+ (instancetype)z_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color CornerRadius:(CGFloat)radiusSize backgroundColor:(UIColor *)backgroundColor;

+ (instancetype)labelWithframe:(CGRect)frame title:(NSString *)title font:(UIFont *)font color:(UIColor *)color line:(NSInteger)line;
+ (instancetype)z_frame:(CGRect)frame Text:(NSString *)text font:(UIFont*)font color:(UIColor *)color;

@end
