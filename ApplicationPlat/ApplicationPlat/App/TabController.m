//
//  TabController.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/2.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "TabController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "EquipmentController.h"
#import "UserSetController.h"
#import "DeviceTypeView.h"
#import "ReportController.h"
#import "MainController.h"
#import "ReportFinishController.h"
#import "DeatilViewController.h"
@interface TabController ()<UITabBarControllerDelegate>

@end

@implementation TabController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpTabbarVC];
}

- (void)setUpTabbarVC
{
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    
    //    //添加子控制器
    
    MainController *oneVC = [[MainController alloc] init];
    //设置图片
    oneVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_map_default"];
    oneVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_map_default"];
    
    //设置提醒图标
    [self addChildViewController:oneVC];
    
    EquipmentController *eqVC = [[EquipmentController alloc] init];
    UINavigationController *eqNav = [[UINavigationController alloc] initWithRootViewController:eqVC];
    
    //设置标题
    eqNav.tabBarItem.image = [UIImage imageNamed:@"tabbar_stats_default"];
    eqNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_stats_focused"];
    
    //设置图片
    [self addChildViewController:eqNav];
    
    
    
    OneViewController *threeVC = [[OneViewController alloc] init];
    //设置图片
    threeVC.tabBarItem.image = [[UIImage imageNamed:@"tabbar_add"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    //设置选中状态下的图片
    threeVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_add"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    threeVC.tabBarItem.tag = 10000;
    
    [self addChildViewController:threeVC];
    
    OneViewController *fourVC = [[OneViewController alloc] init];
    //设置图片
    fourVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_notification_default"];
    //设置选中状态下的图片
    fourVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_notification_default"];
    
    [self addChildViewController:fourVC];
    
    
    UserSetController *userVC = [[UserSetController alloc] init];
    UINavigationController *userNav = [[UINavigationController alloc] initWithRootViewController:userVC];

    //设置图片
    userNav.tabBarItem.image = [UIImage imageNamed:@"tabbar_account_default"];
    //设置选中状态下的图片
    userNav.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_account_focused"];
    [self addChildViewController:userNav];
    [self setDelegate:self];
}
- (BOOL)tabBarController:(UITabBarController*)tabBarController shouldSelectViewController:(UIViewController*)viewController {
    if([tabBarController.viewControllers indexOfObject:viewController] == 2) {
        CGFloat h = 0;
        if (IS_IPHONE_8P) {
            h = 500 * HeightScale;
        }else{
            h = 450 * HeightScale;

        }
        DeviceTypeView *deviceTypeView = [[DeviceTypeView alloc]initWithFrame:CGRectMake(15 * WidthScale, 0, KScreenWidth - 30 * WidthScale, h)];
        FFToast *customDateViewToast = [[FFToast alloc]initCentreToastWithView:deviceTypeView autoDismiss:NO duration:3 enableDismissBtn:NO dismissBtnImage:[UIImage imageNamed:@"icon_close"]];
        
        [customDateViewToast show];
        
        deviceTypeView.determineBlock = ^{
            [customDateViewToast dismissCentreToast];

        };
        CZHWeakSelf(self)
        deviceTypeView.selectTypeBlock = ^(NSString * _Nonnull name) {
            [customDateViewToast dismissCentreToast];
            ReportController *vc = [[ReportController alloc]init];
            vc.typeName = name;
//                                    ReportFinishController *vc = [[ReportFinishController alloc]init];
//                                    vc.feedBackDic = @{@"isSuccess":@"1",@"iothub_id":@"111111111",@"msg":@""};
//
//                                        int x = arc4random() % 5;
//
//                                        if (x>1) {
//                                            vc.feedBackDic = @{@"isSuccess":@"1",@"iothub_id":@"111111111",@"msg":@""};
//
//
//
//
//                                        }else{
//                                            vc.feedBackDic = @{@"isSuccess":@"0",@"iothub_id":@"",@"msg":@"注册失败"};
//
//                                        }
            
            
//            DeatilViewController *vc = [[DeatilViewController alloc]init];
//
//            vc.title = [NSString stringWithFormat:@"母开关 %@",@"1233"];
//
//            JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)vc.categoryView;
//            titleCategoryView.titleColorGradientEnabled = YES;
//            titleCategoryView.titleColor = ColorString(@"#1F3F66");
//            titleCategoryView.titleSelectedColor = [UIColor whiteColor];
//            titleCategoryView.titleFont = PingFangSCSemibold(14);
//            titleCategoryView.titleLabelZoomScale = 1.1;
//
//            titleCategoryView.titleLabelZoomEnabled = YES;
//            JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
//            backgroundView.backgroundViewHeight = 40 * HeightScale;
//            backgroundView.backgroundViewWidthIncrement = 30 * WidthScale;
//            backgroundView.backgroundViewColor = ColorString(@"#0091FF");
//
//            backgroundView.backgroundViewCornerRadius = JXCategoryViewAutomaticDimension;
//            titleCategoryView.indicators = @[backgroundView];
//            vc.hidesBottomBarWhenPushed = YES;
//            vc.address_485 = @"0";
//            vc.iId = @"1";
//
//            vc.titles = @[NSLocalizedString(@"breakerDeitalStateTitle", nil),NSLocalizedString(@"breakerDeitalTimerTitle", nil),NSLocalizedString(@"breakerDeitalAttributeTitle", nil),NSLocalizedString(@"breakerDeitalAlarmsTitle", nil),NSLocalizedString(@"breakerDeitalOperationTitle", nil)];
//            [self.navigationController pushViewController:vc animated:YES];
            
            
            
            
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
            navi.modalPresentationStyle = UIModalPresentationFullScreen;
            [weakself presentViewController:navi animated:YES completion:nil];
            
        };
        
        
        return NO;
        
    }
    
    return YES;
    
}
@end
