//
//  BranchbreakViewModel.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "BranchbreakViewModel.h"

@implementation BranchbreakViewModel


#pragma mark 获取单个断路器集合
- (void)breakerWithParams:(NSString *)iId Completion:(void (^ __nullable)(BOOL success,BreakSingleModel *model, NSString *errorMsg))completion
{
    
    AFHTTPSessionManager *_sessionManager = [AFHTTPSessionManager manager];
    _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    _sessionManager.requestSerializer.timeoutInterval = 3;
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"text/json", @"text/javascript", nil];
    NSString *url = [NSString stringWithFormat:@"%@/%@", BREAKERREGISTER, iId ];

    
    [_sessionManager GET:url parameters:@{} headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (dic&&![dic isEqual:[NSNull null]]) {
                
                BreakSingleModel* breakModel = [BreakSingleModel yy_modelWithDictionary:dic];
                completion(YES,breakModel,@"");
                
            }else{
                completion(NO,nil,@"返回数据为空");
            }
        }else{
            completion(NO,nil,@"数据格式错误");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSDictionary *json = [errResponse jsonDic];
        NSString *msg = @"";
        if (response.statusCode == 404) {
            msg  = @"没有数据";
        }else if (response.statusCode == 500 || response.statusCode == 400) {
            msg  = json[@"error"]?json[@"error"]:json.jsonStr;
        }else{
            if (error.code == -1001) {
                msg  = @"查询超时，请重新加载页面";
            }else{
                msg  = @"请检查手机网络限制";
            }
            
        }
        completion(NO,nil,msg);
    }];


}

#pragma mark - 跳闸
- (void)breakerOpenWithParams:(NSDictionary *)params Completion:(void (^ __nullable)(BOOL success, NSString *errorMsg))completion
{
    NSString *url = [NSString stringWithFormat:@"%@", BREAKEROPEN];
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    if (!window) {
        window = [UIApplication sharedApplication].windows.lastObject;
    }
    if (@available(iOS 13,*)) {
        
    }else{
        window = [UIApplication sharedApplication].keyWindow;
        
    }
    [[SessionManger manger] putFunctionWithUrl:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (dic&&![dic isEqual:[NSNull null]]) {
                NSString *mssage = dic[@"response"][@"message"];
                [MBProgressHUD showSuccess:mssage toView:window];
                completion(YES,@"");
            }else{
                completion(NO,@"返回数据为空");
            }
        }else{
            completion(NO,@"数据格式错误");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSDictionary *json = [errResponse jsonDic];
        NSString *msg = @"";
        if (response.statusCode == 404) {
            msg = @"跳闸失败";
        }else if (response.statusCode == 500 || response.statusCode == 400) {
            msg = json[@"error"]?json[@"error"]:json.jsonStr;
        }else{
            if (error.code == -1001) {
                msg = @"跳闸超时，请稍后重试";
            }else{
                msg = @"请检查手机网络限制";
            }
            
        }
        completion(NO,msg);
    }];
}
#pragma mark - 合闸
- (void)breakerCloseWithParams:(NSDictionary *)params Completion:(void (^ __nullable)(BOOL success, NSString *errorMsg))completion
{
    NSString *url = [NSString stringWithFormat:@"%@", BREAKERCLOSE];
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    if (!window) {
        window = [UIApplication sharedApplication].windows.lastObject;
    }
    if (@available(iOS 13,*)) {
        
    }else{
        window = [UIApplication sharedApplication].keyWindow;
        
    }
    [[SessionManger manger] putFunctionWithUrl:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (dic&&![dic isEqual:[NSNull null]]) {
                NSString *mssage = dic[@"response"][@"message"];
                [MBProgressHUD showSuccess:mssage toView:window];
                
                completion(YES,@"");
                
                
            }else{
                completion(NO,@"返回数据为空");
            }
        }else{
            completion(NO,@"数据格式错误");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSDictionary *json = [errResponse jsonDic];
        NSString *msg = @"";
        if (response.statusCode == 404) {
            msg = @"合闸失败";
        }else if (response.statusCode == 500 || response.statusCode == 400) {
            msg = json[@"error"]?json[@"error"]:json.jsonStr;
        }else{
            if (error.code == -1001) {
                msg = @"合闸超时，请稍后重试";
            }else{
                msg = @"请检查手机网络限制";
            }
            
        }
        completion(NO,msg);
        
    }];
}

