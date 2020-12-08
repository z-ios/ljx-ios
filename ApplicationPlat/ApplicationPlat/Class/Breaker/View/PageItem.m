//
//  PageItem.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/30.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "PageItem.h"
#import "TopView.h"
#import "BoardView.h"
#import "SignalView.h"
#import "AlertListView.h"
#import "DataItemModel.h"
#import "BranchbreakViewModel.h"
#import "BreakerAlertView.h"


@interface PageItem ()<TopViewCellDelagte>
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)AlertListView *alertView;
@property(nonatomic, strong)MainbreakerModel *mainModel;
@property(nonatomic, strong)BranchbreakViewModel *branchViewModel;
@property(nonatomic, strong)TopView *rightView;
@property(nonatomic, strong)TopView *leftView;
@property(nonatomic, strong)BoardView *powerView;
@property(nonatomic, strong)BoardView *kwView;
@property(nonatomic, strong)SignalView *kwhView;
@property(nonatomic, strong)SignalView *templateView;
@property(nonatomic, strong)SignalView *currentView;
@property(nonatomic, strong)BreakerAlertView *bAlertView;
@property (nonatomic ,strong)dispatch_source_t timer;//  注意:此处应该使用强引用 strong

@end


@implementation PageItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ColorString(@"#F4F6FC");
        [self createScrollView];

    }
    return self;
}
- (void)createScrollView
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - Height_NavBar -40 )];
    _scrollView.backgroundColor = ColorString(@"#F4F6FC");
    [self addSubview:self.scrollView];
    self.rightView = [[TopView alloc]initWithFrame:CGRectMake(20 * WidthScale, 32 * HeightScale, (KScreenWidth - 60 * WidthScale) / 2, 140 * HeightScale) typeStr:@"switch"];
    _rightView.backgroundColor = [UIColor whiteColor];
    _rightView.titleLab.text = NSLocalizedString(@"breakerDeitalOpen", nil);
    _rightView.detialLab.text = NSLocalizedString(@"breakerDeitalCondition", nil);
    _rightView.iId = self.iId;
    _rightView.address_485 = self.address_485;
    [_rightView.imageBtn setImage:[UIImage imageNamed:@"icon_stats-n"] forState:UIControlStateNormal];
    _rightView.deleagte = self;
    [_scrollView addSubview:_rightView];
    
    
    
    self.leftView = [[TopView alloc]initWithFrame:CGRectMake(_rightView.right +20 * WidthScale, 32 * HeightScale, (KScreenWidth - 60 * WidthScale) / 2, 140 * HeightScale) typeStr:@"auto"];
    _leftView.backgroundColor = [UIColor whiteColor];
    _leftView.titleLab.text = NSLocalizedString(@"breakerDeitalManual", nil);
    _leftView.detialLab.text = NSLocalizedString(@"breakerDeitalSwitch", nil);
    _leftView.iId = self.iId;
    _leftView.address_485 = self.address_485;
    _leftView.deleagte = self;
    [_leftView.imageBtn setImage:[UIImage imageNamed:@"icon_mode-n"] forState:UIControlStateNormal];
    [_scrollView addSubview:_leftView];
    
    
    
    self.powerView = [[BoardView alloc]initWithFrame:CGRectMake(20 * WidthScale,_leftView.bottom + 16 * HeightScale, KScreenWidth - 40 * WidthScale, 100 * HeightScale) typeStr:@"power"];
    _powerView.backgroundColor = [UIColor whiteColor];
    //    DataItemModel *model2 = self.mainModel.data_items[2];
    //      NSString *str = model2.converted_data ? [model2.converted_data componentsSeparatedByString:@","][0]: @"";
    //    powerView.titleLab.text = str;
    //    NSString *powerString = [NSString stringWithFormat:@"%@       kWh",NSLocalizedString(@"breakerDeitalElectricity", nil)];
    //    NSMutableAttributedString *powerStringM = [[NSMutableAttributedString alloc] initWithString:powerString];
    //    NSRange kRange = [powerString rangeOfString:@"kWh"];
    //    [powerStringM addAttribute:NSFontAttributeName value:PingFangSCLight(13) range:NSMakeRange(0, powerStringM.length - 3)]; // 设置字体字号
    //    [powerStringM addAttribute:NSForegroundColorAttributeName value:ColorString(@"#798794") range:NSMakeRange(0, powerStringM.length - 3)];
    //
    //    [powerStringM addAttribute:NSFontAttributeName value:PingFangSCLight(10) range:NSMakeRange(kRange.location, 3)]; // 设置字体字号
    //    [powerStringM addAttribute:NSForegroundColorAttributeName value:ColorString(@"#798794") range:NSMakeRange(kRange.location, 3)];
    _powerView.detialLab.text = NSLocalizedString(@"breakerDeitalElectricity", nil);
    
    //    powerView.detialLab.text = @"实时电量       kWh";
    
    [_powerView.imageBtn  setImage:[UIImage imageNamed:@"icon_electric"] forState:UIControlStateNormal];
    [_scrollView addSubview:_powerView];
    
    self.kwView = [[BoardView alloc]initWithFrame:CGRectMake(20 * WidthScale,_powerView.bottom + 16 * HeightScale, KScreenWidth - 40 * WidthScale, 100 * HeightScale) typeStr:@"kw"];
    _kwView.backgroundColor = [UIColor whiteColor];
    _kwView.titleLab.text = @"34.12";
    //    NSString *valueString = [NSString stringWithFormat:@"%@",NSLocalizedString(@"breakerDeitalPower", nil)];
    //    NSMutableAttributedString *stringM = [[NSMutableAttributedString alloc] initWithString:valueString];
    //    NSRange range = [valueString rangeOfString:@"kW"];
    //    [stringM addAttribute:NSFontAttributeName value:PingFangSCLight(13) range:NSMakeRange(0, stringM.length - 2)]; // 设置字体字号
    //    [stringM addAttribute:NSForegroundColorAttributeName value:ColorString(@"#798794") range:NSMakeRange(0, stringM.length - 2)];
    //
    //    [stringM addAttribute:NSFontAttributeName value:PingFangSCLight(10) range:NSMakeRange(range.location, 2)]; // 设置字体字号
    //    [stringM addAttribute:NSForegroundColorAttributeName value:ColorString(@"#798794") range:NSMakeRange(range.location, 2)];
    _kwView.detialLab.text = NSLocalizedString(@"breakerDeitalPower", nil);
    //    kwView.imageBtn.backgroundColor = ColorString(@"#44D7B6");
    [_kwView.imageBtn  setImage:[UIImage imageNamed:@"icon_power"] forState:UIControlStateNormal];
    
    [_scrollView addSubview:_kwView];
    
    //    SignalView *signalView = [[SignalView alloc]initWithFrame:CGRectMake(20 * WidthScale, kwView.bottom + 16 * HeightScale, (KScreenWidth - 60 * WidthScale) / 2, 140 * HeightScale) typeStr:@"signal"];
    //    signalView.backgroundColor = [UIColor whiteColor];
    //    signalView.titleLab.text = @"-119";
    //    signalView.detialLab.text = @"信号强度";
    //    signalView.imageBtn.backgroundColor = ColorString(@"#E4FACC");
    //    signalView.unitLab.text = @"db";
    //    [_scrollView addSubview:signalView];
    
    self.kwhView = [[SignalView alloc]initWithFrame:CGRectMake(20 * WidthScale, _kwView.bottom + 16 * HeightScale, (KScreenWidth - 60 * WidthScale) / 3, 120 * HeightScale) typeStr:@"kwh"];
    _kwhView.backgroundColor = [UIColor whiteColor];
