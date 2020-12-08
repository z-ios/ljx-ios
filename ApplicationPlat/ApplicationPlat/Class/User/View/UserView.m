//
//  UserView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/8.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "UserView.h"
#import "CLLanguageManager.h"
#import "TabController.h"
@interface UserView ()

@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UISwitch *langeSwitch;
@property(nonatomic, strong)UILabel *lanLab;

@end


@implementation UserView
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
    CGFloat titleWid  = 250 * WidthScale;
    CGFloat titleY = 0;
    CGFloat detalY = 0;
    if (IS_IPHONE_8P || IS_IPHONE_8) {
         
         titleY = 18 * HeightScale;
         detalY = 30 * HeightScale;
    }else{
         titleY = 13 * HeightScale;
         detalY = 25 * HeightScale;

    }
    self.width = SCREEN_WIDTH;
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height - 110 * HeightScale)];
    [self addSubview:_scrollView];
    UILabel *noticeLab = [UILabel labelWithframe:CGRectMake(20 * WidthScale, 30 * HeightScale , titleWid, 30 * HeightScale) title:NSLocalizedString(@"setMessageTitle", nil) font:[UIFont italicSystemFontOfSize:38] color:ColorString(@"#909399") line:0];
    noticeLab.font = PingFangSCRegular(15);
    [_scrollView addSubview:noticeLab];
    UILabel *noticeDetailLab = [UILabel labelWithframe:CGRectMake(20 * WidthScale, titleY + noticeLab.bottom, titleWid, 30 * HeightScale) title:NSLocalizedString(@"setMessageSub", nil) font:[UIFont italicSystemFontOfSize:38] color:ColorString(@"#303133") line:0];
    noticeDetailLab.font = PingFangSCRegular(13);
    [_scrollView addSubview:noticeDetailLab];
    
    UISwitch *notiSwit = [[UISwitch alloc]initWithFrame:CGRectMake(KScreenWidth - 65 * WidthScale, titleY + noticeLab.bottom, 45 * WidthScale, 30 * HeightScale)];
    notiSwit.transform = CGAffineTransformMakeScale(0.75,0.75);
    notiSwit.onTintColor = ColorString(@"#0B9AF5");
    notiSwit.tintColor = ColorString(@"#AEB8C0");
    notiSwit.enabled = YES;
    [notiSwit addTarget:self action:@selector(notiSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:notiSwit];
    
    CAShapeLayer *accountLine = [UIView drawLine:CGPointMake(0, noticeDetailLab.bottom + detalY) to:CGPointMake(KScreenWidth , noticeDetailLab.bottom + detalY) color:[UIColor colorWithHex:@"#979797" alpha:0.2] lineWidth:1];
    [_scrollView.layer addSublayer:accountLine];
    
    UILabel *locLab = [UILabel labelWithframe:CGRectMake(20 * WidthScale, noticeDetailLab.bottom + detalY + 15 * HeightScale + 1, titleWid, 30 * HeightScale) title:NSLocalizedString(@"setLocationTitle", nil) font:[UIFont italicSystemFontOfSize:38] color:ColorString(@"#909399") line:0];
    locLab.font = PingFangSCRegular(15);
    [_scrollView addSubview:locLab];
    
    UIButton *locBtn = [[UIButton alloc]initWithFrame:CGRectMake(20 * WidthScale,  20 * HeightScale + locLab.bottom, 20 * WidthScale, 20 * WidthScale)];
    [locBtn setImage:[UIImage imageNamed:@"icon_location"] forState:UIControlStateNormal];
//    locBtn.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:locBtn];
    
    UILabel *locDetailLab = [UILabel labelWithframe:CGRectMake(locBtn.right + 8 * WidthScale, 13 * HeightScale + locLab.bottom, self.width - (locBtn.right + 18 * WidthScale)- 65 * WidthScale , 50 * HeightScale) title:NSLocalizedString(@"setLocationSub", nil) font:[UIFont italicSystemFontOfSize:38] color:ColorString(@"#303133") line:0];
    locDetailLab.font = PingFangSCRegular(13);
    [_scrollView addSubview:locDetailLab];
    UISwitch *locSwit = [[UISwitch alloc]initWithFrame:CGRectMake(KScreenWidth - 65 * WidthScale, 13 * HeightScale + locLab.bottom, 45 * WidthScale, 30 * HeightScale)];
    locSwit.transform = CGAffineTransformMakeScale(0.75,0.75);
    locSwit.onTintColor = ColorString(@"#0B9AF5");
    locSwit.tintColor = ColorString(@"#AEB8C0");
    locSwit.enabled = YES;
    [locSwit addTarget:self action:@selector(locSwitAction:) forControlEvents:UIControlEventTouchUpInside];

    [_scrollView addSubview:locSwit];
    
    CAShapeLayer *locLine = [UIView drawLine:CGPointMake(0, locDetailLab.bottom + detalY) to:CGPointMake(KScreenWidth , locDetailLab.bottom + detalY) color:[UIColor colorWithHex:@"#979797" alpha:0.2] lineWidth:1];
    [_scrollView.layer addSublayer:locLine];
    
    
    
    UILabel *langeLab = [UILabel labelWithframe:CGRectMake(20 * WidthScale, locDetailLab.bottom + detalY + 15 * HeightScale + 1 , titleWid, 30 * HeightScale) title:@"语言" font:[UIFont italicSystemFontOfSize:38] color:ColorString(@"#909399") line:0];
    langeLab.font = PingFangSCRegular(15);
    [_scrollView addSubview:langeLab];
    UILabel *langDetailLab = [UILabel labelWithframe:CGRectMake(20 * WidthScale, titleY + langeLab.bottom, titleWid-100 * WidthScale, 30 * HeightScale) title:@"切换语言" font:[UIFont italicSystemFontOfSize:38] color:ColorString(@"#303133") line:0];
    
    langDetailLab.font = PingFangSCRegular(13);
    [_scrollView addSubview:langDetailLab];
    
    self.lanLab = [UILabel labelWithframe:CGRectMake(KScreenWidth - 65 * WidthScale- 100 * WidthScale,titleY + langeLab.bottom, 100 * WidthScale, 30 * HeightScale) title:[[NSBundle currentLanguage] isEqualToString:@"en"] ? @"English":@"简体中文" font:[UIFont italicSystemFontOfSize:38] color:ColorString(@"#0B9AF5") line:0];
    _lanLab.textAlignment = NSTextAlignmentRight;
    _lanLab.font = PingFangSCRegular(13);
    [_scrollView addSubview:_lanLab];
    
    self.langeSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(KScreenWidth - 65 * WidthScale, titleY + langeLab.bottom, 45 * WidthScale, 30 * HeightScale)];
    _langeSwitch.transform = CGAffineTransformMakeScale(0.75,0.75);
    _langeSwitch.onTintColor = ColorString(@"#0B9AF5");
    _langeSwitch.tintColor = ColorString(@"#AEB8C0");
    [_langeSwitch addTarget:self action:@selector(langSwitAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_langeSwitch];
    
    
    if ([[NSBundle currentLanguage] isEqualToString:@"en"]) {
        _langeSwitch.on = NO;

       
    }else{
        _langeSwitch.on = YES;

    }
    
    CAShapeLayer *langLine = [UIView drawLine:CGPointMake(0, langDetailLab.bottom + detalY) to:CGPointMake(KScreenWidth , langDetailLab.bottom + detalY) color:[UIColor colorWithHex:@"#979797" alpha:0.2] lineWidth:1];
    [_scrollView.layer addSublayer:langLine];
    
    
    UILabel *versionLab = [UILabel labelWithframe:CGRectMake(20 * WidthScale, langDetailLab.bottom + detalY + 15 * HeightScale + 1, titleWid, 30 * HeightScale) title:NSLocalizedString(@"setVersionTitle", nil) font:[UIFont italicSystemFontOfSize:38] color:ColorString(@"#909399") line:0];
    versionLab.font = PingFangSCRegular(15);
    [_scrollView addSubview:versionLab];
    NSString *versionShort = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];

    UILabel *versionDetailLab = [UILabel labelWithframe:CGRectMake(20 * WidthScale, titleY + versionLab.bottom, 150 * WidthScale, 30 * HeightScale) title:[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"setVersionSub", nil),versionShort] font:[UIFont italicSystemFontOfSize:38] color:ColorString(@"#303133") line:0];
    versionDetailLab.font = PingFangSCRegular(13);
    [_scrollView addSubview:versionDetailLab];
    
    
