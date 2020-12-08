//
//  UpdateSenceController.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/8.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "UpdateSenceController.h"
#import "SenceView.h"
@interface UpdateSenceController ()
@property(nonatomic, strong)SenceView *senceView;
@end

@implementation UpdateSenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"更新日志";
    [self initNavi];
    [self.view addSubview:self.senceView];
}
- (void)initNavi
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = YES;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [btn setImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* ritem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn setTitle:@"     " forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = ritem;
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (SenceView *)senceView
{
    if (_senceView == nil) {
        _senceView = [[SenceView alloc]initWithFrame:CGRectMake(0, Height_NavBar, KScreenWidth, KScreenHeight - Height_NavBar- Height_TabBar)];
    }
    return _senceView;
}

@end
