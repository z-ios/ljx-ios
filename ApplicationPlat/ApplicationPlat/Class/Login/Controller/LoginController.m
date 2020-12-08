//
//  LoginController.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/8/27.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "LoginController.h"
#import "LoginView.h"
#import "TestLineController.h"
#import "LoginViewModel.h"

@interface LoginController ()<LoginViewDelegate>
@property(nonatomic, strong)LoginView *loginView;
@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[[LoginViewModel alloc]init] judgeIpOrAdress];
    [self.view addSubview:self.loginView];
    
}
- (LoginView *)loginView
{
    if (_loginView == nil) {
        _loginView = [[LoginView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        _loginView.delegate = self;
    }
    return _loginView;
}
#pragma mark - 测试服务器
- (void)pushTestLineController
{
    
    TestLineController *vc = [[TestLineController alloc]init];
    vc.definiteBack = ^{
        [self.loginView readIp];
    };
    [self presentViewController:vc animated:YES completion:nil];
    
}
#pragma mark -- 登陆成功
- (void)loginSuccess
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate loginSuccessBack];
   
    
}
@end
