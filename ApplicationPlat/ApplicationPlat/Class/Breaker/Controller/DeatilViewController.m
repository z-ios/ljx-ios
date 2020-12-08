//
//  DeatilViewController.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/27.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "DeatilViewController.h"
#import "EScrollPageView.h"
#import "ENestScrollPageView.h"
#import "PageItem1.h"
#import "TitleViewController.h"
#import "JXCategoryTitleView.h"
#import "JXCategoryIndicatorBackgroundView.h"
#import "JXCategoryTitleView.h"
#import "BreakerChildController.h"
#import "Child2Controller.h"
@interface DeatilViewController ()<UIScrollViewDelegate>
@property(nonatomic,retain)EScrollPageView *pageView;
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation DeatilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = ColorString(@"#F4F6FC");
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    titleLabel.font = PingFangSCRegular(17);
    
    titleLabel.textColor = ColorString(@"#2E3C4D");
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.title;
    self.navigationItem.titleView = titleLabel;
   

    NSUInteger count = [self preferredListViewCount];
    CGFloat categoryViewHeight = [self preferredCategoryViewHeight];
    CGFloat width = WindowsSize.width;
    CGFloat height = WindowsSize.height - Height_NavBar - categoryViewHeight;
    for (int i = 0; i < count; i ++) {
        if (i == 0) {
            BreakerChildController *listVC = [[BreakerChildController alloc] init];
            listVC.iId = self.iId;
            listVC.address_485 = self.address_485;
            [self configListViewController:listVC index:i];
            [self addChildViewController:listVC];
            listVC.view.frame = CGRectMake(i*width, 0, width, height);
            [self.scrollView addSubview:listVC.view];
        }else{
            Child2Controller *listVC = [[Child2Controller alloc] init];
            [self configListViewController:listVC index:i];
            [self addChildViewController:listVC];
            listVC.view.frame = CGRectMake(i*width, 0, width, height);
            [self.scrollView addSubview:listVC.view];
        }
      
    }

    [self initNavi];
    self.myCategoryView.titles = self.titles;
}


- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (NSUInteger)preferredListViewCount {
    return self.titles.count;
}

- (Class)preferredCategoryViewClass {
    return [JXCategoryTitleView class];
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




@end
