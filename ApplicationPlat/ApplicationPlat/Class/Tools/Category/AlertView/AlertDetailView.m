//
//  AlertDetailView.m
//  light
//
//  Created by ljxMac on 2019/11/28.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "AlertDetailView.h"

@interface AlertDetailView ()
@property(nonatomic, strong) UILabel *textLab;
@property(nonatomic, strong) UIButton *queBtn;
@property(nonatomic, strong) UIButton *cancleBtn;
@end

@implementation AlertDetailView
- (instancetype)initWithFrame:(CGRect)frame type:(NSString *)type
{
    self  = [super initWithFrame:frame];
    if (self) {
        if ([type isEqualToString:@"cancle"]) {
            [self createUI1];
        }else{
            [self createUI];
        }
        
        
    }
    return self;
}
- (void)createUI
{
//    UILabel  *titleLab = [[UILabel alloc]init];
//    titleLab.textColor = ColorString(@"#22272B");
//    titleLab.font = [UIFont boldSystemFontOfSize:19];
//    titleLab.text = @"提示";
//    titleLab.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:titleLab];
//    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(20 * WidthScale);
//        make.top.mas_equalTo(30 * HeightScale);
//        make.right.mas_equalTo(-20 * WidthScale);
//        make.height.mas_equalTo(30 * HeightScale);
//    }];
    
    
    UILabel *textLab  = [[UILabel alloc]init];
    textLab.textColor = ColorString(@"#121212");
    textLab.numberOfLines = 0;
    textLab.textAlignment = NSTextAlignmentCenter;
    textLab.font = [UIFont systemFontOfSize:17];
    [self addSubview:textLab];
    self.textLab = textLab;
    [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30 * WidthScale);
        make.right.mas_equalTo(-30 * WidthScale);
        make.top.mas_equalTo(56 * HeightScale);
        make.height.mas_equalTo( 50 * HeightScale);
        
    }];
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 63 * HeightScale -1, self.width, 0.5)];
    lineView1.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.17];
    [self addSubview:lineView1];
    
//    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(0);
//        make.right.mas_equalTo(0);
//        make.bottom.mas_equalTo(self.mas_height).offset(-63 * HeightScale-1);
//        make.height.mas_equalTo( 0.5);
//
//    }];
    
    UIButton *queBtn = [[UIButton alloc]initWithFrame:CGRectMake(20 * WidthScale, self.height - 63 * HeightScale,self.width - 40 * WidthScale, 63 * HeightScale)];
    self.queBtn = queBtn;
    
    [queBtn setTitleColor:ColorString(@"#184E9C") forState:UIControlStateNormal];
    [queBtn addTarget:self action:@selector(queBtnAction ) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:queBtn];
    
}
- (void)createUI1
{
    
    
    
    UILabel  *titleLab = [[UILabel alloc]init];
    titleLab.textColor = ColorString(@"#22272B");
    titleLab.font = [UIFont boldSystemFontOfSize:19];
    titleLab.text = @"提示";
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20 * WidthScale);
        make.top.mas_equalTo(30 * HeightScale);
        make.right.mas_equalTo(-20 * WidthScale);
        make.height.mas_equalTo(30 * HeightScale);
    }];
    
    
    UILabel *textLab  = [[UILabel alloc]init];
    textLab.textColor = ColorString(@"#22272B");
    self.textLab = textLab;
    textLab.numberOfLines = 0;
    textLab.textAlignment = NSTextAlignmentCenter;
    textLab.font = [UIFont systemFontOfSize:15];
    [self addSubview:textLab];
    [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30 * WidthScale);
        make.right.mas_equalTo(-30 * WidthScale);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(10 * HeightScale);
        make.height.mas_equalTo( 50 * HeightScale);
        
    }];
    
    
    UIView *downLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 64* HeightScale, self.width, 1)];
    downLine.backgroundColor = ColorString(@"#E7E7E7");
    [self addSubview:downLine];
    UIButton *cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(20 * WidthScale, self.height - 63* HeightScale, (self.width - 40 * WidthScale) /2, 63 * HeightScale)];
    cancleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
//    [cancleBtn setTitle:cancleBtnTitle forState:UIControlStateNormal];
    [cancleBtn setTitleColor:ColorString(@"#6F7D8E") forState:UIControlStateNormal];
    _cancleBtn = cancleBtn;
    [cancleBtn addTarget:self action:@selector(cancelAction ) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleBtn];
    UIView *ceLine = [[UIView alloc]initWithFrame:CGRectMake(cancleBtn.right, downLine.bottom, 1, 63 * HeightScale)];
    ceLine.backgroundColor = ColorString(@"#E7E7E7");
    [self addSubview:ceLine];
    UIButton *queBtn = [[UIButton alloc]initWithFrame:CGRectMake(ceLine.right, self.height - 63* HeightScale,(self.width - 40 * WidthScale) /2, 63 * HeightScale)];
    queBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
//    [queBtn setTitle:btnTitle forState:UIControlStateNormal];
    self.queBtn = queBtn;
    [queBtn setTitleColor:ColorString(@"#3374FA") forState:UIControlStateNormal];
    [queBtn addTarget:self action:@selector(comBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:queBtn];
}

- (void)setBtnStr:(NSString *)btnStr
{
    _btnStr = btnStr;
    [_queBtn setTitle:btnStr forState:UIControlStateNormal];
}
- (void)setTextStr:(NSString *)textStr
{
    _textStr = textStr;
    _textLab.text = textStr;
}
- (void)setCancleBtnTitle:(NSString *)cancleBtnTitle
{
    _cancleBtnTitle = cancleBtnTitle;
    [_cancleBtn setTitle:cancleBtnTitle forState:UIControlStateNormal];
}
- (void)queBtnAction
{
    self.determineBlock();
}
- (void)cancelAction
{
    self.determineBlock();
}
- (void)comBtnAction
{
    self.comBtnActionBlock();
}
@end
