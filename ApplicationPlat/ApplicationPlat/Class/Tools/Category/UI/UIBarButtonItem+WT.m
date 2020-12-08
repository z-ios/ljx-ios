//  GitHub: https://github.com/Tate-zwt/WTSDK
//  UIBarButtonItem+WT.m
//  WTSDK
//
//  Created by 张威庭 on 15/12/16.
//  Copyright © 2015年 zwt. All rights reserved.
//

#import "UIBarButtonItem+WT.h"
#import "UIView+WT.h"

@implementation UIBarButtonItem (WT)
/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title image:(NSString *)image highImage:(NSString *)highImage {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    if (title) {
        [btn setTitle:title forState:(UIControlStateNormal)];
        if ([title isEqualToString:@"全选"]) {
            [btn setTitleColor:ColorString(@"#20A8D8") forState:(UIControlStateNormal)];
        }else{
            [btn setTitleColor:ColorString(@"#C8CED3") forState:(UIControlStateNormal)];
        }
    }else{
        // 设置图片
        [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
        // 设置尺寸
        btn.size = btn.currentBackgroundImage.size;
    }
   
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)z_itemWithTarget:(id)target action:(SEL)action title:(NSString *)title image:(NSString *)image highImage:(NSString *)highImage {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    if (title) {
        [btn setTitle:title forState:(UIControlStateNormal)];
        [btn setTitleColor:ColorString(@"#20A8D8") forState:(UIControlStateNormal)];
    }else{
        // 设置图片
        [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
        // 设置尺寸
        btn.size = btn.currentBackgroundImage.size;
    }
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
