//
//  IOTHubRegisterView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/4.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "IOTHubRegisterView.h"
#import "ReportViewModel.h"
#import "AILoadingView.h"

@interface IOTHubRegisterView ()
@property(nonatomic, strong)ReportViewModel *reportViewModel;
@property(nonatomic, strong)UIScrollView *stateView;
@property(nonatomic, strong)UIView *blankView;
@property(nonatomic, strong)UIButton *nextBtn;
@property(nonatomic, strong)CADisplayLink *link;
@property(nonatomic, strong)CAShapeLayer *animationLayer;
@property(nonatomic, assign)CGFloat startAngle;
@property(nonatomic, assign)CGFloat endAngle;
@property(nonatomic, assign)CGFloat progress;
@property(nonatomic, strong)UIImageView *imageV;
@property(nonatomic, strong)UILabel *titleLab;
@property(nonatomic, strong)UILabel *subtitleLab;
@property(nonatomic, strong)UILabel *typeLab;
@property(nonatomic, strong)UILabel *macLab;
@property(nonatomic, strong)UILabel *modelLab;
@property(nonatomic, strong)UILabel *modelDetailLab;
@property(nonatomic, strong)UILabel *thingLab;
@property(nonatomic, strong)UILabel *thingDetailLab;
@property(nonatomic, strong)IOTHubRegisterModel *model;
@property(nonatomic, strong)CAAnimationGroup *groupAnnimation;
@property(nonatomic, strong)UIActivityIndicatorView *activity;
@property(nonatomic, strong)AILoadingView *loadingView;
@property(nonatomic, strong)UIView *availableView;
@property(nonatomic, strong)UILabel *thingTitleLab;

@end

@implementation IOTHubRegisterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.width = KScreenWidth;
//        [self borderRoundCornerRadius:36];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight|UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(36, 36)];

        CAShapeLayer *layer = [[CAShapeLayer alloc] init];

        layer.frame = self.bounds;

        layer.path = path.CGPath;

        self.layer.mask = layer;
        [self createUI];
        [self createStateView];
    }
    return self;
}
- (void)createUI
{
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(25 * WidthScale, 30 * HeightScale, 270, 33 * HeightScale)];
    titleLab.text = @"IoTHub注册验证";
    titleLab.textColor = ColorString(@"#121212");
    titleLab.font = PingFangSCMedium(20);
    [self addSubview:titleLab];
    
    self.blankView = [[UIView alloc]initWithFrame:CGRectMake(25 * WidthScale, titleLab.bottom + 94 * HeightScale, self.width - 50 * WidthScale, 315 * HeightScale)];
    _blankView.backgroundColor = ColorString(@"#F6F8FA");
    [_blankView borderRoundCornerRadius:8];
    [self addSubview:_blankView];
    
    
    CGFloat buttonY = 0;
    if (IS_IPHONE_8 || IS_IPHONE_8P) {
        buttonY = self.height - (30 + 52) * HeightScale;
    }else{
        buttonY =  self.height - (44 + 52) * HeightScale;
    }
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(16 * WidthScale,buttonY , 121 * WidthScale, 52 * HeightScale)];
    [backBtn setTitle:@"上一步" forState:UIControlStateNormal];
    [backBtn setTitleColor:DefaColor forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor colorWithHex:@"#0091FF" alpha:0.15];
    backBtn.titleLabel.font = PingFangSCMedium(17);
    [backBtn borderRoundCornerRadius:6];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    
    
    
    
    self.nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(backBtn.right +  10 * WidthScale, buttonY , self.width - 26 * WidthScale - backBtn.right, 52 * HeightScale)];
    _nextBtn.backgroundColor = DefaColor;
    _nextBtn.userInteractionEnabled = NO;
    _nextBtn.titleLabel.font = PingFangSCMedium(17);
    [_nextBtn borderRoundCornerRadius:6];
    [_nextBtn addTarget:self action:@selector(nextBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nextBtn];
    
    self.loadingView  = [[AILoadingView alloc]initWithFrame:CGRectMake(_nextBtn.width / 2- 30/2, _nextBtn.height / 2- 30/2, 30, 30)];
    _loadingView.strokeColor     = [UIColor whiteColor];
    
    [_loadingView starAnimation];
    [_nextBtn addSubview:_loadingView];
    
    //    self.activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(_nextBtn.width / 2- 45/2, _nextBtn.height / 2- 45/2, 45, 45)];//指定进度轮的大小
    //    [_activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];//设置进度轮显示类型
    //    [_nextBtn addSubview:_activity];
    
    //    self.animationLayer = [CAShapeLayer layer];
    //    _animationLayer.bounds = CGRectMake(0, 0, 24 * WidthScale, 24 * WidthScale);
    //    _animationLayer.position = CGPointMake(_nextBtn.width/2.0f, _nextBtn.height/2.0);
    //    _animationLayer.fillColor = [UIColor clearColor].CGColor;
    //    _animationLayer.strokeColor =[UIColor whiteColor].CGColor;
    //    _animationLayer.lineWidth = 3;
    //    _animationLayer.lineCap = kCALineCapRound;
    //    [_nextBtn.layer addSublayer:_animationLayer];
    //
    //    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
    //    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    //    _link.paused = true;
    
}
- (void)createStateView
{
    CGFloat buttonY = 0;
    if (IS_IPHONE_8 || IS_IPHONE_8P) {
        buttonY =  (35 + 52) * HeightScale;
    }else{
        buttonY =  (49 + 52) * HeightScale;
    }
    self.stateView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 88 * HeightScale, KScreenWidth, self.height - 88 * HeightScale - buttonY)];
