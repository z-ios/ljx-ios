//
//  BreakerChildController.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/22.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "BreakerChildController.h"
#import "TopView.h"
#import "BoardView.h"
#import "SignalView.h"
#import "AlertListView.h"
#import "DataItemModel.h"
#import "BranchbreakViewModel.h"
#import "BreakerAlertView.h"
@interface BreakerChildController ()<TopViewCellDelagte>
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
@property (nonatomic, strong) UIActivityIndicatorView * activityIndicator;
@property (nonatomic, strong) UIButton *imageV;
@property (nonatomic, copy)NSString *errorMsg;

@end

@implementation BreakerChildController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorString(@"#F4F6FC");
    //    self.navigationController.navigationBar.tintColor = ColorString(@"#2E3C4D");
    [self createScrollView];
//    [self getData];
    [self refishData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
      //注册、接收通知

      [center addObserver:self selector:@selector(backgroundOrForeground:) name:@"notificationChild" object:nil];
}

- (void)backgroundOrForeground:(NSNotification *)noti{
    NSString *state = [noti.userInfo objectForKey:@"key"];
    if ([state isEqualToString:@"background"]) {
        if (_timer) {
            dispatch_source_cancel(_timer);
            
            _timer = nil;
        }
        NSLog(@"关闭=============1");

    }else{
        [self refishData];
    }

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

- (void)createScrollView
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - Height_NavBar -40 )];
    _scrollView.backgroundColor = ColorString(@"#F4F6FC");
    [self.view addSubview:self.scrollView];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    [_scrollView addSubview:self.activityIndicator];
    _activityIndicator.hidden = YES;
    //设置小菊花的frame
    self.activityIndicator.frame = CGRectMake(KScreenWidth-60 * WidthScale, 10 * HeightScale,  30 * WidthScale,  30 * HeightScale);
    //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES的时候，刚进入页面不会显示
    self.activityIndicator.hidesWhenStopped = YES;
    
    self.imageV = [UIButton buttonWithType:UIButtonTypeCustom];
    self.imageV.frame = CGRectMake(KScreenWidth - 50 * WidthScale, 10 * HeightScale,  30 * WidthScale,  30 * HeightScale);
    self.imageV.hidden = YES;
    [_imageV setImage:[UIImage imageNamed:@"error"] forState:UIControlStateNormal];
    [_scrollView addSubview:self.imageV];
    
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
  
    _powerView.detialLab.text = NSLocalizedString(@"breakerDeitalElectricity", nil);
    
    //    powerView.detialLab.text = @"实时电量       kWh";
    
    [_powerView.imageBtn  setImage:[UIImage imageNamed:@"icon_electric"] forState:UIControlStateNormal];
    [_scrollView addSubview:_powerView];
    
    self.kwView = [[BoardView alloc]initWithFrame:CGRectMake(20 * WidthScale,_powerView.bottom + 16 * HeightScale, KScreenWidth - 40 * WidthScale, 100 * HeightScale) typeStr:@"kw"];
    _kwView.backgroundColor = [UIColor whiteColor];
