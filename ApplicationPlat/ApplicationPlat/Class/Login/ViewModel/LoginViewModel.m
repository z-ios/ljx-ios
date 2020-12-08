//
//  LoginViewModel.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/8/28.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)loginPhoneStr:(NSString *)phoneStr pwdStr:(NSString *)pwdStr success:(void (^)(BOOL isSuccess, NSString *errorMsg))success
{
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].windows.lastObject animated:YES];
    //    if (![phoneStr isValidateMobile]) {
    if (phoneStr.length == 0) {

        [hud hideAnimated:YES];
        success(NO,NSLocalizedString(@"loginPhoneAlert", nil));
        
    }else{
        if (pwdStr.length == 0) {

            [hud hideAnimated:YES];
            success(NO,NSLocalizedString(@"loginPwdAlert", nil));
            
        }else{
            hud.label.text = NSLocalizedString(@"loginAlert", nil);
            NSMutableDictionary* para_dict = [NSMutableDictionary dictionary];
            para_dict[@"username"] = phoneStr;
            para_dict[@"password"] = pwdStr;
            NSString *url = [NSString stringWithFormat:@"%@", POSTLOGIN ];
            [[SessionManger manger] postFunctionWithUrl:url parameters:para_dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                if (dict) {

                    Center.shared.userID = dict[@"id"];
                    Center.shared.userName = dict[@"username"];
                    [hud hideAnimated:YES];
                    success(YES,@"");
                }else{
                    [hud hideAnimated:YES];
                    success(NO,@"返回数据为空! 请重新登录");
                    
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [hud hideAnimated:YES];
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                NSDictionary *json = [errResponse jsonDic];
                NSString *msg = @"";
                if (response.statusCode == 401) {
                    msg = json[@"msg"];
                }else if ( response.statusCode == 400 || response.statusCode == 500) {
                    msg = json[@"error"]?json[@"error"]:json.jsonStr;
                    
                } else{
                    if (error.code == -1001) {
                        msg = @"登录超时，请重新登录";
                    }else{
                        msg = @"请检查手机网络限制";
                    }
                    
                }
                
                success(NO,msg);
                
            }];
            
            
        }
    }
    
}

// 测试服务器
    - (void)testingWithIp:(NSString *)str success:(void (^)(BOOL isSuccess, NSString *errorMsg))success
{
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].windows.lastObject animated:YES];
    
    hud.label.text = @"正在测试...";
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Testing/OK", str ];
    [[SessionManger manger] getFunctionWithUrl:url parameters:@{} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        hud.label.text = @"测试成功";
        [hud hideAnimated:YES afterDelay:1.0];
        success(YES,@"");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [hud hideAnimated:YES];
        success(NO,@"测试失败，请重新填写");

        
        
    }];
    
    
    
    
}
- (void)judgeIpOrAdress{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"base_url"]) {
        NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"base_url"];
        NSString *websocket_url = @"";
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"websocket_url"]) {
            websocket_url = [[NSUserDefaults standardUserDefaults]objectForKey:@"websocket_url"];
        }
        if (str&&![str isEqualToString:@""]) {
            
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"http://60.29.126.12:5512" forKey:@"base_url"];
            [[NSUserDefaults standardUserDefaults] setObject:@"http" forKey:@"ht"];
            [[NSUserDefaults standardUserDefaults] setObject:@"60.29.126.12" forKey:@"domain_ip"];
            [[NSUserDefaults standardUserDefaults] setObject:@"5512" forKey:@"duankou"];
            
        }
        
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"http://60.29.126.12:5512" forKey:@"base_url"];
        [[NSUserDefaults standardUserDefaults] setObject:@"http" forKey:@"ht"];
        [[NSUserDefaults standardUserDefaults] setObject:@"60.29.126.12" forKey:@"domain_ip"];
        [[NSUserDefaults standardUserDefaults] setObject:@"5512" forKey:@"duankou"];
    }
    
    
}
@end
