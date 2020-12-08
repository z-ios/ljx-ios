//
//  LanguageView.m
//  Spider67
//
//  Created by 宾哥 on 2020/6/11.
//  Copyright © 2020 apple. All rights reserved.
//

#import "LanguageView.h"
#import "CLLanguageManager.h"
@interface LanguageView ()

@property (nonatomic, strong) UIButton* chBtn;
@property (nonatomic, strong) UIButton* enBtn;

@end
@implementation LanguageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}



- (void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 34;
    [self showLanguageView];
    
    
    
}

#pragma mark - 设置语言

- (void)showLanguageView
{
    UILabel* titleLabel = [UILabel z_frame:CGRectMake(26 * WidthScale, 40 * HeightScale, self.width - 26 * WidthScale * 2, 33 * HeightScale)
                                      Text:[[NSBundle currentLanguage] isEqualToString:@"en"] ? @"Please select language" :@"请选择您的语言"
                                      font:PingFangSCMedium(22)
                                     color:[UIColor colorWithHex:@"#121212"
                                            ]];
    [self addSubview:titleLabel];
    
    //获取当前设备语言
//    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
//    NSString *languageName = [appLanguages objectAtIndex:0];
    NSString* languageStr = [NSString stringWithFormat:@"%@%@",[[NSBundle currentLanguage] isEqualToString:@"en"] ? @"The system detects your current language is:\n":@"系统检测您当前语言为：",[[NSBundle currentLanguage] isEqualToString:@"en"] ?  @"English":@"简体中文"];
    
    UILabel* subtitleLabel = [UILabel  z_frame:CGRectMake(titleLabel.x, titleLabel.bottom + 5 * HeightScale, self.width - 26 * WidthScale * 2, 50 * HeightScale)
                                          Text:languageStr
                                          font:PingFangSCLight(13)
                                         color:[UIColor colorWithHex:@"#808080"]
                              ];
    [self addSubview:subtitleLabel];
    
    
    UIButton* chBtn = [UIButton z_frame:CGRectMake(subtitleLabel.x, subtitleLabel.bottom + 30 * HeightScale, self.width - 26 * WidthScale*2, 73 * HeightScale)
                           norImageName:@"icon_default"
                           selImageName:@"icon_check"
                                 Target:self
                                 action:@selector(chBtnClick:)
                                  title:@"简体中文"
                               selTitle:@"简体中文"
                                   font:PingFangSCLight(16)
                          norTitleColor:[UIColor colorWithHex:@"#B5B5B5"]
                          selTitleColor:[UIColor colorWithHex:@"#121212"]
                                bgColor:[UIColor colorWithHex:@"#F6F8FA"]
                           cornerRadius:8
                            borderWidth:1
                            borderColor:[UIColor colorWithHex:@"#0091FF"]
                       ];
    [self addSubview:chBtn];
    chBtn.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    chBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, chBtn.width*0.6);
    chBtn.imageEdgeInsets = UIEdgeInsetsMake(0, self.width*0.5, 0, 0);
    _chBtn = chBtn;
    
    
    UIButton* enBtn = [UIButton z_frame:CGRectMake(chBtn.x, chBtn.bottom + 15 * HeightScale, chBtn.width, chBtn.height)
                           norImageName:@"icon_default"
                           selImageName:@"icon_check"
                                 Target:self
                                 action:@selector(enBtnClick:)
                                  title:@"English   "
                               selTitle:@"English   "
                                   font:PingFangSCLight(16)
                          norTitleColor:[UIColor colorWithHex:@"#B5B5B5"]
                          selTitleColor:[UIColor colorWithHex:@"#121212"]
                                bgColor:[UIColor colorWithHex:@"#F6F8FA"]
                           cornerRadius:8
                            borderWidth:1
                            borderColor:[UIColor colorWithHex:@"#0091FF"]
                       ];
    [self addSubview:enBtn];
    enBtn.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    enBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, chBtn.width*0.6);
    enBtn.imageEdgeInsets = UIEdgeInsetsMake(0, self.width*0.5, 0, 0);
    _enBtn = enBtn;
    
    UIButton* sureBtn = [UIButton z_frame:CGRectMake(enBtn.x, enBtn.bottom + 30 * HeightScale, enBtn.width, 52 * HeightScale)
                                 fontSize:16
                             cornerRadius:6
                          backgroundColor:[UIColor colorWithHex:@"#0091FF"]
                               titleColor:[UIColor whiteColor]
                                    title:[[NSBundle currentLanguage] isEqualToString:@"en"] ? @"OK":@"确定"
                                   isbold:YES
                                   Target:self
                                   action:@selector(sureBtnClick)
                         ];
    sureBtn.titleLabel.font = PingFangSCMedium(17);
    [self addSubview:sureBtn];
    
    UILabel*zhuLabel = [UILabel z_frame:CGRectMake(sureBtn.x, sureBtn.bottom + 20 * WidthScale, sureBtn.width, 20 * HeightScale)
                                   Text:[[NSBundle currentLanguage] isEqualToString:@"en"] ? @"Ps:You can switch languages at any time in [SET]":@"注：您还可以在[设置]中随时切换语言"
                                   font:PingFangSCLight(13)
                                  color:[UIColor colorWithHex:@"#808080"]
                        ];
    zhuLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:zhuLabel];
    
    NSLog(@"yuan======%@", [NSBundle currentLanguage]);
    
    if ([[NSBundle currentLanguage] isEqualToString:@"en"]) {
        enBtn.selected = YES;
        chBtn.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
        chBtn.layer.borderWidth = 0.5;
       
    }else{
        chBtn.selected = YES;
        enBtn.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
        enBtn.layer.borderWidth = 0.5;
    }
}

