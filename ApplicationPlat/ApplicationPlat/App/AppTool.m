//
//  AppTool.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/8/27.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "AppTool.h"
#import "SELUpdateAlert.h"
@implementation AppTool
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)archiveTool
{
    [self getFir];
    [self wangluojiankong];
    //    [TBCityIconFont setFontName:@"iconfont"];
    if (@available(iOS 13.0, *)) {
        [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDarkContent;
    } else {
    }
    // 键盘弹出
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [AMapServices sharedServices].apiKey = @"5b583be71bb2940fa6dfc0f080fa7119";
    
}
// 获取版本号
- (void)getFir{
    
    NSDictionary* dict = @{
        @"bundle_id" : @"elco.iot.swt.ApplicationPlat",
        @"api_token" : @"dcff7f1027fe9475f3d44ca7fb38ac81",
        @"type" : @"ios",
    };
    
    [AFHTTPSessionManager.manager GET:@"http://api.fir.im/apps/latest/elco.iot.swt.ApplicationPlat" parameters:dict headers: nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString* changelog = ![responseObject[@"changelog"] isKindOfClass:[NSNull class]] ? responseObject[@"changelog"] : @"";
        
        NSString *versionShort = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        
        if (![responseObject[@"versionShort"] isEqualToString:versionShort]){
            
            [SELUpdateAlert showUpdateAlertWithVersion:responseObject[@"versionShort"] Description:changelog Url:responseObject[@"update_url"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
- (void)wangluojiankong {
    AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
         AFNetworkReachabilityStatusUnknown          = -1,
         AFNetworkReachabilityStatusNotReachable     = 0,
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         AFNetworkReachabilityStatusReachableViaWiFi = 2,
         */
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                //                MH_LOG(@"网络状态未知");
                [self alertlinestutas:@"网络状态" message:@"网络状态未知" toastType:FFToastTypeWarning];
                
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [self alertlinestutas:@"网络状态" message:@"网络连接失败！请检查网络...!" toastType:FFToastTypeError];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NotReachable" object:nil];
                
                break;
            case  AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"G|4G蜂窝移动网络");
                [self alertlinestutas:@"网络状态" message:@"正在使用4G蜂窝移动网络" toastType:FFToastTypeSuccess];
                
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI网络");
                
                [self alertlinestutas:@"网络状态" message:@"正在使用WIFI网络" toastType:FFToastTypeSuccess];
                
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
}
// 网络连接失败提示
- (void)alertlinestutas:(NSString *)title message:(NSString *)message toastType:(FFToastType)toastType {
    
    
    FFToast *toast = [[FFToast alloc]initToastWithTitle:title message:message iconImage:nil];
    toast.duration = 3.f;
    toast.toastType = toastType;
    toast.toastPosition = FFToastPositionBottomWithFillet;
    [toast show];
}

@end
