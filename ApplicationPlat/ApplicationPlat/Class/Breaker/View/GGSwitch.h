//
//  GGSwitch.h
//  Learning
//
//  Created by 王刚 on 2018/9/21.
//  Copyright © 2018年 王刚. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GGSwitchDelegate<NSObject>
-(void)clickggSwitch:(UISwitch *)swi state:(BOOL)state;
@end
@interface GGSwitch : UIView

@property(nonatomic,strong)UISwitch * ggSwitch;
-(instancetype)initWithFrame:(CGRect)frame bgckgroundColor:(UIColor *)bgckgroundColor thumbTintColor:(UIColor *)thumbTintColor tintColor:(UIColor *)tintColor onTintColor:(UIColor *)onTintColor isOn:(BOOL)isOn sx:(CGFloat)sx sy:(CGFloat)sy x:(CGFloat)x y:(CGFloat)y;
@property(nonatomic,strong)id<GGSwitchDelegate>delegate;
@end