//    _stateView.backgroundColor = [UIColor redColor];
    _stateView.showsVerticalScrollIndicator = NO;
    _stateView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_stateView];
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(25 * WidthScale, 0, 50 * WidthScale, 50 * WidthScale)];
    
    [_stateView addSubview:_imageV];
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(_imageV.right + 20 * WidthScale, 0, self.width - _imageV.right - 40 * WidthScale, 24 * HeightScale)];
    _titleLab.textColor = ColorString(@"#121212");
    _titleLab.font = PingFangSCRegular(16);
    [_stateView addSubview:_titleLab];
    
    self.subtitleLab = [[UILabel alloc]initWithFrame:CGRectMake(_imageV.right + 20 * WidthScale,_titleLab.bottom + 5 * HeightScale,  self.width - _imageV.right - 40 * WidthScale, 20 * HeightScale)];
    _subtitleLab.textColor = ColorString(@"#808080");
    _subtitleLab.font = PingFangSCRegular(14);
    _subtitleLab.numberOfLines = 0;
    [_stateView addSubview:_subtitleLab];
    
    self.availableView = [[UIView alloc]initWithFrame:CGRectMake(25 * WidthScale, _subtitleLab.bottom + 20 * HeightScale, self.width - 50 * WidthScale , 315 * HeightScale)];
    [_availableView border:[UIColor colorWithWhite:0 alpha:0.19] width:1 CornerRadius:8];
    [_stateView addSubview:_availableView];
    CGFloat titleW = 100 * WidthScale;
    UILabel *avTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(20 * WidthScale, 20 * HeightScale, titleW, 24 * HeightScale)];
    avTitleLab.textColor = ColorString(@"#121212");
    avTitleLab.font = PingFangSCRegular(16);
    avTitleLab.text = @"验证属性";
    
    [_availableView addSubview:avTitleLab];
    CGFloat wid = _availableView.width ;
    UILabel *typeTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(20 * WidthScale, avTitleLab.bottom + 20 * HeightScale, titleW, 32 * HeightScale)];
    typeTitleLab.textColor = ColorString(@"#0091FF");
    typeTitleLab.font = PingFangSCMedium(14);
    typeTitleLab.text = @"设备类型";
    typeTitleLab.textAlignment = NSTextAlignmentCenter;
    typeTitleLab.backgroundColor = [UIColor colorWithHex:@"#0091FF" alpha:0.08];
    [typeTitleLab borderRoundCornerRadius:32 * HeightScale / 2];
    [_availableView addSubview:typeTitleLab];
    self.typeLab = [[UILabel alloc]initWithFrame:CGRectMake(typeTitleLab.right + 15 * WidthScale, 0, wid - typeTitleLab.right - 30 * WidthScale, 24 * HeightScale)];
    _typeLab.textColor = ColorString(@"#121212");
    _typeLab.font = PingFangSCRegular(16);
    _typeLab.centerY = typeTitleLab.centerY;
    [_availableView addSubview:_typeLab];
    
    UILabel *macTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(20 * WidthScale,typeTitleLab.bottom + 25 * HeightScale, titleW, 32 * HeightScale)];
    macTitleLab.textColor = ColorString(@"#26C464");
    macTitleLab.font = PingFangSCMedium(14);
    macTitleLab.text = @"设备标识码";
    macTitleLab.textAlignment = NSTextAlignmentCenter;
    macTitleLab.backgroundColor = [UIColor colorWithHex:@"#26C464" alpha:0.08];
    [macTitleLab borderRoundCornerRadius:32 * HeightScale / 2];
    [_availableView addSubview:macTitleLab];
    self.macLab = [[UILabel alloc]initWithFrame:CGRectMake(macTitleLab.right + 15 * WidthScale, 0, wid - macTitleLab.right - 30 * WidthScale, 24 * HeightScale)];
    _macLab.textColor = ColorString(@"#121212");
    _macLab.font = PingFangSCRegular(16);
    _macLab.centerY = macTitleLab.centerY;
    [_availableView addSubview:_macLab];
    
    
    
    UILabel *modelTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(20 * WidthScale,macTitleLab.bottom + 25 * HeightScale, titleW, 32 * HeightScale)];
    modelTitleLab.textColor = ColorString(@"#A35CF3");
    modelTitleLab.font = PingFangSCMedium(14);
    modelTitleLab.text = @"实例";
    modelTitleLab.textAlignment = NSTextAlignmentCenter;
    
    modelTitleLab.backgroundColor = [UIColor colorWithHex:@"#A35CF3" alpha:0.08];
    [modelTitleLab borderRoundCornerRadius:32 * HeightScale / 2];
    [_availableView addSubview:modelTitleLab];
    self.modelLab = [[UILabel alloc]initWithFrame:CGRectMake(modelTitleLab.right + 15 * WidthScale, 0, wid - modelTitleLab.right - 30 * WidthScale, 24 * HeightScale)];
    _modelLab.textColor = ColorString(@"#121212");
    _modelLab.font = PingFangSCRegular(16);
    _modelLab.centerY = modelTitleLab.centerY;
    [_availableView addSubview:_modelLab];
    self.modelDetailLab = [[UILabel alloc]initWithFrame:CGRectMake(modelTitleLab.right + 15 * WidthScale, _modelLab.bottom + 3 * HeightScale, wid - modelTitleLab.right - 30 * WidthScale, 20 * HeightScale)];
    _modelDetailLab.textColor = ColorString(@"#8F9FB3");
    _modelDetailLab.numberOfLines = 0;
    _modelDetailLab.font = PingFangSCRegular(14);
    [_availableView addSubview:_modelDetailLab];
    
    
    
    UILabel *thingTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(20 * WidthScale,modelTitleLab.bottom + 25 * HeightScale, titleW, 32 * HeightScale)];
    thingTitleLab.textColor = ColorString(@"#FBB54C");
    thingTitleLab.font = PingFangSCMedium(14);
    thingTitleLab.text = @"thing ID";
    thingTitleLab.backgroundColor = [UIColor colorWithHex:@"#FBB54C" alpha:0.08];
    [thingTitleLab borderRoundCornerRadius:32 * HeightScale / 2];
    [_availableView addSubview:thingTitleLab];
    thingTitleLab.textAlignment = NSTextAlignmentCenter;
    self.thingTitleLab = thingTitleLab;
    
    self.thingLab = [[UILabel alloc]initWithFrame:CGRectMake(thingTitleLab.right + 15 * WidthScale, 0, wid - thingTitleLab.right - 30 * WidthScale, 24 * HeightScale)];
    _thingLab.textColor = ColorString(@"#121212");
    _thingLab.font = PingFangSCRegular(16);
    _thingLab.centerY = thingTitleLab.centerY;
    _thingLab.text = @"-";
    [_availableView addSubview:_thingLab];
    
    self.thingDetailLab = [[UILabel alloc]initWithFrame:CGRectMake(thingTitleLab.right + 15 * WidthScale, _thingLab.bottom + 3 * HeightScale, wid - thingTitleLab.right - 30 * WidthScale, 20 * HeightScale)];
    _thingDetailLab.textColor = ColorString(@"#8F9FB3");
    _thingDetailLab.font = PingFangSCRegular(14);
    _thingDetailLab.text = @"-";
    _thingDetailLab.adjustsFontSizeToFitWidth = YES;
    [_availableView addSubview:_thingDetailLab];
    _availableView.height = 315 * HeightScale< _thingDetailLab.bottom + 20 * HeightScale?_thingDetailLab.bottom + 20 * HeightScale:315 * HeightScale;
    _stateView.contentSize = CGSizeMake(0, _availableView.bottom + 80 * HeightScale);
    
}
- (void)setDataIsSuccess:(BOOL)isSuccess msgStr:(NSString *)msgStr dic:(IOTHubRegisterModel *)model
{
    self.blankView.hidden = YES;
    self.stateView.hidden = NO;
    _stateView.contentOffset = CGPointMake(0, 0);
    
    _typeLab.text = _paramsDic[@"typeName"];
    
    _macLab.text = _paramsDic[@"node_Id"];
    _modelLab.text = _paramsDic[@"instance_name"];
    _modelDetailLab.text = _paramsDic[@"root_ip"];
    CGFloat h1 = [_modelDetailLab.text heightWithCustomFont:PingFangSCRegular(14) w:_modelDetailLab.width];
    _modelDetailLab.height = h1 > 20 * HeightScale ? h1 : 20 * HeightScale;
    _thingTitleLab.y = _modelDetailLab.bottom + 10 * HeightScale;
    _thingLab.centerY = _thingTitleLab.centerY;
    _thingDetailLab.y = _thingLab.bottom + 3 * HeightScale;
    _availableView.height = 315 * HeightScale < _thingDetailLab.bottom + 20 * HeightScale?_thingDetailLab.bottom + 20 * HeightScale:315 * HeightScale;
//    _availableView.backgroundColor = [UIColor redColor];
    _stateView.contentSize = CGSizeMake(0, _availableView.bottom + 80 * HeightScale);

    //    msgStr = @"该[6043552190]标识码的设备未在此IoTHub实例中注册";
    _subtitleLab.text = msgStr;
    CGFloat h = [msgStr heightWithCustomFont:PingFangSCRegular(14) w: self.width - _imageV.right - 40 * WidthScale];
    _subtitleLab.height = h > 20 * HeightScale ? h : 20 * HeightScale;
    _availableView.y = _subtitleLab.bottom + 20 * HeightScale;
    
    if (isSuccess) {
        _imageV.image = [UIImage imageNamed:@"icon_success"];
        _titleLab.text = @"验证通过！";
        _titleLab.textColor = ColorString(@"#26C464");
        _thingLab.text = model.thing_id;
        _thingDetailLab.text = model.thing_title;
        
    }else{
        _imageV.image = [UIImage imageNamed:@"icon_fail"];
        _titleLab.text = @"验证失败！";
        _titleLab.textColor = ColorString(@"#FA6400");
        _thingLab.text = @"-";
        _thingDetailLab.text = @"-";
        
    }
    
}
- (void)nextBtnAction
{
    if (_model) {
        if ([self.delagte respondsToSelector:@selector(iothubRegisterNextPageWithIOTHubRegisterModel:)]) {
            
            [self.delagte iothubRegisterNextPageWithIOTHubRegisterModel:_model];
        }

    }else{
        if ([self.delagte respondsToSelector:@selector(iothubFailRegisterBackPage)]) {
            
            [self.delagte iothubFailRegisterBackPage];
        }

    }
}
-(void)backBtnAction
{
    [self.delagte iothubRegisterBackPage];
    
}
- (void)setParamsDic:(NSDictionary *)paramsDic
{
    _paramsDic = paramsDic;
    [_nextBtn setTitle:@"" forState:UIControlStateNormal];
    _nextBtn.backgroundColor = DefaColor;
    //    _animationLayer.hidden = NO;
    
    //    [self start];
    //    _activity.hidden = NO;
    //    [_activity startAnimating];
    _loadingView.hidden = NO;
    [_loadingView starAnimation];
    self.blankView.hidden = NO;
    self.stateView.hidden = YES;
    
    [self registerIotHub];
}
- (void)registerIotHub
{
    CZHWeakSelf(self)
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2* NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.reportViewModel iotHubRegisterWithParams:@{@"iothub_id":weakself.paramsDic[@"iothub_id"],@"node_Id":weakself.paramsDic[@"node_Id"]} Completion:^(BOOL success, NSString * _Nonnull msg, IOTHubRegisterModel * _Nonnull model) {
            //        [weakself hide];
            //        weakself.animationLayer.hidden = YES;
            //            weakself.activity.hidden = YES;
            //            [weakself.activity stopAnimating];
            weakself.loadingView.hidden = YES;
            [weakself.loadingView stopAnimation];
            weakself.nextBtn.userInteractionEnabled = YES;
            if (success) {
                [weakself.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
                weakself.nextBtn.backgroundColor = DefaColor;
            }else{
                [weakself.nextBtn setTitle:@"取消注册" forState:UIControlStateNormal];
                weakself.nextBtn.backgroundColor =ColorString(@"#FE4F4C") ;
            }
            
            weakself.model = model;
            [weakself setDataIsSuccess:success msgStr:msg dic:model];
        }];
//    });
    
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2* NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    //        //            NSLog(@"延时方法4");
    //
    //        int x = arc4random() % 5;
    //        weakself.nextBtn.userInteractionEnabled = YES;
    //
    //        if (x>1) {
    //
    //
    //            [self.reportViewModel iotHubRegisterWithParams:@{@"iothub_id":weakself.paramsDic[@"iothub_id"],@"node_Id":weakself.paramsDic[@"node_Id"]} Completion:^(BOOL success, NSString * _Nonnull msg, IOTHubRegisterModel * _Nonnull model) {
    //                [weakself hide];
    //                weakself.animationLayer.hidden = YES;
    //                weakself.model = model;
    //            }];
    //        }else{
    //            [weakself hide];
    //            weakself.animationLayer.hidden = YES;
    //
    //            [weakself setDataIsSuccess:NO msgStr:@"IoTHub中不存在此设备" dic:nil];
    //
    //
    //        }
    //    });
    
}

