//
//  ReportFinishController.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/6.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "ReportFinishController.h"
#import "RegisterAlertView.h"
#import "NewBreakerController.h"
@interface ReportFinishController ()<RegisterAlertViewDelegate>
@property(nonatomic, strong) RegisterAlertView *registerAlertView;
@end

@implementation ReportFinishController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    titleLabel.font = PingFangSCMedium(19);
    
    titleLabel.textColor = ColorString(@"#121212");
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"安装注册";
    self.navigationItem.titleView = titleLabel;
    [self initNavi];
    [self createUI];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage coloreImage:[UIColor whiteColor]] forBarMetrics:(UIBarMetricsDefault)];

}

- (void)initNavi
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = YES;
//
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [btn setImage:nil forState:UIControlStateNormal];
    UIBarButtonItem* litem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn setTitle:@"     " forState:UIControlStateNormal];

    self.navigationItem.leftBarButtonItem = litem;
    

}
- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)createUI
{
    self.registerAlertView = [[RegisterAlertView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - Height_NavBar)];
    _registerAlertView.feedBackDic = _feedBackDic;
    _registerAlertView.delagte = self;
    [self.view addSubview:_registerAlertView];
    
    
}
- (void)successWithIothub_id:(NSString *)iothub_id iId:(NSString *)iId nodId:(nonnull NSString *)nodId
{
    NewBreakerController *vc = [[NewBreakerController alloc]init];
    
    vc.title = nodId;
    vc.iId = iId;
    vc.isDiss = @"diss";
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}
- (void)failFinishBackPage
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.registerAlertView = nil;
}

@end
