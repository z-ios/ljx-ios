//
//  NewBreakerController.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/12.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "NewBreakerController.h"
#import "BreakSingleModel.h"
#import "MainbreakerModel.h"
#import "BranchbreakViewModel.h"
#import "BreakerHeaderView.h"
#import "NewBreakerListCell.h"
#import "BreakerDetailController.h"
#import "BindBreakerView.h"
#import "QRScanViewController.h"
#import "UIView+TYAlertView.h"
#import "HMScannerController.h"
#import "BreakerNumberController.h"
#import "DeatilViewController.h"
#import "JXCategoryView.h"
#import "PropertiesModel.h"
@interface NewBreakerController ()<UITableViewDelegate,UITableViewDataSource,MGSwipeTableCellDelegate,NewBreakerListCellDelagte,QRScanDelegate,BindBreakerViewDelagte>
@property(nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BranchbreakViewModel *branchViewModel;
@property (nonatomic, strong) MainbreakerModel *mainbreakerModel;
@property (nonatomic ,strong) dispatch_source_t timer;//  注意:此处应该使用强引用 strong
@property (nonatomic ,strong) BreakerHeaderView *headerView;
@property (nonatomic ,strong) BindBreakerView *bindView;
@property (nonatomic, copy) NSString *branchBreaker_mac;
@property (nonatomic, strong) UIButton *refreshBtn;
@property (nonatomic, copy)NSString *errorMsg;
@property (nonatomic, assign)NSInteger count;
@end

@implementation NewBreakerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorString(@"#F4F6FC");
    [self.navigationController.navigationBar setBackgroundImage:[UIImage coloreImage:ColorString(@"#F4F6FC")] forBarMetrics:(UIBarMetricsDefault)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    titleLabel.font = PingFangSCRegular(17);
    
    titleLabel.textColor = ColorString(@"#2E3C4D");
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.title;
    self.navigationItem.titleView = titleLabel;
    [self initNavi];
    [self createHeader];
    [self.view addSubview:self.tableView];
//    [self getDataWithAuto:NO];

    //    CZHWeakSelf(self)
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [weakself refishData];
    //    });
    [self addAlert];
    
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

      [center addObserver:self selector:@selector(backgroundOrForeground:) name:@"notification" object:nil];
    
    [self refishData];
}

- (void)backgroundOrForeground:(NSNotification *)noti{
    NSString *state = [noti.userInfo objectForKey:@"key"];
    if ([state isEqualToString:@"background"]) {
        if (_timer) {
            dispatch_source_cancel(_timer);
            
            _timer = nil;
        }
//        NSLog(@"关闭=============1");

    }else{
        [self refishData];
    }

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
//    NSLog(@"关闭=============1");
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
    
}
- (void)initNavi
{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [btn setImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* litem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn setTitle:@"     " forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = litem;
    
    UIButton *rBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rBtn setImage:[UIImage imageNamed:@"icon_refresh"] forState:UIControlStateNormal];
    [rBtn addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventTouchUpInside];
    self.refreshBtn = rBtn;
    UIBarButtonItem* ritem1 = [[UIBarButtonItem alloc] initWithCustomView:rBtn];
    
    UIButton *rBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rBtn1 setImage:[UIImage imageNamed:@"icon_add-d"] forState:UIControlStateNormal];
    [rBtn1 addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* ritem2 = [[UIBarButtonItem alloc] initWithCustomView:rBtn1];
    self.navigationItem.rightBarButtonItems = @[ritem2,ritem1];
}
- (void)backAction
{
    if ([_isDiss  isEqualToString:@"diss"]) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
#pragma mark -- 添加提示
- (void)addAlert
{
    FFToast *toast = [[FFToast alloc]initToastWithTitle:@"数据监控中" message:nil iconImage:nil];
    toast.duration = 2.f;
    toast.toastType = FFToastTypeDefault;
    toast.toastPosition = FFToastPositionBottomWithFillet;
    [toast show];
}
#pragma mark --  绑定
- (void)addAction
{
    CGFloat h = 0;
    if (IS_IPHONE_8P) {
        h = 450 * HeightScale;
    }else{
        h = 400 * HeightScale;
        
    }
    self.bindView = [[BindBreakerView alloc]initWithFrame:CGRectMake(15 * WidthScale, 0, KScreenWidth - 30 * WidthScale, h)];
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:_bindView preferredStyle:TYAlertControllerStyleAlert];
    
    [alertController setViewWillShowHandler:^(UIView *alertView) {
    }];
    
    [alertController setViewDidShowHandler:^(UIView *alertView) {
    }];
    
    [alertController setViewWillHideHandler:^(UIView *alertView) {
    }];
    
    [alertController setViewDidHideHandler:^(UIView *alertView) {
    }];
    
    [alertController setDismissComplete:^{
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    _bindView.delagate = self;
    _bindView.iId = _iId;
    NSMutableArray *numArray = [NSMutableArray array];
    for (int i = 0; i < self.dataArray.count; i++) {
        MainbreakerModel *mainModel = [self.dataArray objectAtIndex:i];
        if (i != 0) {
            [numArray addObject:mainModel.address_485];
        }
    }
    NSArray *sortedArray = [numArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2]; //升序
    }];
    if ([sortedArray.lastObject intValue]+1>=63) {
        _bindView.numText.textField.text = @"";

    }else{
        _bindView.numText.textField.text = [NSString stringWithFormat:@"%d", [sortedArray.lastObject intValue] + 1];

    }
    CZHWeakSelf(self)
    _bindView.determineBlock = ^{
        [weakself.bindView hideView];
        
        
    };
    _bindView.comBtnActionBlock = ^(NSString * _Nonnull errorMsg, BOOL success) {
        if (success) {
            
            [weakself.bindView hideView];
        }else{
            
            [CustomAlert alertVcWithMessage:errorMsg Vc:alertController];
        }
        
    };
    _bindView.dropCodeVc = ^(NSString * _Nonnull selectStr) {
        BreakerNumberController *vc = [[BreakerNumberController alloc]init];
        vc.selectArr = numArray;
        vc.selectStr = selectStr;
        vc.backBlock = ^(NSString * _Nonnull str) {
            weakself.bindView.numText.textField.text = str;
            
        };
        [weakself showDetailViewController:vc sender:nil];
    };

    _bindView.scanCodeVc = ^{
        
        
        HMScannerController *scanner = [HMScannerController scannerWithCardName:@"" avatar:nil completion:^(NSString *stringValue) {
            
            weakself.bindView.customText.textField.text = stringValue;
        }];
        [scanner setTitleColor:[UIColor whiteColor] tintColor:[UIColor greenColor]];
        
        [weakself showDetailViewController:scanner sender:nil];
        
    };
    
}
- (void)qrScanResult:(NSString *)result viewController:(QRScanViewController *)qrScanVC
{
    [qrScanVC dismissViewControllerAnimated:YES completion:nil];
    _bindView.customText.textField.text = result;
}
- (void)presentWithNum:(UIAlertController *)alert isDismiss:(BOOL)isDiss
{
    if (isDiss) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
}
- (void)refreshAction
{
    [self getDataWithAuto:YES];
    
}
- (void)animalRefishBtn
{
    _refreshBtn.userInteractionEnabled = NO;
    //旋转动画
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.7;
    rotationAnimation.cumulative = YES;
    //后台进前台动画重启
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.repeatCount = MAXFLOAT;
    [_refreshBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


- (void)createHeader
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 190 * HeightScale)];
    
    self.headerView = [[BreakerHeaderView alloc]initWithFrame:CGRectMake(20 * WidthScale, 20 * HeightScale, KScreenHeight - 40 * WidthScale, 160 * HeightScale)];
    headView.backgroundColor = ColorString(@"#F4F6FC");
    [headView addSubview:_headerView];
    _headerView.iId = _iId;
    self.tableView.tableHeaderView = headView;
}
#pragma mark -- 刷新数据
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
        // 测试
