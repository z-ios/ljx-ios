//
//  RegisterAlertView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/6.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "RegisterAlertView.h"

@interface RegisterAlertView ()
@property(nonatomic, strong)UIImageView *imageV;
@property(nonatomic, strong)UILabel *titleLab;
@property(nonatomic, strong)UILabel *detailLab;
@property(nonatomic, strong)UIButton *nextBtn;
@property(nonatomic, strong)UIButton *finishBtn;
@property(nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, assign) NSInteger seconds;
@property (nonatomic, strong) NSTimer* countDownTimer;

@end

@implementation RegisterAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
        self.width = KScreenWidth;
    }
    return self;
}
- (void)createUI
{
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake( 65 * WidthScale,self.height / 2 - 211 * HeightScale / 2 - 150 * HeightScale, self.width - 130 * WidthScale, 211 * HeightScale)];
    [self addSubview:_imageV];
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(self.width/ 2 - 250 / 2, _imageV.bottom + 30 * HeightScale, 250, 33 * HeightScale)];
    _titleLab.textColor = ColorString(@"#121212");
    _titleLab.font = PingFangSCMedium(20);
    _titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLab];
    
    self.detailLab = [[UILabel alloc]initWithFrame:CGRectMake(self.width/ 2 - 250 / 2,_titleLab.bottom + 5 * HeightScale, 250, 33 * HeightScale)];
    _detailLab.textColor = ColorString(@"#8696A2");
    _detailLab.font = PingFangSCRegular(14);
    _detailLab.numberOfLines = 0;
    _detailLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_detailLab];
//    UILabel * timeLabel = [UILabel z_labelWithText:@"5s后自动返回" fontSize:14 color:ColorString(@"#8C8C8C")];
//    timeLabel.height = 33 * HeightScale;
//    timeLabel.width = 100;
//    timeLabel.y = _titleLab.bottom + 5 * HeightScale;
//    timeLabel.centerX = self.width * 0.5;
//    timeLabel.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:timeLabel];
//    _timeLabel.hidden = YES;
//    _timeLabel = timeLabel;
    
    self.nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _detailLab.bottom + 5 * HeightScale , 0, 42 * HeightScale)];
    //    [_nextBtn setTitle:@"立即查看设备状态" forState:UIControlStateNormal];
    //    _nextBtn.backgroundColor = DefaColor;
    _nextBtn.userInteractionEnabled = YES;
    _nextBtn.titleLabel.font = PingFangSCMedium(17);
    [_nextBtn borderRoundCornerRadius:6];
    [_nextBtn addTarget:self action:@selector(nextBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nextBtn];
    
    self.finishBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width  / 2 - 100 * WidthScale / 2, _nextBtn.bottom + 10 * HeightScale , 100 * WidthScale, 40 * HeightScale)];
    _finishBtn.userInteractionEnabled = YES;
    [_finishBtn setTitle:@"安装完成" forState:UIControlStateNormal];
//    [_finishBtn setTitleColor:[UIColor colorWithWhite:0 alpha:0.28] forState:UIControlStateNormal];
    _finishBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.28];
    _finishBtn.titleLabel.font = PingFangSCMedium(15);
    [_finishBtn borderRoundCornerRadius:6];
    _finishBtn.hidden = YES;
    [_finishBtn addTarget:self action:@selector(finishBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_finishBtn];
    
    
    
    
}
-(void)timeFireMethods{
    _seconds--;
    _titleLab.text = [NSString stringWithFormat:@"%zds后自动返回",_seconds];
    NSLog(@"time11111111");
    if(_seconds ==0){
        [_countDownTimer invalidate];
        _countDownTimer = nil;
        [self btnClcik];
        
    }
}

- (void)btnClcik
{
    [_countDownTimer invalidate];
    _countDownTimer = nil;
    // 关闭界面
    if ([_delagte respondsToSelector:@selector(failFinishBackPage)]) {
        
        [_delagte failFinishBackPage];
    }
    
    
}
- (void)setFeedBackDic:(NSDictionary *)feedBackDic
{
    _feedBackDic = feedBackDic;
    if ([feedBackDic[@"isSuccess"]  isEqualToString:@"1"]) {
        NSNotification *notification = [NSNotification notificationWithName:@"notification" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter]postNotification:notification];
        _imageV.image = [UIImage imageNamed:@"pic_device_finish"];
//        _titleLab.text = @"安装完成！";
        _titleLab.font = PingFangSCMedium(15);
        _titleLab.textColor = ColorString(@"#8C8C8C");
        _titleLab.text = @"5s后自动返回";
        [_nextBtn setTitle:@"立即查看设备状态" forState:UIControlStateNormal];
        _nextBtn.backgroundColor = DefaColor;
        _nextBtn.y = _titleLab.bottom + 8 * HeightScale;
        _nextBtn.x = self.width / 2- 176 * WidthScale / 2;
        _nextBtn.width =  176 * WidthScale;
        _finishBtn.y = _nextBtn.bottom + 8 * HeightScale;
        _finishBtn.hidden = NO;
        self.seconds = 5;//60秒倒计时
        self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethods) userInfo:nil repeats:YES];
        
    }else{
        _imageV.image = [UIImage imageNamed:@"pic_device_fail"];
        _titleLab.text = @"安装失败";
        _detailLab.text = feedBackDic[@"msg"];
        CGFloat h = [_detailLab.text heightWithCustomFont:PingFangSCRegular(14) w:250];
        _detailLab.height = h > 33 * HeightScale ? h : 33 * HeightScale;
        [_nextBtn setTitle:@"结束注册" forState:UIControlStateNormal];
        _nextBtn.y = _detailLab.bottom + 10 * HeightScale;
        _nextBtn.backgroundColor = ColorString(@"#FE4F4C");
        _nextBtn.x = self.width / 2- 108 * WidthScale / 2;
        _nextBtn.width =  108 * WidthScale;
    }
    
}
- (void)nextBtnAction
{
    [_countDownTimer invalidate];
    _countDownTimer = nil;
    if ([_feedBackDic[@"isSuccess"]  isEqualToString:@"1"]) {
       
        if ([_delagte respondsToSelector:@selector(successWithIothub_id: iId:nodId:)]) {            
            [_delagte successWithIothub_id:_feedBackDic[@"iothub_id"] iId:_feedBackDic[@"iId"] nodId:_feedBackDic[@"node_Id"]];
        }
    }else{
        if ([_delagte respondsToSelector:@selector(failFinishBackPage)]) {
            
            [_delagte failFinishBackPage];
        }
    }
    
}
- (void)finishBtnAction
{
    [_countDownTimer invalidate];
    _countDownTimer = nil;
    if ([_delagte respondsToSelector:@selector(failFinishBackPage)]) {
        
        [_delagte failFinishBackPage];
    }
}
- (void)dealloc
{
    [_countDownTimer invalidate];
    _countDownTimer = nil;
}
@end
