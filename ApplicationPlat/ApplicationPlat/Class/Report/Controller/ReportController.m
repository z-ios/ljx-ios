//
//  ReportController.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/2.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "ReportController.h"
#import "ReportView.h"
@interface ReportController ()

@end

@implementation ReportController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorString(@"#F4F6FC");
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
    [self.navigationController.navigationBar setBarTintColor:ColorString(@"#F4F6FC")];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage coloreImage:ColorString(@"#F4F6FC")] forBarMetrics:(UIBarMetricsDefault)];

}

- (void)initNavi
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = YES;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [btn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* litem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn setTitle:@"     " forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = litem;
    

}
- (void)backAction
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"是否退出注册？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setCancelBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *comAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setDefineBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];

  
    }];
    [alertVc addAction:cancleAc];
    [alertVc addAction:comAc];
    [self presentViewController:alertVc animated:YES completion:^{
        
    }];
    
    
}
- (void)createUI
{
    ReportView *reportView = [[ReportView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - Height_NavBar)];
    reportView.typeName = _typeName;
    reportView.reportVc = self;
    [self.view addSubview:reportView];
}
@end
