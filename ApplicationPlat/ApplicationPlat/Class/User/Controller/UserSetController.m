//
//  UserSetController.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/8.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "UserSetController.h"
#import "UserView.h"
#import "LoginController.h"
#import "UpdateSenceController.h"
#import "SELUpdateAlert.h"
#import "SelectLanguageController.h"
#import "UpdateWebController.h"
@interface UserSetController ()<UserViewDelegate>
@property(nonatomic, strong)UserView *userView;
@end

@implementation UserSetController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.title = @"设置";
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    UIBarButtonItem* lItem = [[UIBarButtonItem alloc] initWithCustomView:titleLab];
    titleLab.text = NSLocalizedString(@"setTitle", nil);
    titleLab.textColor = ColorString(@"#2E3C4D");
    
    titleLab.font = PingFangSCSemibold(20);
    self.navigationItem.leftBarButtonItem = lItem;
    
    
    [self.view addSubview:self.userView];
}
- (void)loginOut
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:NSLocalizedString(@"setLogOutAlert", nil) preferredStyle:UIAlertControllerStyleAlert];
//    alertVc.view.backgroundColor = [UIColor whiteColor];

    UIAlertAction *cancleAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setCancelBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *comAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setDefineBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//       [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"z_pwd"];
//         [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"z_username"];
        SelectLanguageController* enterVc = [[SelectLanguageController alloc] init];
        enterVc.selectIndex = @"1";
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window transitionRootVc];
        window.rootViewController = enterVc;
  
    }];
    [alertVc addAction:cancleAc];
    [alertVc addAction:comAc];
    [self presentViewController:alertVc animated:YES completion:^{
        
    }];
}
- (void)notOpen
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:NSLocalizedString(@"setAlertBtn", nil) preferredStyle:UIAlertControllerStyleAlert];
//    alertVc.view.backgroundColor = [UIColor whiteColor];
    UIAlertAction *comAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setDefineBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        
    }];
    [alertVc addAction:comAc];
    [self presentViewController:alertVc animated:YES completion:^{
        
    }];
}
- (void)nextUpdateVc
{
//    UpdateSenceController *vc = [[UpdateSenceController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    [self getDataWithType:@"update"];

}
- (UserView *)userView
{
    if (_userView ==nil) {
        _userView = [[UserView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - Height_NavBar - Height_TabBar)];
        _userView.delegate = self;
    }
    return _userView;
}
- (void)checkUpdateVersion
{
    [self getDataWithType:@"check"];
}
- (void)getDataWithType:(NSString *)type
{
    NSDictionary* dict = @{
           @"bundle_id" : @"elco.iot.swt.ApplicationPlat",
           @"api_token" : @"dcff7f1027fe9475f3d44ca7fb38ac81",
           @"type" : @"ios",
       };
    NSString *url = @"http://api.fir.im/apps/latest/elco.iot.swt.ApplicationPlat";

//    NSString *url = @"https://www.betaqr.com/apps/5f966138b2eb4601d00861c2";
    CZHWeakSelf(self)
       [AFHTTPSessionManager.manager GET:url parameters:dict headers: nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
           NSString* changelog = ![responseObject[@"changelog"] isKindOfClass:[NSNull class]] ? responseObject[@"changelog"] : @"";
           
           NSString *versionShort = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
           if ([type isEqualToString:@"check"]) {
               
               if (![responseObject[@"versionShort"] isEqualToString:versionShort]){
                   
                   [SELUpdateAlert showUpdateAlertWithVersion:responseObject[@"versionShort"] Description:changelog Url:responseObject[@"update_url"]];
               }else{
                   //               [FFToast showToastWithTitle:@"当前已是最新版本！" message:@"" iconImage:nil duration:3 toastType:FFToastTypeDefault];
                   FFToast *toast = [[FFToast alloc]initToastWithTitle:@"当前已是最新版本！" message:nil iconImage:nil];
                   toast.duration = 3.f;
                   toast.toastType = FFToastTypeDefault;
                   toast.toastPosition = FFToastPositionBottomWithFillet;
                   [toast show];
               }
           }else{
//               [[UIApplication sharedApplication] openURL:[NSURL URLWithString:responseObject[@"update_url"]] options:@{} completionHandler:^(BOOL success) {
//                   weakself.userView.versionBtn.userInteractionEnabled = YES;
//                   [weakself.userView.versionBtn.layer removeAnimationForKey:@"rotationAnimation"];
//
//               }];
               weakself.userView.versionBtn.userInteractionEnabled = YES;
              [weakself.userView.versionBtn.layer removeAnimationForKey:@"rotationAnimation"];
               
               UpdateWebController *vc = [[UpdateWebController alloc]init];
               vc.urlStr = responseObject[@"update_url"];
               [self.navigationController pushViewController:vc animated:YES];
               
           }
           
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           weakself.userView.versionBtn.userInteractionEnabled = YES;
           [weakself.userView.versionBtn.layer removeAnimationForKey:@"rotationAnimation"];
           NSLog(@"%@",error);
       }];
}

@end
