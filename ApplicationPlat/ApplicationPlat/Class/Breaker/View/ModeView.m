//
//  ModeView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/13.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "ModeView.h"

@interface ModeView ()
@property(nonatomic, copy) NSString *aOrMStr;
@end

@implementation ModeView

- (instancetype)initWithFrame:(CGRect)frame aOrMStr:(NSString *)aOrMStr
{
    self = [super initWithFrame:frame];
    if (self) {
        _aOrMStr = aOrMStr;
        self.backgroundColor = ColorString(@"#F6F8FA");
        [self border:[UIColor colorWithHex:@"#000000" alpha:0.18] width:0.5 CornerRadius:4];
        [self creatUI];
    }
    return self;
}
- (void)creatUI
{
    self.imageV1 = [[UIButton alloc]initWithFrame:CGRectMake(self.width-18 * WidthScale, 0, 18 * WidthScale, 18 * WidthScale)];
    _imageV1.userInteractionEnabled = NO;
    [_imageV1 setImage:[UIImage imageNamed:@"icon_option_select"] forState:UIControlStateNormal];
    _imageV1.hidden = YES;
    [self addSubview:_imageV1];
    self.imageV = [[UIButton alloc]initWithFrame:CGRectMake(self.width / 2 - (44 * WidthScale) / 2, 25 * HeightScale, 44 * WidthScale, 44 * WidthScale)];
    _imageV.userInteractionEnabled = NO;
    if ([_aOrMStr isEqualToString:@"auto"]) {
        [_imageV setImage:[UIImage imageNamed:@"icon_A"] forState:UIControlStateNormal];
        [_imageV setImage:[UIImage imageNamed:@"icon_A_d"] forState:UIControlStateSelected];

    }else{
        [_imageV setImage:[UIImage imageNamed:@"icon_M"] forState:UIControlStateNormal];
        [_imageV setImage:[UIImage imageNamed:@"icon_M_d"] forState:UIControlStateSelected];
    }
    
    
    [self addSubview:_imageV];
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10 * WidthScale, _imageV.bottom + 10 * WidthScale, self.width -10 * WidthScale, 30 * HeightScale)];
    _titleLab.textColor = ColorString(@"#121212");
    _titleLab.font = PingFangSCRegular(16);
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.userInteractionEnabled = NO;
    [self addSubview:_titleLab];
    
    
}
//- (void)setIsSelect:(BOOL)isSelect
//{
//
//    _isSelect = isSelect;
//    if ([_aOrMStr isEqualToString:@"auto"]) {
//        [_imageV setImage:[UIImage imageNamed:@"icon_A_d"] forState:UIControlStateNormal];
//
//    }else{
//        [_imageV setImage:[UIImage imageNamed:@"icon_M"] forState:UIControlStateNormal];
//
//    }
//
//}
 
@end