//    _kwhView.titleLab.text = @"212.34";
    _kwhView.detialLab.text = NSLocalizedString(@"breakerDeitalVoltage", nil);
    [_kwhView.imageBtn setImage:[UIImage imageNamed:@"icon_voltage"] forState:UIControlStateNormal];
    _kwhView.unitLab.text = @"V";
    [_scrollView addSubview:_kwhView];
    
    self.templateView = [[SignalView alloc]initWithFrame:CGRectMake(_kwhView.right+10 * WidthScale, _kwView.bottom + 16 * HeightScale, (KScreenWidth - 60 * WidthScale) / 3, 120 * HeightScale) typeStr:@"template"];
    _templateView.backgroundColor = [UIColor whiteColor];
//    _templateView.titleLab.text = @"36.39";
    _templateView.detialLab.text = NSLocalizedString(@"breakerDeitalTemperature", nil);
    [_templateView.imageBtn setImage:[UIImage imageNamed:@"icon_tempreture"] forState:UIControlStateNormal];
    _templateView.unitLab.text = @"℃";
    [_scrollView addSubview:_templateView];
    
    
    
    self.currentView = [[SignalView alloc]initWithFrame:CGRectMake(_templateView.right+10 * WidthScale, _kwView.bottom + 16 * HeightScale, (KScreenWidth - 60 * WidthScale) / 3, 120 * HeightScale) typeStr:@"current"];
    _currentView.backgroundColor = [UIColor whiteColor];
    _currentView.titleLab.text = @"16.39";
    _currentView.detialLab.text = NSLocalizedString(@"breakerDeitalCurrent", nil);
    [_currentView.imageBtn setImage:[UIImage imageNamed:@"icon_current"] forState:UIControlStateNormal];
    
    _currentView.unitLab.text = @"A";
    [_scrollView addSubview:_currentView];
    
    
