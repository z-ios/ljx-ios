//
//  LAddressView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/16.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "LAddressView.h"
#import "AddressPickerView.h"

@interface LAddressView ()<AddressPickerViewDelegate>
@property(nonatomic, strong)AddressPickerView *addressView;

// 中间标题
@property (nonatomic, strong) UILabel *titleLabel;
// 分割线视图
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) BTAreaPickViewModel *model;
@end


@implementation LAddressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self borderRoundCornerRadius:8];
        [self addSubview:self.titleLabel];
        [self addSubview:self.lineView];
        [self addSubview:self.addressView];
        [self createUI];
        
    }
    return self;
}
- (void)createUI
{
    
    
    
    CGFloat  buttonHeight = 52 * HeightScale;
    UIView *downLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 0.5 -  buttonHeight , self.width, 0.5)];
    downLine.backgroundColor = [UIColor colorWithWhite:0 alpha:0.17];
    
    [self addSubview:downLine];
    UIButton *_cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(20 * WidthScale, downLine.bottom, (self.width - 40 * WidthScale) /2, buttonHeight)];
    _cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:ColorString(@"#868686") forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelAction ) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelButton];
    UIView *ceLine = [[UIView alloc]initWithFrame:CGRectMake(_cancelButton.right, downLine.bottom, 0.5, 63 * HeightScale)];
    ceLine.backgroundColor = [UIColor colorWithWhite:0 alpha:0.17];
    [self addSubview:ceLine];
    UIButton *_confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ceLine.right, downLine.bottom,(self.width - 40 * WidthScale) /2, buttonHeight)];
    _confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [_confirmButton setTitleColor:DefaColor forState:UIControlStateNormal];
    [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmButton addTarget:self action:@selector(queBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_confirmButton];
    
}
#pragma mark -- 取消
- (void)cancelAction
{
    self.cancleBack();
}
#pragma mark -- 确定
- (void)queBtnAction
{

    self.setAddressBack(_model);
    
    
}
- (void)areaPickerView:(AddressPickerView *)areaPickerView didSelectAreaModel:(BTAreaPickViewModel *)model
{
    _model = model;

}
//- (void)areaPickerView:(AddressPickerView *)areaPickerView doneAreaModel:(BTAreaPickViewModel *)model
//{
//    _model = model;
//}
- (AddressPickerView *)addressView {
    if (!_addressView) {
        _addressView = [[AddressPickerView alloc] initWithFrame:CGRectMake(0, self.lineView.bottom + 10 * HeightScale, KScreenWidth - 30 * WidthScale, (450 - 52 - 50) * HeightScale)];
        _addressView.delegate = self;
        [_addressView scrollToRow:3 secondRand:0 thirdRand:2 forRand:2];
    }
    return _addressView;
}
#pragma mark - 中间标题按钮
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.width - 130 * WidthScale) / 2, 0, 130 * WidthScale, 40* HeightScale)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.text = @"请选择安装地址";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

#pragma mark - 分割线
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 40 * HeightScale, self.width, 0.5)];
        _lineView.backgroundColor  = [UIColor colorWithRed:225 / 255.0 green:225 / 255.0 blue:225 / 255.0 alpha:1] ;
    }
    return _lineView;
}
@end
