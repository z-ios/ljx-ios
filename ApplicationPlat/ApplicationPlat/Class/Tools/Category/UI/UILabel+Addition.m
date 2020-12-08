//
//  UILabel+Addition.m
//  ddd
//
//  Created by elco on 2018/4/23.
//  Copyright © 2018年 elco. All rights reserved.
//

#import "UILabel+Addition.h"

@implementation UILabel (Addition)

+ (instancetype)z_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color {
    UILabel *label = [[self alloc] init];
    
    label.text = text;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = color;
    label.numberOfLines = 0;
    
    return label;
}

+ (instancetype)z_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color CornerRadius:(CGFloat)radiusSize backgroundColor:(UIColor *)backgroundColor
{
    UILabel *label = [[self alloc] init];
    label.text = text;
    label.font = [UIFont boldSystemFontOfSize:fontSize];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = color;
    label.numberOfLines = 0;
    [label.layer setMasksToBounds:YES];
    [label.layer setCornerRadius:radiusSize];
    label.backgroundColor = backgroundColor;
    
    return label;
}

+ (instancetype)frame:(CGRect)frame title:(NSString *)title font:(UIFont *)font color:(UIColor *)color line:(NSInteger)line addView:(UIView *)addView{
    UILabel *_ = [[UILabel alloc] initWithFrame:frame];
    _.font = font;
    if (color) {
        _.textColor = color;
    }
    _.text = title;
    _.numberOfLines = line;
    [addView addSubview:_];
    return _;
}

+ (instancetype)labelWithframe:(CGRect)frame title:(NSString *)title font:(UIFont *)font color:(UIColor *)color line:(NSInteger)line{
    UILabel *_ = [[UILabel alloc] initWithFrame:frame];
    _.font = font;
    if (color) {
        _.textColor = color;
    }
    _.text = title;
    _.numberOfLines = line;

    return _;
}
+ (instancetype)z_frame:(CGRect)frame Text:(NSString *)text font:(UIFont*)font color:(UIColor *)color
{
    UILabel *label = [[self alloc] initWithFrame:frame];
    
    label.text = text;
    label.textColor = color;
    label.numberOfLines = 0;
    label.font = font;
    
    return label;
    
}

//- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font color:(UIColor *)color line:(NSInteger)line
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.font = font;
//        if (color) {
//            self.textColor = color;
//        }
//        self.text = title;
//        self.numberOfLines = line;
//    }
//    return self;
//
//}

@end
