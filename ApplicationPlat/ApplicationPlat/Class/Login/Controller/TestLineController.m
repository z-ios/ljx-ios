//
//  TestLineController.m
//  TJLTYW
//
//  Created by apple on 17/7/10.
//  Copyright © 2018 elco. All rights reserved.
//

#import "TestLineController.h"
#import "BTCoverVerticalTransition.h"
#import "LoginViewModel.h"
@interface TestLineController ()
@property (weak, nonatomic) IBOutlet UILabel *portLab;
@property (weak, nonatomic) IBOutlet UILabel *xieLab;
@property (weak, nonatomic) IBOutlet UIButton *testBtn;
@property (weak, nonatomic) IBOutlet UIButton *httpBtn;
@property (weak, nonatomic) IBOutlet UIButton *httpsBtn;
@property (weak, nonatomic) IBOutlet UITextField *tf_ip;
@property (weak, nonatomic) IBOutlet UITextField *tf_duankou;
@property (weak, nonatomic) IBOutlet UIButton *comBtn;
@property (nonatomic, strong) MBProgressHUD* hud;
@property (nonatomic, strong) BTCoverVerticalTransition *aniamtion;
@property (nonatomic, strong) LoginViewModel *loginViewModel;

@end

@implementation TestLineController
- (instancetype)init{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"TestLineController" bundle:nil];
    self = [storyboard instantiateViewControllerWithIdentifier:@"teststory"];;
    if (self) {
        _aniamtion = [[BTCoverVerticalTransition alloc]initPresentViewController:self withDragDismissEnabal:YES];
        self.transitioningDelegate = _aniamtion;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initData];
    self.view.backgroundColor = [UIColor whiteColor];
    self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, SCREEN_HEIGHT - 192 * HeightScale);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(16,16)];
    
    CAShapeLayer*maskLayer=[[CAShapeLayer alloc]init];
    
    maskLayer.frame = self.view.bounds;
    maskLayer.path = maskPath.CGPath;
    self.view.layer.mask = maskLayer;
    
    self.portLab.text = NSLocalizedString(@"testPort", nil);
    self.xieLab.text = NSLocalizedString(@"testProtocol", nil);
    [self.comBtn setTitle:NSLocalizedString(@"testBtn", nil) forState:UIControlStateNormal];
    [self.testBtn setTitle:NSLocalizedString(@"testVali", nil) forState:UIControlStateNormal];
    self.comBtn.titleLabel.font = PingFangSCMedium(18);
    self.testBtn.titleLabel.font = PingFangSCMedium(18);

}
- (void)initNavi
{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [btn setImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(gisAllfinishAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* ritem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn setTitle:@"     " forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = ritem;
}
- (void)initData
{
    //    TBCityIconInfo *selectInfo = [TBCityIconInfo iconInfoWithText:@"\U0000e669" size:24 color:DefaColor];
    //
    //    [_httpBtn setImage:[UIImage iconWithInfo:selectInfo] forState:(UIControlStateSelected)];
    //    [_httpsBtn setImage:[UIImage iconWithInfo:selectInfo] forState:(UIControlStateSelected)];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ht"]) {
        NSString* ht = [[NSUserDefaults standardUserDefaults] objectForKey:@"ht"];
        if ([ht isEqualToString:@"http"]) {
            self.httpBtn.selected = YES;
            self.httpsBtn.selected = NO;
        }else if ([ht isEqualToString:@"https"]) {
            self.httpsBtn.selected = YES;
            self.httpBtn.selected = NO;
        }
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"domain_ip"]) {
        NSString *domain_ip = [[NSUserDefaults standardUserDefaults] objectForKey:@"domain_ip"];
        self.tf_ip.text = domain_ip;
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"duankou"]) {
        self.tf_duankou.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"duankou"];
    }
}
- (void)gisAllfinishAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)http:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        _httpsBtn.selected = NO;
    }else{
        _httpsBtn.selected = YES;
    }
}

- (IBAction)https:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        _httpBtn.selected = NO;
    }else{
        _httpBtn.selected = YES;
    }
    
}
- (IBAction)test:(UIButton *)sender {
    
    [self testLine];
    
}
- (IBAction)sure:(UIButton *)sender {
    
    
    [self getlinedata];
    
    
}

- (void)testLine
{
//    NSLog(@"暂未开放");
    NSString *domain_ip = self.tf_ip.text;
       NSString *duankou = self.tf_duankou.text;
       NSString* ht;
       if (self.httpBtn.selected) {
           ht = @"http";
       }
       if (self.httpsBtn.selected) {
           ht = @"https";
       }
       NSString *base_url = @"";
       if (duankou.length == 0) {
           base_url = [NSString stringWithFormat:@"%@://%@",ht,domain_ip];
       }else{
           base_url = [NSString stringWithFormat:@"%@://%@:%@",ht,domain_ip,duankou];
           
       }
    [self.loginViewModel testingWithIp:base_url success:^(BOOL isSuccess, NSString * _Nonnull errorMsg) {
        
        if (!isSuccess) {
            [CustomAlert alertVcWithMessage:errorMsg Vc:self];
        }
        
    }];
    
}

- (void)getlinedata
{
    
    
    NSString *domain_ip = self.tf_ip.text;
    NSString *duankou = self.tf_duankou.text;
    NSString* ht;
    if (self.httpBtn.selected) {
        ht = @"http";
    }
    if (self.httpsBtn.selected) {
        ht = @"https";
    }
    NSString *base_url = @"";
    if (duankou.length == 0) {
        base_url = [NSString stringWithFormat:@"%@://%@",ht,domain_ip];
    }else{
        base_url = [NSString stringWithFormat:@"%@://%@:%@",ht,domain_ip,duankou];
        
    }
    //    NSString *base_url = [NSString stringWithFormat:@"%@://%@:%@",ht,domain_ip,duankou];
    NSString *websocket_url = [NSString stringWithFormat:@"%@:%@",domain_ip,duankou];
    [[NSUserDefaults standardUserDefaults] setObject:base_url forKey:@"base_url"];
    [[NSUserDefaults standardUserDefaults] setObject:websocket_url forKey:@"websocket_url"];
    [[NSUserDefaults standardUserDefaults] setObject:domain_ip forKey:@"domain_ip"];
    [[NSUserDefaults standardUserDefaults] setObject:duankou forKey:@"duankou"];
    [[NSUserDefaults standardUserDefaults] setObject:ht forKey:@"ht"];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.definiteBack();
    
    
}
- (LoginViewModel *)loginViewModel
{
    if (_loginViewModel==nil) {
        _loginViewModel = [[LoginViewModel alloc]init];
    }
    return _loginViewModel;
}
@end