//        NSLog(@"123456987---------------%ld", (long)weakself.count);
        weakself.count++;
        [weakself getDataWithAuto:NO];
    });
    
    //4.开始执行
    dispatch_resume(timer);
    self.timer = timer;
    
    
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - Height_NavBar ) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = ColorString(@"#F4F6FC");
        if (IS_IPHONE_8 || IS_IPHONE_8P) {
            _tableView.rowHeight = 340 * HeightScale;
            
        }else{
            _tableView.rowHeight = 320 * HeightScale;
            
        }
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11,*)) {
            
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        }
        
    }
    return _tableView;;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewBreakerListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[NewBreakerListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.delegate = self;
  
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.node_Id = self.title;
    cell.iId = self.iId;
    cell.delea = self;
    cell.mainModel = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)selecCellWithModel:(MainbreakerModel *)mainModel
{
        DeatilViewController *vc = [[DeatilViewController alloc]init];
        if ([mainModel.address_485 intValue] == 0) {
            vc.title = [NSString stringWithFormat:@"母开关 %@",mainModel.address_mac];
    
        }else{
            vc.title = [NSString stringWithFormat:@"子开关 %@",mainModel.address_mac];
    
        }
        JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)vc.categoryView;
        titleCategoryView.titleColorGradientEnabled = YES;
        titleCategoryView.titleColor = ColorString(@"#1F3F66");
        titleCategoryView.titleSelectedColor = [UIColor whiteColor];
        titleCategoryView.titleFont = PingFangSCSemibold(14);
        titleCategoryView.titleLabelZoomScale = 1.1;
    
        titleCategoryView.titleLabelZoomEnabled = YES;
        JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
        backgroundView.backgroundViewHeight = 40 * HeightScale;
        backgroundView.backgroundViewWidthIncrement = 30 * WidthScale;
        backgroundView.backgroundViewColor = ColorString(@"#0091FF");
    
        backgroundView.backgroundViewCornerRadius = JXCategoryViewAutomaticDimension;
        titleCategoryView.indicators = @[backgroundView];
        vc.hidesBottomBarWhenPushed = YES;
        vc.address_485 = mainModel.address_485;
        vc.iId = self.iId;
    
        vc.titles = @[NSLocalizedString(@"breakerDeitalStateTitle", nil),NSLocalizedString(@"breakerDeitalTimerTitle", nil),NSLocalizedString(@"breakerDeitalAttributeTitle", nil),NSLocalizedString(@"breakerDeitalAlarmsTitle", nil),NSLocalizedString(@"breakerDeitalOperationTitle", nil)];
        [self.navigationController pushViewController:vc animated:YES];
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    DeatilViewController *vc = [[DeatilViewController alloc]init];
//    MainbreakerModel *mainModel = [self.dataArray objectAtIndex:indexPath.row];
//    if ([mainModel.address_485 intValue] == 0) {
//        vc.title = [NSString stringWithFormat:@"母开关 %@",mainModel.address_mac];
//
//    }else{
//        vc.title = [NSString stringWithFormat:@"子开关 %@",mainModel.address_mac];
//
//    }
//    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)vc.categoryView;
//    titleCategoryView.titleColorGradientEnabled = YES;
//    titleCategoryView.titleColor = ColorString(@"#1F3F66");
//    titleCategoryView.titleSelectedColor = [UIColor whiteColor];
//    titleCategoryView.titleFont = PingFangSCSemibold(14);
//    titleCategoryView.titleLabelZoomScale = 1.1;
//
//    titleCategoryView.titleLabelZoomEnabled = YES;
//    JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
//    backgroundView.backgroundViewHeight = 40 * HeightScale;
//    backgroundView.backgroundViewWidthIncrement = 30 * WidthScale;
//    backgroundView.backgroundViewColor = ColorString(@"#0091FF");
//
//    backgroundView.backgroundViewCornerRadius = JXCategoryViewAutomaticDimension;
//    titleCategoryView.indicators = @[backgroundView];
//    vc.hidesBottomBarWhenPushed = YES;
//    vc.address_485 = mainModel.address_485;
//    vc.iId = self.iId;
//
//    vc.titles = @[NSLocalizedString(@"breakerDeitalStateTitle", nil),NSLocalizedString(@"breakerDeitalTimerTitle", nil),NSLocalizedString(@"breakerDeitalAttributeTitle", nil),NSLocalizedString(@"breakerDeitalAlarmsTitle", nil),NSLocalizedString(@"breakerDeitalOperationTitle", nil)];
//    [self.navigationController pushViewController:vc animated:YES];
//
//
    
    
    
    
}
#pragma mark Swipe Delegate

