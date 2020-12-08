//
//  GGSwitch.m
//  Learning
//
//  Created by 王刚 on 2018/9/21.
//  Copyright © 2018年 王刚. All rights reserved.
//

#import "GGSwitch.h"

@implementation GGSwitch
-(instancetype)initWithFrame:(CGRect)frame bgckgroundColor:(UIColor *)bgckgroundColor thumbTintColor:(UIColor *)thumbTintColor tintColor:(UIColor *)tintColor onTintColor:(UIColor *)onTintColor isOn:(BOOL)isOn sx:(CGFloat)sx sy:(CGFloat)sy x:(CGFloat)x y:(CGFloat)y{
    self=[super initWithFrame:frame];
    if (self) {
        [self addSubview:self.ggSwitch];
        self.ggSwitch.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.ggSwitch.transform=CGAffineTransformMakeScale(sx,sy);
        self.ggSwitch.layer.anchorPoint=CGPointMake(x,y);
        self.ggSwitch.backgroundColor=bgckgroundColor;
        //改动开关按钮的 颜色
        self.ggSwitch.thumbTintColor=thumbTintColor;
        //改开关 边框的颜色
        self.ggSwitch.tintColor=tintColor;
        //改变开了 的颜色
        self.ggSwitch.onTintColor=onTintColor;
        self.ggSwitch.on=isOn;
    }
    return self;
}

#pragma mark - action
-(void)swChanged:(UISwitch *)swi
{
    //和button有所不同  自己去检测 是否开启的状态的
//    BOOL isOn = swi.on;
//    NSLog(@"开关了 %d",isOn);
    [self.delegate clickggSwitch:swi state:swi.on];
}
-(UISwitch *)ggSwitch{
    if (!_ggSwitch) {
        _ggSwitch=[[UISwitch alloc]init];
        [_ggSwitch addTarget:self action:@selector(swChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _ggSwitch;
}
@end
