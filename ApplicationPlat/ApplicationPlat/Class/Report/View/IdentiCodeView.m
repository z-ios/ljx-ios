//
//  IdentiCodeView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/3.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "IdentiCodeView.h"

@interface IdentiCodeView ()<UITextFieldDelegate>

@end

@implementation IdentiCodeView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = KScreenWidth;
        
        // 创建BezierPath 并设置角 和 半径

        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight|UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(36, 36)];

        CAShapeLayer *layer = [[CAShapeLayer alloc] init];

        layer.frame = self.bounds;

        layer.path = path.CGPath;

        self.layer.mask = layer;
        
//        [self borderRoundCornerRadius:36];
        [self createUI];
        
        
    }
    return self;
}

- (void)createUI
{
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(25 * WidthScale, 30 * HeightScale, 80, 33 * HeightScale)];
    titleLab.text = @"标识码";
    titleLab.textColor = ColorString(@"#121212");
    titleLab.font = PingFangSCMedium(20);
    [self addSubview:titleLab];
    
    UILabel *subtitleLab = [[UILabel alloc]initWithFrame:CGRectMake(25 * WidthScale,titleLab.bottom + 15 * HeightScale, 80, 20 * HeightScale)];
    subtitleLab.text = @"标识码";
    subtitleLab.textColor = ColorString(@"#808080");
    subtitleLab.font = PingFangSCRegular(14);
    [self addSubview:subtitleLab];
    
    
    self.customText = [[CustomTextField alloc]initWithFrame:CGRectMake(25 * WidthScale,subtitleLab.bottom + 3 * HeightScale, self.width - 50 * WidthScale, 48 * HeightScale) isLine:YES];
    _customText.textField.font = PingFangSCRegular(16);
    _customText.textField.delegate = self;
    _customText.textField.textColor = ColorString(@"#121212");
    [_customText.functionBtn setImage:[UIImage imageNamed:@"icon_code"] forState:UIControlStateNormal];
    [_customText.functionBtn addTarget:self action:@selector(scanAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_customText];
//    _customText.textField.text = @"6045239085";
    
    UIView *cardView = [[UIView alloc]initWithFrame:CGRectMake(25 * WidthScale, _customText.bottom + 40 * HeightScale, self.width - 50 * WidthScale, 170 * HeightScale)];
    [cardView border:[UIColor colorWithWhite:0 alpha:0.19] width:1 CornerRadius:8];
    [self addSubview:cardView];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(20 * WidthScale, 25 * HeightScale, 80 * WidthScale, cardView.height - 50 * HeightScale)];
    [imageV setImage:[UIImage imageNamed:@"pic_idcode"]];
    [cardView addSubview:imageV];
    
    UIButton *tishiBtn = [[UIButton alloc]initWithFrame:CGRectMake(imageV.right + 18 * WidthScale,  25 * HeightScale, 24 * WidthScale, 24 * WidthScale)];
    [tishiBtn setImage:[UIImage imageNamed:@"icon_instancename"] forState:UIControlStateNormal];
    [cardView addSubview:tishiBtn];
    
    UILabel *tishiLab = [[UILabel alloc]initWithFrame:CGRectMake(tishiBtn.right + 2 * WidthScale,25 * HeightScale, 120, 24 * WidthScale)];
    tishiLab.text = @"设备标识码";
    tishiLab.textColor = ColorString(@"#121212");
    tishiLab.font = PingFangSCRegular(18);
    [cardView addSubview:tishiLab];
    
    
    UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(imageV.right + 18 * WidthScale,tishiLab.bottom + 10 * HeightScale, cardView.width - imageV.right - 40 * WidthScale, 72 * WidthScale)];
    detailLab.text = @"设备标识码用于与IoTHub进行通讯时的唯一凭证，常见为MAC地址、IMEI号等";
    detailLab.textColor = ColorString(@"#8F9FB3");
    detailLab.font = PingFangSCRegular(14);
    detailLab.numberOfLines = 0;
    [cardView addSubview:detailLab];
    
    self.nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(16 * WidthScale, self.height - (44 + 52) * HeightScale , self.width - 16 * WidthScale * 2, 52 * HeightScale)];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    if (IS_IPHONE_8 || IS_IPHONE_8P) {
        _nextBtn.y = self.height - (30 + 52) * HeightScale;
    }
    _nextBtn.userInteractionEnabled = NO;
    _nextBtn.backgroundColor = ColorString(@"#D7DBDE");;
    _nextBtn.titleLabel.font = PingFangSCMedium(17);
    [_nextBtn borderRoundCornerRadius:6];
    [_nextBtn addTarget:self action:@selector(nextBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nextBtn];
    
    
    
    
}
- (void)nextBtnAction
{
    [_customText.textField resignFirstResponder];
    if (![_customText.textField.text isEqualToString:@""]) {
        if ([self.delagte respondsToSelector:@selector(nextPageWithMacCode:)]) {
            NSString *strUrl = [_customText.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            [self.delagte nextPageWithMacCode:strUrl];
        }
    }
}
- (void)scanAction
{
    [_customText.textField resignFirstResponder];
    if ([self.delagte respondsToSelector:@selector(scanCodeVc)]) {
        [self.delagte scanCodeVc];
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (![_customText.textField.text isEqualToString:@""]) {
        _nextBtn.backgroundColor = DefaColor;
        _nextBtn.userInteractionEnabled = YES;
    }else{
        _nextBtn.backgroundColor = ColorString(@"#D7DBDE");
        _nextBtn.userInteractionEnabled = NO;
    }
}
@end
