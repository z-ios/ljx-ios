//
//  CustomLabView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/3.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "CustomLabView.h"

@implementation CustomLabView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    self.imageBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0, 24 * WidthScale, 24 * WidthScale)];
    _imageBtn.userInteractionEnabled = NO;
    [self addSubview:_imageBtn];
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(_imageBtn.right +15 * WidthScale,0, self.width - _imageBtn.right - 15 * WidthScale, 24 * HeightScale)];
    _titleLab.textColor = ColorString(@"#808080");
    _titleLab.font = PingFangSCRegular(14);
    [self addSubview:_titleLab];
    
    self.detailLab = [[UILabel alloc]initWithFrame:CGRectMake(_imageBtn.right +15 * WidthScale,_titleLab.bottom +12 * HeightScale, self.width - _imageBtn.right - 15 * WidthScale, 33 * HeightScale)];
    _detailLab.textColor = ColorString(@"#121212");
    _detailLab.font = PingFangSCRegular(16);
    [self addSubview:_detailLab];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(_imageBtn.right +15 * WidthScale, _detailLab.bottom +12 * HeightScale, self.width - _imageBtn.right - 15 * WidthScale, 1)];
    lineView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.19];
    [self addSubview:lineView];
    
   
}
@end