-(NSArray*) swipeTableCell:(MGSwipeTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings
{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    swipeSettings.transition = MGSwipeTransitionBorder;
    MainbreakerModel *mainModel = [self.dataArray objectAtIndex:indexPath.row];
    
    if (direction == MGSwipeDirectionRightToLeft){
        
        if ([mainModel.address_485 intValue] == 0) {
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"母断路器不可解绑" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *comAc = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertVc addAction:comAc];
            [self presentViewController:alertVc animated:YES completion:nil];
        }else{
            CZHWeakSelf(self)
            MGSwipeButton * del = [MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"icon_unlink"] backgroundColor:ColorString(@"#FE4F4C") insets:UIEdgeInsetsMake(0, 0, 0, 0) callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
                [weakself unbindBreakerWithIndexPath:indexPath];
                return YES;
            }];
//            CGRect rect = CGRectMake(0, 0, 80 * WidthScale, 300 * HeightScale);
//            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(12, 12)];
//
//            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//
//            maskLayer.frame = rect;
//
//            maskLayer.path = maskPath.CGPath;
//
//            del.layer.mask = maskLayer;
//            del.layer.masksToBounds = YES;
            del.buttonWidth = 80 * WidthScale;
            return @[del];
            
        }
        
    }
    
    
    
    
    return nil;
    
}
#pragma mark -- 解绑
- (void)unbindBreakerWithIndexPath:(NSIndexPath *)indexPath
{
    MainbreakerModel *mainModel = [self.dataArray objectAtIndex:indexPath.row];
    
    CZHWeakSelf(self)
    NSString *num =  mainModel.address_485_pad;
    
    NSString *str = [NSString stringWithFormat:@"确定将“子开关%@”解绑吗？",num ];
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setCancelBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *comAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setDefineBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
      
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            NSDictionary *device = @{@"id": weakself.iId};
            NSDictionary *operator = @{@"id":Center.shared.userID};
            NSDictionary *payload = @{@"branchBreaker_mac":mainModel.address_mac,@"branchBreaker_485":mainModel.address_485};
            params[@"device"] = device;
            params[@"operator"] = operator;
            params[@"payload"] = payload;
            [weakself.branchViewModel deleteChildBreakerWithParams:params Completion:^(BOOL success, NSString * _Nonnull errorMsg) {
                if (success) {
                    //                    [weakself.dataArray removeObjectAtIndex:indexPath.row];
                    //                    [weakself.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                }else{
                    [CustomAlert alertVcWithMessage:errorMsg Vc:weakself];
                }
            }];
            
        
        
        
    }];
    [alertVc addAction:cancleAc];
    [alertVc addAction:comAc];
    [self presentViewController:alertVc animated:YES completion:nil];
}
-(void) swipeTableCellWillBeginSwiping:(nonnull MGSwipeTableCell *) cell
{
//    cell.swipeContentView.layer.cornerRadius = 0;
//    cell.swipeContentView.layer.masksToBounds = YES;
}
-(void) swipeTableCellWillEndSwiping:(nonnull MGSwipeTableCell *) cell
{
//    cell.swipeContentView.layer.cornerRadius = 12;
//    cell.swipeContentView.layer.masksToBounds = NO;
    
}
#pragma mark 提示
- (void)presentWithAlert:(UIAlertController *)alert isDismiss:(BOOL)isDiss
{
    if (isDiss) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
}