#pragma mark - 绑定子断路器 *******
- (void)bindBreakerWithParams:(NSDictionary *)params Completion:(void (^ __nullable)(BOOL success, NSString *errorMsg))completion
{
    NSString *url = [NSString stringWithFormat:@"%@", BINDCHINDBREAKER];
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    if (!window) {
        window = [UIApplication sharedApplication].windows.lastObject;
    }
    if (@available(iOS 13,*)) {
        
    }else{
        window = [UIApplication sharedApplication].keyWindow;
        
    }
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    [[SessionManger manger] putFunctionWithUrl:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (dic&&![dic isEqual:[NSNull null]]) {
                NSString *mssage = dic[@"response"][@"message"];
                hud.label.text = mssage;
                completion(YES,@"");
                [hud hideAnimated:YES afterDelay:1.0];
                
            }else{
                completion(NO, @"返回数据为空");
                [hud hideAnimated:YES];
            }
        }else{
            completion(NO,@"数据格式错误");
            [hud hideAnimated:YES];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSDictionary *json = [errResponse jsonDic];
        NSString *msg = @"";
        if (response.statusCode == 404) {
            msg = @"绑定失败";
        }else if (response.statusCode == 500 || response.statusCode == 400) {
            msg = json[@"response"][@"error"]?json[@"response"][@"error"]:json.jsonStr;
        }else{
            if (error.code == -1001) {
                msg = @"绑定超时，请稍后重试";
            }else{
                msg = @"请检查手机网络限制";
            }
            
        }
        completion(NO,msg);
    }];
    
}
#pragma mark - 解绑子断路器
- (void)deleteChildBreakerWithParams:(NSDictionary *)params Completion:(void (^ __nullable)(BOOL success, NSString *errorMsg))completion
{
    
    NSString *url = [NSString stringWithFormat:@"%@", UNBINDCHINDBREAKER];
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    if (!window) {
        window = [UIApplication sharedApplication].windows.lastObject;
    }
    if (@available(iOS 13,*)) {
        
    }else{
        window = [UIApplication sharedApplication].keyWindow;
        
    }
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    [[SessionManger manger] putFunctionWithUrl:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (dic&&![dic isEqual:[NSNull null]]) {
                NSString *mssage = dic[@"response"][@"message"];
                
                hud.label.text = mssage;
                [hud hideAnimated:YES afterDelay:1.0];
                
                completion(YES,@"");
                
                
            }else{
                [hud hideAnimated:YES];
                completion(NO,@"返回数据为空");
            }
        }else{
            [hud hideAnimated:YES];
            completion(NO,@"数据格式错误");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSDictionary *json = [errResponse jsonDic];
        NSString *msg = @"";
        if (response.statusCode == 404) {
            msg = @"解绑失败";
        }else if (response.statusCode == 500 || response.statusCode == 400) {
            msg = json[@"response"][@"error"]?json[@"response"][@"error"]:json.jsonStr;
            
        }else{
            if (error.code == -1001) {
                msg = @"解绑超时，请稍后重试";
            }else{
                msg = @"请检查手机网络限制";
            }
            
        }
        completion(NO,msg);
    }];
}
#pragma mark -更改上报周期
- (void)setPeriodWithParams:(NSDictionary *)params Completion:(void (^ __nullable)(BOOL success, NSString *errorMsg))completion
{
    NSString *url = [NSString stringWithFormat:@"%@", COMMANDPERIOD];
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    if (!window) {
        window = [UIApplication sharedApplication].windows.lastObject;
    }
    if (@available(iOS 13,*)) {
        
    }else{
        window = [UIApplication sharedApplication].keyWindow;
        
    }
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    [[SessionManger manger] putFunctionWithUrl:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (dic&&![dic isEqual:[NSNull null]]) {
                NSLog(@"respone: ===========%@",dic);
                NSString *mssage = dic[@"response"][@"message"];
                hud.label.text = mssage;
                [hud hideAnimated:YES afterDelay:1.0];
                completion(YES,@"");
                
                
            }else{
                [hud hideAnimated:YES];
                completion(NO,@"返回数据为空");
            }
        }else{
            [hud hideAnimated:YES];
            
            completion(NO,@"数据格式错误");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSDictionary *json = [errResponse jsonDic];
        NSString *msg = @"";
        if (response.statusCode == 404) {
            msg = @"更新时间失败";
        }else if (response.statusCode == 500 || response.statusCode == 400) {
            msg = json[@"response"][@"error"]?json[@"response"][@"error"]:json.jsonStr;
            
        }else{
            if (error.code == -1001) {
                msg = @"更新时间超时，请稍后重试";
            }else{
                msg = @"请检查手机网络限制";
            }
            
        }
        completion(NO,msg);
    }];
}
//#pragma mark -- 更新模式下发
//- (void)breakerModeWithParams:(NSDictionary *)params Completion:(void (^ __nullable)(BOOL success, NSString *errorMsg))completion
//{
//    NSString *url = [NSString stringWithFormat:@"%@", COMMANDAUTO];
//    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
//    if (!window) {
//        window = [UIApplication sharedApplication].windows.lastObject;
//    }
//    if (@available(iOS 13,*)) {
//
//    }else{
//        window = [UIApplication sharedApplication].keyWindow;
//
//    }
//    [[SessionManger manger] putFunctionWithUrl:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
//        if (response.statusCode == 200) {
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            if (dic&&![dic isEqual:[NSNull null]]) {
//                NSString *mssage = dic[@"response"][@"message"];
//                [MBProgressHUD showSuccess:mssage toView:window];
//
//                completion(YES,@"");
//
//
//            }else{
//                completion(NO,@"返回数据为空");
//            }
//        }else{
//            completion(NO,@"数据格式错误");
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
//        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
//        NSDictionary *json = [errResponse jsonDic];
//        NSString *msg = @"";
//        if (response.statusCode == 404) {
//            msg = @"更新模式失败";
//        }else if (response.statusCode == 500 || response.statusCode == 400) {
//            msg = json[@"error"]?json[@"error"]:json.jsonStr;
//        }else{
//            if (error.code == -1001) {
//                msg = @"更新模式超时，请稍后重试";
//            }else{
//                msg = @"请检查手机网络限制";
//            }
//
//        }
//        completion(NO,msg);
//
//    }];
//}
#pragma mark --  更新模式下发-手动和自动
- (void)breakerModeWithParams:(NSDictionary *)params isAuto:(BOOL )isAuto Completion:(void (^ __nullable)(BOOL success, NSString *errorMsg))completion
{
    NSString *url = @"";
    if (isAuto) {
        url = [NSString stringWithFormat:@"%@", COMMANDAUTO];
    }else{
        
        url = [NSString stringWithFormat:@"%@", COMMANDMANUAL];
    }
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    if (!window) {
        window = [UIApplication sharedApplication].windows.lastObject;
    }
    if (@available(iOS 13,*)) {
        
    }else{
        window = [UIApplication sharedApplication].keyWindow;
        
    }
    [[SessionManger manger] putFunctionWithUrl:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (dic&&![dic isEqual:[NSNull null]]) {
                NSString *mssage = dic[@"response"][@"message"];
                [MBProgressHUD showSuccess:mssage toView:window];
                
                completion(YES,@"");
                
                
            }else{
                completion(NO,@"返回数据为空");
            }
        }else{
            completion(NO,@"数据格式错误");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSDictionary *json = [errResponse jsonDic];
        NSString *msg = @"";
        if (response.statusCode == 404) {
            msg = @"更新模式失败";
        }else if (response.statusCode == 500 || response.statusCode == 400) {
            msg = json[@"error"]?json[@"error"]:json.jsonStr;
        }else{
            if (error.code == -1001) {
                msg = @"更新模式超时，请稍后重试";
            }else{
                msg = @"请检查手机网络限制";
            }
            
        }
        completion(NO,msg);
        
    }];
}
@end
