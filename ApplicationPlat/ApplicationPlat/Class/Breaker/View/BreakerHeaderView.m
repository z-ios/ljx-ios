//
//  BreakerHeaderView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/12.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "BreakerHeaderView.h"
#import "CXScoreSlider.h"
#import "BranchbreakViewModel.h"
#import "CustomSlider.h"
@interface BreakerHeaderView ()
@property(nonatomic, strong)UILabel *waftLab;
@property(nonatomic, strong)UILabel *cycleLab;
@property(nonatomic, strong)UIButton *imageV;
@property(nonatomic, strong)CXScoreSlider *progressView;
@property(nonatomic, strong)UIButton *defineBtn;
@property(nonatomic, strong)UIButton *cancleBtn;
@property(nonatomic, strong)CustomSlider *sliderView;
@property(nonatomic, strong)UIImageView *thumbImageV;
@property(nonatomic, assign) NSInteger isFlage;
@property(nonatomic, strong) NSString *scoreStr;
@property(nonatomic, strong) NSString *sliderStr;

@property (nonatomic, strong) BranchbreakViewModel *branchViewModel;

@end


@implementation BreakerHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 12;
        self.layer.shadowColor = [UIColor colorWithRed:37/255.0 green:51/255.0 blue:75/255.0 alpha:0.19].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,0);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 6;
        self.width = KScreenWidth - 40 * WidthScale;
        
        [self createView];
        
        
    }
    return self;
}
- (void)createView
{
    //    CGFloat rightW = (self.width - 20 * WidthScale - 1) / 3;
    
    UILabel *_titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20 * WidthScale, 15 * HeightScale, 80, 25 * HeightScale)];
    _titleLab.textColor = ColorString(@"#97A5AF");
    _titleLab.font = PingFangSCRegular(17);
    _titleLab.text = @"网关信息";
    [self addSubview:_titleLab];
    
    UIButton *tishiBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 44 * WidthScale, 0, 24 * WidthScale, 24 * WidthScale)];
    tishiBtn.userInteractionEnabled = NO;
    [tishiBtn setImage:[UIImage imageNamed:@"icon_information"] forState:UIControlStateNormal];
    tishiBtn.centerY = _titleLab.centerY;
    [self addSubview:tishiBtn];
    
    self.defineBtn = [[UIButton alloc]initWithFrame:CGRectMake(tishiBtn.x - 50 * WidthScale, 12.5 * HeightScale, 34 * WidthScale, 30 * HeightScale)];
    [_defineBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_defineBtn setTitleColor:ColorString(@"#26C464") forState:UIControlStateNormal];
    _defineBtn.titleLabel.font = PingFangSCRegular(16);
    [_defineBtn addTarget:self action:@selector(defineBtnAction ) forControlEvents:UIControlEventTouchUpInside];
    _defineBtn.hidden = YES;
    [self addSubview:_defineBtn];
    
    self.cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(_defineBtn.x - 50 * WidthScale, 12.5 * HeightScale, 34 * WidthScale, 30 * HeightScale)];
    [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancleBtn setTitleColor:ColorString(@"#ADB6B1") forState:UIControlStateNormal];
    _cancleBtn.titleLabel.font = PingFangSCRegular(16);
    [_cancleBtn addTarget:self action:@selector(cancleAction ) forControlEvents:UIControlEventTouchUpInside];
    _cancleBtn.hidden = YES;
    [self addSubview:_cancleBtn];
    
    
    
    UILabel *waftTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(20 * WidthScale,_titleLab.bottom + 15 * HeightScale, 50, 25 * HeightScale)];
    waftTitleLab.textColor = ColorString(@"#121212");
    waftTitleLab.font = PingFangSCRegular(16);
    waftTitleLab.text = @"信号";
    [self addSubview:waftTitleLab];
    
    self.waftLab = [[UILabel alloc]initWithFrame:CGRectMake(waftTitleLab.right + 5 * WidthScale, _titleLab.bottom + 15 * HeightScale,50 * WidthScale , 25 * HeightScale)];
    _waftLab.textColor = ColorString(@"#0091FF");
    _waftLab.font = PingFangSCRegular(13);
    _waftLab.adjustsFontSizeToFitWidth = YES;
    _waftLab.textAlignment = NSTextAlignmentRight;
    [self addSubview:_waftLab];
    
    self.imageV = [[UIButton alloc]initWithFrame:CGRectMake(_waftLab.right / 2 - 44 * WidthScale / 2, waftTitleLab.bottom + 10 * HeightScale, 44 * WidthScale, 44 * WidthScale)];
    _imageV.userInteractionEnabled = NO;
    [self addSubview:_imageV];
    
    CAShapeLayer *layer =   [UIView drawRect:CGRectMake(_waftLab.right + 10 * WidthScale, waftTitleLab.y, 0.5, self.height - waftTitleLab.y - 24 * HeightScale) radius:0 color:[UIColor colorWithHex:@"#000000" alpha:0.19]];
    [self.layer addSublayer:layer];
    
    UILabel *cycleTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(_waftLab.right + 10 * WidthScale + 1 + 10 * WidthScale,_titleLab.bottom + 15 * HeightScale, 80, 25 * HeightScale)];
    cycleTitleLab.textColor = ColorString(@"#121212");
    cycleTitleLab.font = PingFangSCRegular(16);
    cycleTitleLab.text = @"上报周期";
    [self addSubview:cycleTitleLab];
    
    self.cycleLab = [[UILabel alloc]initWithFrame:CGRectMake(cycleTitleLab.right + 20 * WidthScale + 1, _titleLab.bottom +  15 * HeightScale, self.width - cycleTitleLab.right - 50 * WidthScale - 1 , 25 * HeightScale)];
    _cycleLab.textColor = ColorString(@"#0091FF");
    _cycleLab.font = PingFangSCRegular(14);
