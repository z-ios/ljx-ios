//
//  CustomTextField.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/3.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "CustomTextField.h"

@interface CustomTextField ()

@property(nonatomic, assign) BOOL isLine;
@end

@implementation CustomTextField

- (instancetype)initWithFrame:(CGRect)frame isLine:(BOOL)isLine
{
    self = [super initWithFrame:frame];
    if (self) {
        _isLine = isLine;
        [self border:[UIColor colorWithWhite:0 alpha:0.19] width:1 CornerRadius:4];
        [self createUI];
        self.backgroundColor = ColorString(@"#F6F8FA");
    }
    return self;
}
-  (void)createUI
{
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, self.width - 20 - 47 * WidthScale - 0.5, self.height)];
    [self addSubview:_textField];
    if (_isLine) {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(_textField.right, 0.5, 0.5, self.height - 1)];
        lineView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.19];
        [self addSubview:lineView];
    }
    self.functionBtn = [[UIButton alloc]initWithFrame:CGRectMake(_textField.right + 0.5 + 15 * WidthScale, self.height / 2 - 24 * WidthScale / 2, 24 * WidthScale, 24 * WidthScale)];
    
    [self addSubview:_functionBtn];
    
}

@end