#pragma mark 获取设备数据
- (void)getDataWithAuto:(BOOL )isAuto
{
    [self.refreshBtn setImage:[UIImage imageNamed:@"icon_refresh"] forState:UIControlStateNormal];
    [self animalRefishBtn];
    CZHWeakSelf(self)
    [self.branchViewModel breakerWithParams:self.iId Completion:^(BOOL success, BreakSingleModel * _Nonnull model, NSString * _Nonnull errorMsg) {
        weakself.refreshBtn.userInteractionEnabled = YES;
        dispatch_time_t timer = dispatch_time(DISPATCH_TIME_NOW, 500 * NSEC_PER_MSEC);
        dispatch_after(timer, dispatch_get_main_queue(), ^(void){
            [weakself.refreshBtn.layer removeAnimationForKey:@"rotationAnimation"];
            if (!success) {
                [weakself.refreshBtn setImage:[UIImage imageNamed:@"error"] forState:UIControlStateNormal];

            }else{
                [weakself.refreshBtn setImage:[UIImage imageNamed:@"icon_refresh"] forState:UIControlStateNormal];

            }
        });
        
        
        if (success) {
//            weakself.errorMsg = @"";

            NSMutableArray *newArray = [NSMutableArray array];
            if (model) {
                              
//                weakself.headerView.waftStr = [NSString stringWithFormat:@"%@%@", model.gateway.data_properties.signal.parsed_data,model.gateway.data_properties.signal.unit];
                weakself.headerView.signal = model.gateway.data_properties.signal;
                weakself.headerView.onLine = model.gateway.state[@"online_state"];
                weakself.branchBreaker_mac = model.gateway.node_Id;

                // 未完成
                weakself.headerView.cycleStr = model.gateway.period;
                weakself.mainbreakerModel = model.main_breaker;
                if (model.main_breaker) {
//                      [weakself testWidthMainModel:model.main_breaker];
                    [newArray addObject:model.main_breaker];
                }
                [newArray addObjectsFromArray:model.branch_breakers];
                
                
            }
            
            
            //
            if (self.dataArray.count == 0) {
                [self.dataArray addObjectsFromArray:newArray];
                [weakself.tableView reloadData];
            }else{
                NSArray *hsitory = weakself.dataArray;
                for (int j = 0; j < hsitory.count; j++) {
                    BOOL isContant = false;
                    MainbreakerModel *dataModel = [hsitory objectAtIndex:j];
                    for (int i = 0; i < newArray.count; i++) {
                        MainbreakerModel *mianModel = [newArray objectAtIndex:i];
                        if ([dataModel.address_485 isEqualToString: mianModel.address_485]) {
                            BOOL isChange = [weakself judageHistoryModelWithModel:dataModel newModel:mianModel];
                            if (isChange) {
                                
                                [weakself updateDownloadedActions:mianModel index:j];
                            }
                            isContant = true;
                        }
                        
                    }
                    if (!isContant) {
                        [weakself deleteDownloadedActions:dataModel index:j];
                    }
                    
                }
                
                for (int i = 0; i < newArray.count; i++) {
                    BOOL isContant = false;
                    MainbreakerModel *mianModel = [newArray objectAtIndex:i];
                    for (int j = 0; j < weakself.dataArray.count; j++) {
                        MainbreakerModel *dataModel = [hsitory objectAtIndex:j];
                        if ([dataModel.address_485 isEqualToString: mianModel.address_485]) {
                            BOOL isChange = [weakself judageHistoryModelWithModel:dataModel newModel:mianModel];
                            if (isChange) {
                                [weakself updateDownloadedActions:mianModel index:j];
                            }
                            isContant = true;
                        }
                    }
                    if (!isContant) {
                        [weakself insertDownloadedActions:mianModel];
                    }
                }
                
                
            }
            
            
            
            
            
            
            if (isAuto) {
                
                FFToast *toast = [[FFToast alloc]initToastWithTitle:@"已更新为最新数据" message:nil iconImage:nil];
                toast.duration = 3.f;
                toast.toastType = FFToastTypeDefault;
                toast.toastPosition = FFToastPositionBottomWithFillet;
                [toast show];
            }
        }else
        {
//            if (![weakself.errorMsg isEqualToString:errorMsg]) {
//                self.errorMsg = errorMsg;
//
//                [CustomAlert alertVcWithMessage:errorMsg Vc:self];
//            }
        }
        
        //        [self.tableView reloadData];
    }];
    
    
    
    
}