//    _cycleLab.text = @"1h";
    _cycleLab.textAlignment = NSTextAlignmentRight;
    [self addSubview:_cycleLab];

    
    self.sliderView = [[CustomSlider alloc]initWithFrame:CGRectMake(cycleTitleLab.x, 0, self.width - cycleTitleLab.x - 20 * WidthScale - 1, 20)];
    _sliderView.centerY = _imageV.centerY;
    _sliderView.tintColor = ColorString(@"#0091FF");
    _sliderView.thumbTintColor = ColorString(@"#DEE8F0");
    [_sliderView setThumbImage:[UIImage imageNamed:@"icon_slider_cycle"] forState:UIControlStateNormal];
    [_sliderView setThumbImage:[UIImage imageNamed:@"icon_slider_cycle"] forState:UIControlStateSelected];

    _sliderView.maximumValue = 6;
    _sliderView.minimumValue = 0;
    [_sliderView addTarget:self action:@selector(sliderViewAction ) forControlEvents:UIControlEventTouchUpInside ];
    [_sliderView addTarget:self action:@selector(sliderViewValueAction ) forControlEvents:UIControlEventValueChanged];

    [self addSubview:_sliderView];
    
}
- (void)sliderViewValueAction
{
    NSString *time = @"";
    if (_sliderView.value < 1) {
        time = [NSString stringWithFormat:@"1m"];
    }else{
        time = [NSString stringWithFormat:@"%ldm", (long)_sliderView.value * 10];
    }
    _cycleLab.text = time;

}

- (void)sliderViewAction
{
    NSString *time = @"";
    NSLog(@"fffff ==== %f", _sliderView.value);
    if (_sliderView.value < 1) {
        time = [NSString stringWithFormat:@"1m"];
        _sliderStr = [NSString stringWithFormat:@"%ld", (long)_sliderView.value + 1];

    }else{
        time = [NSString stringWithFormat:@"%ldm", (long)_sliderView.value* 10];
        _sliderStr = [NSString stringWithFormat:@"%ld", (long)_sliderView.value * 10];

    }


    CZHWeakSelf(self)

    NSString *str = [NSString stringWithFormat:@"确定将上报周期改为%@吗？",time ];
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setCancelBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        [weakself cancleAction];
    }];
    UIAlertAction *comAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setDefineBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        [weakself defineBtnAction];

    }];
    [alertVc addAction:cancleAc];
    [alertVc addAction:comAc];
    [self.superview.viewController presentViewController:alertVc animated:YES completion:nil];
         
}
- (void)setOnLine:(NSString *)onLine
{
    if ([onLine intValue] != 1) {
        [_imageV setImage:[UIImage imageNamed:@"icon_signal_offline"] forState:UIControlStateNormal];
        _waftLab.text = [NSString stringWithFormat:@"离线"];
        _waftLab.textColor = ColorString(@"#7E8991");
    }else{
        
        if ([_signal.parsed_data isEqualToString:@""]||[_signal.parsed_data isEqualToString:@"0"] ) {
            [_imageV setImage:[UIImage imageNamed:@"icon_signal_offline"] forState:UIControlStateNormal];
            _waftLab.text = [NSString stringWithFormat:@"离线"];
            _waftLab.textColor = ColorString(@"#7E8991");
        }else{
            
            [_imageV setImage:[UIImage imageNamed:[self setSignalImage:_signal.parsed_data]] forState:UIControlStateNormal];
        }
    }
}
- (void)setSignal:(PropertyModel *)signal
{
    _signal = signal;
}