-(void)displayLinkAction{
    _progress += [self speed];
    if (_progress >= 1) {
        _progress = 0;
    }
    [self updateAnimationLayer];
}
-(void)start{
    _link.paused = false;
}

-(void)hide{
    _link.paused = true;
    _progress = 0;
}
-(void)updateAnimationLayer{
    _startAngle = -M_PI_2;
    _endAngle = -M_PI_2 +_progress * M_PI * 2;
    if (_endAngle > M_PI) {
        CGFloat progress1 = 1 - (1 - _progress)/0.25;
        _startAngle = -M_PI_2 + progress1 * M_PI * 2;
    }
    CGFloat radius = _animationLayer.bounds.size.width/2.0f - 3/2.0f;
    CGFloat centerX = _animationLayer.bounds.size.width/2.0f;
    CGFloat centerY = _animationLayer.bounds.size.height/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:_startAngle endAngle:_endAngle clockwise:true];
    path.lineCapStyle = kCGLineCapRound;
    
    _animationLayer.path = path.CGPath;
}

-(CGFloat)speed{
    if (_endAngle > M_PI) {
        return 0.3/60.0f;
    }
    return 2/60.0f;
}

- (ReportViewModel *)reportViewModel
{
    if (_reportViewModel == nil) {
        _reportViewModel = [[ReportViewModel alloc]init];
    }
    return _reportViewModel;
}


@end