//    CZHWeakSelf(self)
    
    
    self.bAlertView = [[BreakerAlertView alloc]initWithFrame:CGRectMake(20 * WidthScale, _currentView.bottom + 16 * HeightScale, KScreenWidth - 40 * WidthScale, 200 * HeightScale)];
    _bAlertView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_bAlertView];
    _scrollView.contentSize = CGSizeMake(0, _bAlertView.bottom+ 50 * HeightScale);

//    _bAlertView.updateAlertHeight = ^(CGFloat height) {
//
//        weakself.scrollView.contentSize = CGSizeMake(0, weakself.bAlertView.bottom+ 50 * HeightScale);
//    };
//    _scrollView.contentSize = CGSizeMake(0, _currentView.bottom + 50 * HeightScale);

    
//    self.alertView = [[AlertListView alloc]initWithFrame:CGRectMake(20 * WidthScale, _currentView.bottom + 16 * HeightScale, KScreenWidth - 40 * WidthScale, 100 * HeightScale) ];
//    _alertView.backgroundColor = [UIColor whiteColor];
//    //    [_scrollView addSubview:_alertView];
//    _scrollView.contentSize = CGSizeMake(0, _currentView.bottom + 50 * HeightScale);
//    _alertView.updateAlertHeight = ^(CGFloat height) {
//        weakself.alertView.height = height;
//        weakself.scrollView.contentSize = CGSizeMake(0, weakself.alertView.bottom + 50 * HeightScale);
//
//    };
    
    
    
}
#pragma mark cell Delegate
- (void)presentTopViewWithAlert:(UIAlertController *)alert isDismiss:(BOOL)isDiss
{
    if (isDiss) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.superview.viewController presentViewController:alert animated:YES completion:^{
            
        }];
    }
}
- (void)getData
{
    CZHWeakSelf(self)
    [self.branchViewModel breakerWithParams:self.iId Completion:^(BOOL success, BreakSingleModel * _Nonnull model, NSString * _Nonnull errorMsg) {
        
        if (success) {
            NSLog(@"time ================   1111");
            if (model) {
                if ([model.main_breaker.address_485 isEqualToString:self.address_485]) {
                    [weakself setDataToViewWithMainModel:model.main_breaker];
                }
                for (MainbreakerModel *mainBModel in model.branch_breakers) {
                    if ([mainBModel.address_485 isEqualToString:self.address_485]) {
                        [weakself setDataToViewWithMainModel:mainBModel];
                        
                    }
                }
                
            }
            
        }else
        {
            [CustomAlert alertVcWithMessage:errorMsg Vc:weakself.superview.viewController];
        }
    }];
    
    
    
    
}
- (void)refishData
{
    CZHWeakSelf(self)
    //0.创建队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    //1.创建GCD中的定时器
    /*
     第一个参数:创建source的类型 DISPATCH_SOURCE_TYPE_TIMER:定时器
     第二个参数:0
     第三个参数:0
     第四个参数:队列
     */
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //2.设置时间等
    /*
     第一个参数:定时器对象
     第二个参数:DISPATCH_TIME_NOW 表示从现在开始计时
     第三个参数:间隔时间 GCD里面的时间最小单位为 纳秒
     第四个参数:精准度(表示允许的误差,0表示绝对精准)
     */
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    //3.要调用的任务
    dispatch_source_set_event_handler(timer, ^{
        [weakself getData];
    });
    
    //4.开始执行
    dispatch_resume(timer);
    self.timer = timer;
    
}
- (void)setDataToViewWithMainModel:(MainbreakerModel *)mainModel
{
    
    
    DataItemModel *autoModel = [[DataItemModel alloc] init];
    DataItemModel *powerModel = [[DataItemModel alloc] init];
    DataItemModel *openModel = [[DataItemModel alloc] init];
    DataItemModel *kwhModel = [[DataItemModel alloc] init];
    DataItemModel *templateModel = [[DataItemModel alloc] init];
    DataItemModel *kModel = [[DataItemModel alloc] init];
    DataItemModel *aModel = [[DataItemModel alloc] init];

//    for (DataItemModel *models in mainModel.data_items) {
//        if ([models.protocol_key isEqualToString:@"ED000301"]) {
//            autoModel = models;
//        }
//        if ([models.protocol_key isEqualToString:@"00000000"]) {
//            powerModel = models;
//        }
//        if ([models.protocol_key isEqualToString:@"E1010201"]) {
//            openModel = models;
//        }
//        
//        
//        
//        if ([models.protocol_key isEqualToString:@"02030000"]) {
//            kwhModel = models;
//        }
//        if ([models.protocol_key isEqualToString:@"02800007"]) {
//            templateModel = models;
//        }
//        if ([models.protocol_key isEqualToString:@"02010100"]) {
//            kModel = models;
//        }
//        if ([models.protocol_key isEqualToString:@"02020100"]) {
//            aModel = models;
//        }
//        
//    }
//    DataItemModel *autoModel = mainModel.data_items[0];
//    DataItemModel *openModel = mainModel.data_items[1];
//    DataItemModel *powerModel = mainModel.data_items[2];
    
//    DataItemModel *kwhModel = mainModel.data_items[3];
//    DataItemModel *templateModel = mainModel.data_items[4];
//    DataItemModel *kModel = mainModel.data_items[5];
//    DataItemModel *aModel = mainModel.data_items[6];
    
    [_leftView switchOnWithIsnormal:YES isAnimal:[autoModel.converted_data isEqualToString:@"自动"]];
    [_rightView switchOnWithIsnormal:YES isAnimal:[openModel.converted_data isEqualToString:@"合闸"]];
    
    NSString *str = powerModel.converted_data ? [powerModel.converted_data componentsSeparatedByString:@","][0]: @"";
    NSString *powerString = [NSString stringWithFormat:@"%@  kWh",str];
    NSMutableAttributedString *powerStringM = [[NSMutableAttributedString alloc] initWithString:powerString];
    NSRange kRange = [powerString rangeOfString:@"kWh"];
    [powerStringM addAttribute:NSFontAttributeName value:PingFangSCMedium(24) range:NSMakeRange(0, powerStringM.length - 3)]; // 设置字体字号
    [powerStringM addAttribute:NSForegroundColorAttributeName value:ColorString(@"#1E2933") range:NSMakeRange(0, powerStringM.length - 3)];
    
    [powerStringM addAttribute:NSFontAttributeName value:PingFangSCLight(13) range:NSMakeRange(kRange.location, 3)]; // 设置字体字号
    [powerStringM addAttribute:NSForegroundColorAttributeName value:ColorString(@"#798794") range:NSMakeRange(kRange.location, 3)];
    
    
    _powerView.titleLab.attributedText = powerStringM;
    NSString *valueString = !kwhModel.converted_data?[NSString stringWithFormat:@"%@  kW",@""]: [NSString stringWithFormat:@"%@  kW",kwhModel.converted_data];
    NSMutableAttributedString *stringM = [[NSMutableAttributedString alloc] initWithString:valueString];
    NSRange range = [valueString rangeOfString:@"kW"];
    [stringM addAttribute:NSFontAttributeName value:PingFangSCMedium(24) range:NSMakeRange(0, stringM.length - 2)]; // 设置字体字号
    [stringM addAttribute:NSForegroundColorAttributeName value:ColorString(@"#1E2933") range:NSMakeRange(0, stringM.length - 2)];
    
    [stringM addAttribute:NSFontAttributeName value:PingFangSCLight(13) range:NSMakeRange(range.location, 2)]; // 设置字体字号
    [stringM addAttribute:NSForegroundColorAttributeName value:ColorString(@"#798794") range:NSMakeRange(range.location, 2)];
    
    
    _kwView.titleLab.attributedText = stringM;
    _kwhView.titleLab.text = kModel.converted_data;
    _templateView.titleLab.text = templateModel.converted_data;
    
    _currentView.titleLab.text = aModel.converted_data;
    
    //    [_alertView addData];
    
    
}

- (BranchbreakViewModel *)branchViewModel
{
    if (_branchViewModel == nil) {
        _branchViewModel = [[BranchbreakViewModel alloc]init];
    }
    return _branchViewModel;
}
- (void)dealloc
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

@end