- (NSString *)setSignalImage:(NSString *)signal
{
    NSString *signalStr = [NSString stringWithFormat:@"%d",abs([signal intValue]) ];
    _waftLab.text = [NSString stringWithFormat:@"%@%@", signal,_signal.unit];
    _waftLab.textColor = ColorString(@"#0091FF");
    
    if ([signalStr intValue] >= 31) {
        return @"icon_signal_4";
    }else if ([signalStr intValue] < 31 && [signalStr intValue] >= 18){
        return @"icon_signal_3";
        
    }else if ([signalStr intValue]  < 18 && [signalStr intValue] >= 11){
        return @"icon_signal_2";
        
    }else if ([signalStr intValue] < 11 && [signalStr intValue] > 1){
        return @"icon_signal_1";
        
    }else if ([signalStr intValue] == 1){
        return @"icon_signal_0";
        
    }else if ( [signalStr intValue] <= 0){
        _waftLab.text = [NSString stringWithFormat:@"离线"];
        _waftLab.textColor = ColorString(@"#7E8991");
        return @"icon_signal_offline";
    }
    return @"";
    
}

- (void)setCycleStr:(NSString *)cycleStr
{
    _cycleStr = cycleStr;
    NSString *mmStr = @"";
    if ([cycleStr intValue] <=1) {
        mmStr = @"1";
        _sliderView.value = 0;
        _scoreStr = [NSString stringWithFormat:@"%d",1];

    }else{
        mmStr = cycleStr ;
        _sliderView.value = [cycleStr intValue] / 10;
        _scoreStr = [NSString stringWithFormat:@"%d",[cycleStr intValue] / 10];

    }
    
    _cycleLab.text = [NSString stringWithFormat:@"%@m", mmStr];
}
#pragma mark -- 修改周期
- (void)defineBtnAction
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"operator"] = @{@"id":Center.shared.userID};
    NSDictionary *dic = @{@"id":_iId?_iId:@""};
    params[@"device"] = dic;
    params[@"payload"] = @{@"period":[NSString stringWithFormat:@"%@",_sliderStr]};
    CZHWeakSelf(self)
    
    [self.branchViewModel setPeriodWithParams:params Completion:^(BOOL success, NSString * _Nonnull errorMsg) {
        
        if (success) {
            weakself.scoreStr =  [NSString stringWithFormat:@"%@",weakself.sliderStr];
            
//            [UIView animateWithDuration:0.4 animations:^{
//
//                if (!weakself.defineBtn.hidden) {
//                    weakself.defineBtn.alpha = 0;
//                }
//                if (!weakself.cancleBtn.hidden) {
//                    weakself.cancleBtn.alpha = 0;
//                }
//
//            } completion:^(BOOL finished) {
//                weakself.defineBtn.hidden = YES;
//                weakself.cancleBtn.hidden = YES;
//            }];
        }else{
            [CustomAlert alertVcWithMessage:errorMsg Vc:weakself.superview.viewController];
        }
    }];
    
    
    
   

}
- (void)cancleAction
{
    NSString *mmStr = @"";
    if ([_scoreStr intValue] <=1) {
        mmStr = @"1";
        _sliderView.value = 0;

    }else{
        mmStr = _scoreStr ;
        _sliderView.value = [_scoreStr intValue] / 10;
    }
    _cycleLab.text = [NSString stringWithFormat:@"%@m", mmStr];
    
//    CZHWeakSelf(self)
//    [UIView animateWithDuration:0.4 animations:^{
//
//        if (!weakself.defineBtn.hidden) {
//            weakself.defineBtn.alpha = 0;
//        }
//        if (!weakself.cancleBtn.hidden) {
//            weakself.cancleBtn.alpha = 0;
//        }
//
//    } completion:^(BOOL finished) {
//        weakself.defineBtn.hidden = YES;
//        weakself.cancleBtn.hidden = YES;
//    }];

}
- (BranchbreakViewModel *)branchViewModel
{
    if (_branchViewModel == nil) {
        _branchViewModel = [[BranchbreakViewModel alloc]init];
    }
    return _branchViewModel;
}
@end
