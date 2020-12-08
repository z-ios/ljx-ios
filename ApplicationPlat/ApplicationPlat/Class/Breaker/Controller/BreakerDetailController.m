//
//  BreakerDetailController.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/22.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "BreakerDetailController.h"
#import "BreakerChildController.h"
#import "Child2Controller.h"
@interface BreakerDetailController ()
/// 当有多个子控制器时，或者子控制器的个数不能由接口驱动时，此属性用来存储记录控制器
@property (nonatomic, strong) NSMutableDictionary *modelDictionary;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation BreakerDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorString(@"#F4F6FC");
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    titleLabel.font = PingFangSCRegular(17);
    
    titleLabel.textColor = ColorString(@"#2E3C4D");
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.title;
    self.navigationItem.titleView = titleLabel;
    [self initNavi];
    self.modelDictionary = [NSMutableDictionary dictionary];
    self.view.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    // loadData
  
}

// 服务器接口返回有哪些标题，以及标题对应的模型
- (void)loadData {
    
    // 进行网络请求，获取模型（模型里一般包括的是标题和Id值）
    // 为dataArray赋值 _dataArray = jsonDataArray;
    _dataArray = @[NSLocalizedString(@"breakerDeitalStateTitle", nil),NSLocalizedString(@"breakerDeitalTimerTitle", nil),NSLocalizedString(@"breakerDeitalAttributeTitle", nil),NSLocalizedString(@"breakerDeitalAlarmsTitle", nil),NSLocalizedString(@"breakerDeitalOperationTitle", nil)].mutableCopy;
    // 如果指定直接跳转到某个控制器，那么指定currentIndex
    self.currentIndex = 0;
    // 刷新PageController
    [self reloadData];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:ColorString(@"#F4F6FC")];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage coloreImage:ColorString(@"#F4F6FC")] forBarMetrics:(UIBarMetricsDefault)];

    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   
}
- (void)initNavi
{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [btn setImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* litem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn setTitle:@"     " forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = litem;
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)addAction
{
    
    
}
#pragma mark - ScrollPageViewControllerProtocol

- (NSArray *)arrayForControllerTitles {
    return _dataArray;
}

- (UIViewController *)viewcontrollerWithIndex:(NSInteger)index {
    if (index <0 || index > self.arrayForControllerTitles.count) return nil;
    id model = _dataArray[index];
    NSString *key = [NSString stringWithFormat:@"%@",model];
    if (index == 0) {
        
        BreakerChildController *vc = self.modelDictionary[key];
        if (!vc) {
            vc = [BreakerChildController new];
            vc.iId = self.iId;
            vc.address_485 = self.address_485;
            self.modelDictionary[key] = vc;
            
        }
        return vc;
    }else{
        Child2Controller *vc = self.modelDictionary[key];
        vc.hidesBottomBarWhenPushed = YES;
        if (!vc) {
            vc = [Child2Controller new];
            self.modelDictionary[key] = vc;
            
        }
        return vc;
    }
    
}
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
