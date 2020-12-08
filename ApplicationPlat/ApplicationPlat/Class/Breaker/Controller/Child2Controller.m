//
//  Child2Controller.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/22.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "Child2Controller.h"

@interface Child2Controller ()
@property(nonatomic, strong)UIScrollView *scrollView;

@end

@implementation Child2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorString(@"#F4F6FC");
    self.navigationController.navigationBar.tintColor = ColorString(@"#2E3C4D");
    //    self.view.backgroundColor = [UIColor whiteColor];
    [self createScrollView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)createScrollView
{
    //    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    //    _scrollView.backgroundColor = [UIColor yellowColor];
    //    [self.view addSubview:self.scrollView];
    UILabel *detialLab = [UILabel z_labelWithText:@"暂未开放..." fontSize:12 color:[UIColor grayColor] CornerRadius:APH(35) / 2  backgroundColor:[UIColor clearColor]];
    detialLab.frame = CGRectMake(self.view.width /2 - 200 * WidthScale/2, (KScreenHeight - Height_NavBar -40) / 2-  APH(35), 200 * WidthScale, APH(35));
    detialLab.textAlignment = NSTextAlignmentCenter;
    detialLab.font = PingFangSCRegular(17);
    [self.view addSubview:detialLab];
}
@end