//    UIButton *versionBtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth - 40 * WidthScale, 23 * HeightScale + versionLab.bottom, 20 * WidthScale, 20 * WidthScale)];
//    [versionBtn setImage:[UIImage imageNamed:@"icon_version"] forState:UIControlStateNormal];
//    versionBtn.centerY = versionDetailLab.centerY;
//    [versionBtn addTarget:self action:@selector(verBtnAction: ) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:versionBtn];
    
    UIImageView *versionBtn = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth - 40 * WidthScale, titleY + versionLab.bottom, 20 * WidthScale, 20 * WidthScale)];
    versionBtn.image = [UIImage imageNamed:@"icon_version"];
    versionBtn.centerY = versionDetailLab.centerY;
    versionBtn.userInteractionEnabled = YES;
    [versionBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(verBtnAction:)]];
    self.versionBtn = versionBtn;
    [_scrollView addSubview:versionBtn];
    
    UIButton *checkverBtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth / 2 - 60 * WidthScale, versionDetailLab.bottom + 20 * HeightScale, 120 * WidthScale, 30 * HeightScale)];
    [checkverBtn setTitle:NSLocalizedString(@"setVersionCheckBtn", nil) forState:UIControlStateNormal];
    [checkverBtn setTitleColor:ColorString(@"#0091FF") forState:UIControlStateNormal];
    checkverBtn.titleLabel.font = PingFangSCRegular(13);
    [checkverBtn addTarget:self action:@selector(checkBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:checkverBtn];
    
    CAShapeLayer *versionLine = [UIView drawLine:CGPointMake(0, checkverBtn.bottom + 10 * HeightScale) to:CGPointMake(KScreenWidth , checkverBtn.bottom + 10 * HeightScale) color:[UIColor colorWithHex:@"#979797" alpha:0.2] lineWidth:1];
    [_scrollView.layer addSublayer:versionLine];
    _scrollView.contentSize = CGSizeMake(0, checkverBtn.bottom + 40 * HeightScale);

    UIButton *loginOutBtn = [[UIButton alloc]initWithFrame:CGRectMake(20 * WidthScale, self.height - 91 * HeightScale, KScreenWidth - 20 * WidthScale * 2, 52 * HeightScale)];
    [loginOutBtn setTitle:NSLocalizedString(@"setBtn", nil) forState:UIControlStateNormal];
    loginOutBtn.backgroundColor = ColorString(@"#E02020");
    loginOutBtn.titleLabel.font = PingFangSCRegular(16);
    [loginOutBtn borderRoundCornerRadius:8];
    [loginOutBtn addTarget:self action:@selector(loginOutBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginOutBtn];
    
}
#pragma mark -- 版本更新
- (void)verBtnAction:(UITapGestureRecognizer *)btn
{
    _versionBtn.userInteractionEnabled = NO;
    //旋转动画
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0;
    rotationAnimation.speed = 0.3;
    rotationAnimation.cumulative = YES;
    //后台进前台动画重启
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.repeatCount = MAXFLOAT;
    [_versionBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    if ([_delegate respondsToSelector:@selector(nextUpdateVc)]) {
        [self.delegate nextUpdateVc];
    }
}
#pragma mark --  检查版本
- (void)checkBtnAction
{
    if ([_delegate respondsToSelector:@selector(checkUpdateVersion)]) {
        [self.delegate checkUpdateVersion];
    }
}
#pragma mark -- 登出
- (void)loginOutBtnAction
{
    if ([_delegate respondsToSelector:@selector(loginOut)]) {
        [self.delegate loginOut];
        
    }
}
#pragma mark -- 通知
- (void)notiSwitchAction:(UISwitch *)swit
{
    swit.on = NO;
    [self.delegate notOpen];
}
#pragma mark -- 位置
- (void)locSwitAction:(UISwitch *)swit
{
    swit.on = NO;

    [self.delegate notOpen];

}
#pragma mark -- 语言
- (void)langSwitAction:(UISwitch *)swit
{
    if (swit.on) {
        _lanLab.text = @"简体中文";
        [CLLanguageManager setUserLanguage:@"zh-Hans"];
    }else{
        _lanLab.text = @"English";

        [CLLanguageManager setUserLanguage:@"en"];
    }
    
    
    TabController *tabBarVC1 = [[TabController alloc]init];
    tabBarVC1.selectedIndex = 4;
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    if (!window) {
        window = [UIApplication sharedApplication].windows.lastObject;
    }
    if (@available(iOS 13,*)) {
        
    }else{
        window = [UIApplication sharedApplication].keyWindow;
        
    }
    

    [window transitionRootVc];
    window.rootViewController = tabBarVC1;
    
    
}
@end