- (void)chBtnClick:(UIButton *)btn
{
    
    btn.selected = YES;
    _enBtn.selected = NO;
    _enBtn.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    _enBtn.layer.borderWidth = 0.5;
    btn.layer.borderColor = [UIColor colorWithHex:@"#0091FF"].CGColor;
    btn.layer.borderWidth = 1;
    
    
}

- (void)enBtnClick:(UIButton *)btn
{
    
    btn.selected = YES;
    _chBtn.selected = NO;
    _chBtn.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    _chBtn.layer.borderWidth = 0.5;
    btn.layer.borderColor = [UIColor colorWithHex:@"#0091FF"].CGColor;
    btn.layer.borderWidth = 1;
    
    
}

- (void)sureBtnClick
{
    if (_chBtn.selected == YES) {
        if (self.setSuccessLanguage) {
            self.setSuccessLanguage(@"ch");
        }
    }else{
        if (self.setSuccessLanguage) {
            self.setSuccessLanguage(@"en");
        }
    }
}

- (void)reloadTabBarViewController {
    
    //    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //
    //    UITabBarController *tbc = [storyBoard instantiateInitialViewController];
    //    // 跳转到个人中心页面（即设置语言的那个tabBarItem）
    //    tbc.selectedIndex = self.tabBarController.selectedIndex;
    //
    //    // 创建设置页面
    //    UIViewController *settingVC = [storyBoard instantiateViewControllerWithIdentifier:@"setting"];
    //    settingVC.hidesBottomBarWhenPushed = YES;
    //
    //    // 创建语言选择界面
    //    FiFLanguageController *languageVC = [storyBoard instantiateViewControllerWithIdentifier:@"chooseLanguage"];
    //    languageVC.hidesBottomBarWhenPushed = YES;
    //
    //    UINavigationController *nvc = tbc.selectedViewController;
    //
    //    // 备用
    //    NSMutableArray *vcs = nvc.viewControllers.mutableCopy;
    //    [vcs addObjectsFromArray:@[settingVC, languageVC]];
    //
    //    //解决奇怪的动画bug。异步执行
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //
    //        //注意刷新rootViewController的时机，在主线程异步执行
    //        //先刷新rootViewController
    //        [UIApplication sharedApplication].keyWindow.rootViewController = tbc;
    //
    //        //然后再给个人中心的nvc设置viewControllers
    //        nvc.viewControllers = vcs;
    //    });
}
@end
