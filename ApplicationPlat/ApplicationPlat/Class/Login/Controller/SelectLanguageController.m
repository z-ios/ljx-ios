//
//  SelectLanguageController.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/10/19.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "SelectLanguageController.h"
#import "LanguageView.h"
#import "CLLanguageManager.h"
#import "LoginController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "EquipmentController.h"
#import "UserSetController.h"
#import "LoginView.h"
#import "TestLineController.h"
#import "LoginViewModel.h"
#import "TabController.h"
@interface SelectLanguageController ()<LoginControllerDelegate,LoginViewDelegate>

@property (nonatomic, strong) UIButton* chBtn;
@property (nonatomic, strong) UIButton* enBtn;
@property (nonatomic, strong) LanguageView* langView;
@property (nonatomic, strong) LoginView *loginView;
@property (nonatomic, strong) UIScrollView *bgScrollView;

@end

@implementation SelectLanguageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorString(@"#F4F8FB");
    [[[LoginViewModel alloc]init] judgeIpOrAdress];
    [self showLanguageView];
//    for (NSString *str  in [UIFont fontNamesForFamilyName:@"DIN Condensed"]) {
//        NSLog(@"ziti ============  %@", str);
//    }
    
    
}
#pragma mark - 设置语言

- (void)showLanguageView
{
    
    self.bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    _bgScrollView.contentSize = CGSizeMake(KScreenWidth * 2, KScreenHeight);
    _bgScrollView.scrollEnabled = NO;
    [self.view addSubview:_bgScrollView];
    UIView *bgLangeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    bgLangeView.backgroundColor = [UIColor whiteColor];
    [_bgScrollView addSubview:bgLangeView];
    
    UIImageView* imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_chooselauguage"]];
    imgV.frame = CGRectMake(48 * WidthScale, 61 * HeightScale, self.view.width - 48 * WidthScale*2, 192 * HeightScale);
    [bgLangeView addSubview:imgV];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 269 * HeightScale, self.view.width, self.view.height -269 * HeightScale)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 34;
    [bgLangeView addSubview:bgView];
    LanguageView* langView = [[LanguageView alloc] initWithFrame:bgView.bounds];
    langView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:langView];
    _langView = langView;
    CZHWeakSelf(self)
    _langView.setSuccessLanguage = ^(NSString * _Nonnull name) {
        if ([name isEqualToString:@"ch"]) {
            [CLLanguageManager setUserLanguage:@"zh-Hans"];
        }else{
            [CLLanguageManager setUserLanguage:@"en"];
        }
        
        [weakself.bgScrollView addSubview:weakself.loginView];
        [weakself.bgScrollView setContentOffset:CGPointMake(KScreenWidth, 0) animated:YES];

    };
    
    if ([self.selectIndex isEqualToString:@"1"]) {
        [self.bgScrollView addSubview:weakself.loginView];
        [self.bgScrollView setContentOffset:CGPointMake(KScreenWidth, 0)];
    }else{
        
    }
    
}


- (void)loginSuccessBack
{
    TabController *tabBarVC1 = [[TabController alloc]init];
    tabBarVC1.selectedIndex = 1;
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    if (!window) {
        window = [UIApplication sharedApplication].windows.lastObject;
    }
    if (@available(iOS 13,*)) {
        
    }else{
        window = [UIApplication sharedApplication].keyWindow;
        
    }
    

    [window transitionRootVc];
    window.rootViewController = tabBarVC1;



}


- (void)loginSuccess
{
    [self loginSuccessBack];
}
- (LoginView *)loginView
{
    if (_loginView == nil) {
        _loginView = [[LoginView alloc]initWithFrame:CGRectMake(KScreenWidth, 0, KScreenWidth, KScreenHeight)];
        _loginView.delegate = self;
        //        _loginView.backgroundColor = [UIColor whiteColor];
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


@end
