//
//  ModeAlertView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/13.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "ModeAlertView.h"
#import "ModeView.h"

@interface ModeAlertView ()
@property(nonatomic, strong)ModeView *autoView;

@property(nonatomic, strong)ModeView *matueView;
@property(nonatomic, copy)NSString *isAuto;

@end


@implementation ModeAlertView





- (instancetype)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self borderRoundCornerRadius:18];
        [self createUI1];
        
        
        
    }
    return self;
}
- (void)createUI1
{
    
    
    
    UILabel  *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(25 * WidthScale, 25 * HeightScale, 150, 35 * HeightScale)];
    titleLab.textColor = ColorString(@"#121212");
    titleLab.font = PingFangSCRegular(19);
    titleLab.text = @"工作模式";
    [self addSubview:titleLab];
   
    
    
    UILabel *textLab  = [[UILabel alloc]initWithFrame:CGRectMake(25 * WidthScale,  titleLab.bottom+5 * HeightScale, 170, 25 * HeightScale)];
    textLab.textColor = ColorString(@"#8F9FB3");
    textLab.text = @"请选择设备工作模式";
    textLab.font = PingFangSCRegular(14);
    [self addSubview:textLab];

    
    
    self.matueView = [[ModeView alloc]initWithFrame:CGRectMake(25 * WidthScale, textLab.bottom + 25 * HeightScale, (self.width - 65 * WidthScale) / 2, 123 * HeightScale) aOrMStr:@"mato"];
    _matueView.imageV.selected = YES;
    _matueView.imageV1.hidden = NO;
    _matueView.titleLab.text = @"手动";
    _matueView.titleLab.textColor = ColorString(@"#0091FF");
    _matueView.layer.borderColor = DefaColor.CGColor;
    [_matueView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(matueViewAction)]];
    [self addSubview:_matueView];
    
    self.autoView = [[ModeView alloc]initWithFrame:CGRectMake(_matueView.right+15 * WidthScale, textLab.bottom + 25 * HeightScale, (self.width - 65 * WidthScale) / 2, 123 * HeightScale) aOrMStr:@"auto"];
    _autoView.imageV.selected = NO;
    _autoView.imageV1.hidden = YES;
    _autoView.titleLab.text = @"自动";
    _autoView.titleLab.textColor = ColorString(@"#121212");
    _autoView.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.18].CGColor;
    [_autoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(autoViewAction)]];

    [self addSubview:_autoView];
    
    
    
    UIView *downLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 61* HeightScale, self.width, 1)];
    downLine.backgroundColor = ColorString(@"#E7E7E7");
    [self addSubview:downLine];
    UIButton *cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(20 * WidthScale, self.height - 60* HeightScale, (self.width - 40 * WidthScale) /2, 60 * HeightScale)];
    cancleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:ColorString(@"#808080") forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancelAction ) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleBtn];
    UIView *ceLine = [[UIView alloc]initWithFrame:CGRectMake(cancleBtn.right, downLine.bottom, 1, 60 * HeightScale)];
    ceLine.backgroundColor = ColorString(@"#E7E7E7");
    [self addSubview:ceLine];
    UIButton *queBtn = [[UIButton alloc]initWithFrame:CGRectMake(ceLine.right, self.height - 60* HeightScale,(self.width - 40 * WidthScale) /2, 60 * HeightScale)];
    queBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [queBtn setTitle:@"确定" forState:UIControlStateNormal];
    [queBtn setTitleColor:DefaColor forState:UIControlStateNormal];
    [queBtn addTarget:self action:@selector(comBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:queBtn];
}
- (void)matueViewAction
{
    _isAuto = @"matue";
    _matueView.imageV.selected = YES;
    _matueView.imageV1.hidden = NO;
    _matueView.titleLab.textColor = ColorString(@"#0091FF");
    _matueView.layer.borderColor = DefaColor.CGColor;
    _autoView.imageV.selected = NO;
    _autoView.imageV1.hidden = YES;
    _autoView.titleLab.textColor = ColorString(@"#121212");
    _autoView.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.18].CGColor;
}
- (void)autoViewAction
{
    _isAuto = @"auto";

    _autoView.imageV.selected = YES;
    _autoView.imageV1.hidden = NO;
    _autoView.titleLab.textColor = ColorString(@"#0091FF");
    _autoView.layer.borderColor = DefaColor.CGColor;
    _matueView.imageV.selected = NO;
    _matueView.imageV1.hidden = YES;
    _matueView.titleLab.textColor = ColorString(@"#121212");
    _matueView.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.18].CGColor;
}
- (void)setModeStr:(NSString *)modeStr
{
    _modeStr = modeStr;
    _isAuto = modeStr;
    if ([modeStr  isEqualToString:@"auto"]) {
        [self autoViewAction];
    }else{
        [self matueViewAction];

    }
}

- (void)cancelAction
{
    self.determineBlock();
}
- (void)comBtnAction
{
    self.comBtnActionBlock(_isAuto);
}
@end