//    _kwView.titleLab.text = @"34.12";
 
    _kwView.detialLab.text = NSLocalizedString(@"breakerDeitalPower", nil);
    //    kwView.imageBtn.backgroundColor = ColorString(@"#44D7B6");
    [_kwView.imageBtn  setImage:[UIImage imageNamed:@"icon_power"] forState:UIControlStateNormal];
    
    [_scrollView addSubview:_kwView];

    
    self.kwhView = [[SignalView alloc]initWithFrame:CGRectMake(20 * WidthScale, _kwView.bottom + 16 * HeightScale, (KScreenWidth - 60 * WidthScale) / 3, 120 * HeightScale) typeStr:@"kwh"];
    _kwhView.backgroundColor = [UIColor whiteColor];
    _kwhView.detialLab.text = NSLocalizedString(@"breakerDeitalVoltage", nil);
    [_kwhView.imageBtn setImage:[UIImage imageNamed:@"icon_voltage"] forState:UIControlStateNormal];
    _kwhView.unitLab.text = @"V";
    [_scrollView addSubview:_kwhView];
    
    self.templateView = [[SignalView alloc]initWithFrame:CGRectMake(_kwhView.right+10 * WidthScale, _kwView.bottom + 16 * HeightScale, (KScreenWidth - 60 * WidthScale) / 3, 120 * HeightScale) typeStr:@"template"];
    _templateView.backgroundColor = [UIColor whiteColor];
    _templateView.detialLab.text = NSLocalizedString(@"breakerDeitalTemperature", nil);
    [_templateView.imageBtn setImage:[UIImage imageNamed:@"icon_tempreture"] forState:UIControlStateNormal];
    _templateView.unitLab.text = @"℃";
    [_scrollView addSubview:_templateView];
    
    
    
    self.currentView = [[SignalView alloc]initWithFrame:CGRectMake(_templateView.right+10 * WidthScale, _kwView.bottom + 16 * HeightScale, (KScreenWidth - 60 * WidthScale) / 3, 120 * HeightScale) typeStr:@"current"];
    _currentView.backgroundColor = [UIColor whiteColor];
//    _currentView.titleLab.text = @"16.39";
    _currentView.detialLab.text = NSLocalizedString(@"breakerDeitalCurrent", nil);
    [_currentView.imageBtn setImage:[UIImage imageNamed:@"icon_current"] forState:UIControlStateNormal];
    
    _currentView.unitLab.text = @"A";
    [_scrollView addSubview:_currentView];

    
    
    self.bAlertView = [[BreakerAlertView alloc]initWithFrame:CGRectMake(20 * WidthScale, _currentView.bottom + 16 * HeightScale, KScreenWidth - 40 * WidthScale, 200 * HeightScale)];
    _bAlertView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_bAlertView];
    _scrollView.contentSize = CGSizeMake(0, _bAlertView.bottom+ 50 * HeightScale);


    
    
    
}
#pragma mark cell Delegate
- (void)presentTopViewWithAlert:(UIAlertController *)alert isDismiss:(BOOL)isDiss
{
    if (isDiss) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
}
- (void)getData
{

    CZHWeakSelf(self)
    [self.branchViewModel breakerWithParams:self.iId Completion:^(BOOL success, BreakSingleModel * _Nonnull model, NSString * _Nonnull errorMsg) {

        

        
        
        if (success) {
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


            
        }
    }];
    
    
    
    
}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
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
//        // 测试
//        NSLog(@"111111111111111");
        [weakself getData];
    });
    
    //4.开始执行
    dispatch_resume(timer);
    self.timer = timer;
    
}
- (void)setDataToViewWithMainModel:(MainbreakerModel *)mainModel
{
    PropertiesModel *proModel = mainModel.data_properties;
    
    PropertyModel *autoModel = proModel.work_mode;
    PropertyModel *powerModel = proModel.electric_quantity;
    PropertyModel *openModel = proModel.open_close;
    PropertyModel *kwhModel = proModel.power;
    PropertyModel *templateModel = proModel.temperature;
    PropertyModel *kModel = proModel.voltage;
    PropertyModel *aModel = proModel.electric_current;
    
    NSString *openStr = [openModel.raw_data substringToIndex:2];
    [_leftView switchOnWithIsnormal:YES isAnimal:![autoModel.parsed_data isEqualToString:@"M"]];
    [_rightView switchOnWithIsnormal:YES isAnimal:![openStr isEqualToString:@"01"]];
    
    NSString *str = powerModel.parsed_data ? [powerModel.parsed_data componentsSeparatedByString:@","][0]: @"0.00";
    NSString *powerString = [NSString stringWithFormat:@"%@  kWh",str];
    NSMutableAttributedString *powerStringM = [[NSMutableAttributedString alloc] initWithString:powerString];
    NSRange kRange = [powerString rangeOfString:@"kWh"];
    [powerStringM addAttribute:NSFontAttributeName value:PingFangSCMedium(24) range:NSMakeRange(0, powerStringM.length - 3)]; // 设置字体字号
    [powerStringM addAttribute:NSForegroundColorAttributeName value:ColorString(@"#1E2933") range:NSMakeRange(0, powerStringM.length - 3)];
    
    [powerStringM addAttribute:NSFontAttributeName value:PingFangSCLight(13) range:NSMakeRange(kRange.location, 3)]; // 设置字体字号
    [powerStringM addAttribute:NSForegroundColorAttributeName value:ColorString(@"#798794") range:NSMakeRange(kRange.location, 3)];
    
    
    _powerView.titleLab.attributedText = powerStringM;
    NSString *valueString = !kwhModel.parsed_data?[NSString stringWithFormat:@"%@  kW",@"0.00"]: [NSString stringWithFormat:@"%@  kW",kwhModel.parsed_data];
    NSMutableAttributedString *stringM = [[NSMutableAttributedString alloc] initWithString:valueString];
    NSRange range = [valueString rangeOfString:@"kW"];
    [stringM addAttribute:NSFontAttributeName value:PingFangSCMedium(24) range:NSMakeRange(0, stringM.length - 2)]; // 设置字体字号
    [stringM addAttribute:NSForegroundColorAttributeName value:ColorString(@"#1E2933") range:NSMakeRange(0, stringM.length - 2)];
    
    [stringM addAttribute:NSFontAttributeName value:PingFangSCLight(13) range:NSMakeRange(range.location, 2)]; // 设置字体字号
    [stringM addAttribute:NSForegroundColorAttributeName value:ColorString(@"#798794") range:NSMakeRange(range.location, 2)];
    
    
    _kwView.titleLab.attributedText = stringM;
    _kwhView.titleLab.text = kModel.parsed_data?kModel.parsed_data:@"0.00";
    _templateView.titleLab.text = templateModel.parsed_data?templateModel.parsed_data:@"0.00";
    
    _currentView.titleLab.text = aModel.parsed_data?aModel.parsed_data:@"0.00";
    
    //    [_alertView addData];
    
    
}