#pragma makr --  要加入的数据源
-(void)insertDownloadedActions:(MainbreakerModel *)mainModel
{
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    [self.dataArray addObject:mainModel];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0];
    [indexPaths addObject: indexPath];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
    //    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:(UITableViewScrollPositionBottom) animated:YES];
}


#pragma makr -- 更新数据源
-(void)updateDownloadedActions:(MainbreakerModel *)mainModel index:(NSInteger)index
{
    [self.dataArray replaceObjectAtIndex:index withObject:mainModel];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    //    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:indexPath.section];
    //    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma makr -- 删除数据源
-(void)deleteDownloadedActions:(MainbreakerModel *)mainModel index:(NSInteger)index
{
    [self.dataArray removeObject:mainModel];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma makr -- 判断是否相同

- (BOOL)judageHistoryModelWithModel:(MainbreakerModel *)mainModel newModel:(MainbreakerModel *)newModel
{

    PropertiesModel *hisModel = mainModel.data_properties;
    PropertiesModel *newProModel = newModel.data_properties;
//    [hisModel yy_modelIsEqual:newProModel];

    BOOL isChanage = [hisModel.work_mode.parsed_data isEqualToString:newProModel.work_mode.parsed_data] && [hisModel.power.parsed_data isEqualToString:newProModel.power.parsed_data]&& [hisModel.temperature.parsed_data isEqualToString:newProModel.temperature.parsed_data]
    && [hisModel.electric_current.parsed_data isEqualToString:newProModel.electric_current.parsed_data]&&[hisModel.voltage.parsed_data isEqualToString:newProModel.voltage.parsed_data]&&[hisModel.electric_quantity.parsed_data isEqualToString:newProModel.electric_quantity.parsed_data]&& [hisModel.open_close.parsed_data isEqualToString:newProModel.open_close.parsed_data];
    
    return  !isChanage;
//    return  [hisModel yy_modelIsEqual:newProModel];
    
    
}
#pragma mark -- 测试数据源（可删除）
- (void)testWidthMainModel:(MainbreakerModel *)mainModel
{

    
//    for (int i = 0; i < [mainModel.data_properties getAllProperties].count; i++) {
//        NSString *st = [mainModel.data_properties getAllProperties][i];
//        PropertyModel *model = [mainModel.data_properties yy_modelToJSONObject];
//        int randomNumber = arc4random()%100+1;
//        NSString *str = [NSString stringWithFormat:@"%d", randomNumber];
//        NSLog(@"%@-------%@ =================  %@",model.protocol_desc,model.protocol_key,str);
//        model.parsed_data = str;
//    }
   
//    PropertyModel *model = mainModel.data_properties.open_close;
    int randomNumber = arc4random()%100+1;
    int randomNumber1 = arc4random()%100+1;

//    if(randomNumber >50){
//        model.parsed_data = @"跳闸";
//        NSLog(@"%@ =================  %@",model.protocol_key,@"跳闸");
//
//    }else{
//        model.parsed_data = @"合闸";
//        NSLog(@"%@ =================  %@",model.protocol_key,@"合闸");
//
//    }
//    PropertyModel *model1 = mainModel.data_properties.work_mode;
//
//
//    if(randomNumber >50){
//        model1.parsed_data = @"手动";
//        NSLog(@"%@ =================  %@",model1.protocol_desc,@"手动");
//
//    }else{
//        model1.parsed_data = @"自动";
//        NSLog(@"%@ =================  %@",model1.protocol_desc,@"自动");
//    }
      NSString *str = [NSString stringWithFormat:@"%d", randomNumber];
    NSString *str1 = [NSString stringWithFormat:@"%d", randomNumber1];

//
//    PropertyModel *model2 = mainModel.data_properties.electric_quantity;
//    model2.parsed_data = str;
//    NSLog(@"%@ =================  %@",model2.protocol_desc,model2.parsed_data);

//    PropertyModel *model3 = mainModel.data_properties.power;
//    model3.parsed_data = str;
//    NSLog(@"%@ =================  %@",model3.protocol_desc,model3.parsed_data);
//    PropertyModel *model4 = mainModel.data_properties.voltage;
//    model4.parsed_data = str1;
//    NSLog(@"%@ =================  %@",model4.protocol_desc,model4.parsed_data);
    
    PropertyModel *model3 = mainModel.data_properties.electric_current;
    model3.parsed_data = str;
    NSLog(@"%@ =================  %@",model3.protocol_desc,model3.parsed_data);
    PropertyModel *model4 = mainModel.data_properties.temperature;
    model4.parsed_data = str1;
    NSLog(@"%@ =================  %@",model4.protocol_desc,model4.parsed_data);
    
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;;
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