#pragma mark -- 测试数据源（可删除）
- (void)testWidthMainModel:(MainbreakerModel *)mainModel
{

    
    int randomNumber = arc4random()%100+1;
    int randomNumber1 = arc4random()%100+1;
    int randomNumber2 = arc4random()%100+1;
    int randomNumber3 = arc4random()%100+1;
    int randomNumber4 = arc4random()%100+1;
  
    NSString *str = [NSString stringWithFormat:@"%d", randomNumber];
    NSString *str1 = [NSString stringWithFormat:@"%d", randomNumber1];
    NSString *str2 = [NSString stringWithFormat:@"%d", randomNumber2];
    NSString *str3 = [NSString stringWithFormat:@"%d", randomNumber3];
    NSString *str4 = [NSString stringWithFormat:@"%d", randomNumber4];
    //
    PropertyModel *model2 = mainModel.data_properties.electric_quantity;
    model2.parsed_data = str;
    NSLog(@"%@ =================  %@",model2.protocol_desc,model2.parsed_data);
    
    PropertyModel *model3 = mainModel.data_properties.power;
    model3.parsed_data = str1;
    NSLog(@"%@ =================  %@",model3.protocol_desc,model3.parsed_data);
    PropertyModel *model4 = mainModel.data_properties.voltage;
    model4.parsed_data = str2;
    NSLog(@"%@ =================  %@",model4.protocol_desc,model4.parsed_data);
    
    PropertyModel *model5 = mainModel.data_properties.electric_current;
    model5.parsed_data = str3;
    NSLog(@"%@ =================  %@",model5.protocol_desc,model5.parsed_data);
    PropertyModel *model6 = mainModel.data_properties.temperature;
    model6.parsed_data = str4;
    NSLog(@"%@ =================  %@",model6.protocol_desc,model6.parsed_data);
    
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
