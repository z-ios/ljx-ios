//
//  EquipmentViewModel.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/9.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "EquipmentViewModel.h"
#import "EquipmentModel.h"
#import "BreakerModel.h"
@implementation EquipmentViewModel

#pragma mark - 设备查询
- (void)deviceCheckDataCompletion:(void (^ __nullable)(BOOL success,NSArray *dataList))completion
{
    NSString *url = [NSString stringWithFormat:@"%@", DEVICECATEGORY ];
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    if (!window) {
        window = [UIApplication sharedApplication].windows.lastObject;
    }
    if (@available(iOS 13,*)) {
        
    }else{
        window = [UIApplication sharedApplication].keyWindow;
        
    }
    [[SessionManger manger] getFunctionWithUrl:url parameters:@{} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200) {
            NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (array) {
                if (![array isEqual:[NSNull null]] && array && array.count !=0) {
                    
                    NSArray* deviceModels = [NSArray yy_modelArrayWithClass:[EquipmentModel class] json:array];
                    completion(YES,deviceModels);
                }else{
                    [MBProgressHUD showError:@"没有数据" toView:window];
                    completion(NO,nil);
                }
                
            }else{
                [MBProgressHUD showError:@"返回数据为空" toView:window];
                completion(NO,nil);
            }
        }else{
            [MBProgressHUD showError:@"数据格式错误" toView:window];
            completion(NO,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        //        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        //        NSDictionary *json = [errResponse jsonDic];
        if (response.statusCode == 404) {
            hud.label.text = @"没有数据";
            [hud hideAnimated:YES afterDelay:1.0];
        }else{
            if (error.code == -1001) {
               hud.label.text = @"查询超时，请重新加载页面";
                [hud hideAnimated:YES afterDelay:1.0];
            }else{
                hud.label.text = @"请检查手机网络限制";
                [hud hideAnimated:YES afterDelay:1.0];
            }
            
        }
        completion(NO,nil);
        
    }];
    
}
#pragma mark --  获取断路器集合
- (void)breakerDatasWithParams:(NSDictionary *)params Completion:(void (^ __nullable)(BOOL success,NSArray *dataList, NSString *total, NSString *errorMsg))completion
{
    NSString *url = [NSString stringWithFormat:@"%@", PAGINATION ];
    
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    if (!window) {
        window = [UIApplication sharedApplication].windows.lastObject;
    }
    if (@available(iOS 13,*)) {
        
    }else{
        window = [UIApplication sharedApplication].keyWindow;
        
    }
    
    [[SessionManger manger] postFunctionWithUrl:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200) {
            NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (array) {
                if (![array isEqual:[NSNull null]] && array && array.count !=0) {
                    
                    NSArray* deviceModels = [NSArray yy_modelArrayWithClass:[BreakerModel class] json:array];
                    completion(YES,deviceModels,[NSString stringWithFormat:@"%lu", (unsigned long)array.count],@"");
                }else{
                    completion(NO,nil,@"0",@"没有数据");
                }
                
            }else{
                completion(NO,nil,@"0",@"返回数据为空");
            }
        }else{
            completion(NO,nil,@"0",@"数据格式错误");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSDictionary *json = [errResponse jsonDic];
        NSString *msg = @"";
        if (response.statusCode == 404) {
            msg = @"没有数据";
        }else if (response.statusCode == 500 || response.statusCode == 400) {
            msg = json[@"error"]?json[@"error"]:json.jsonStr;
        }else{
            if (error.code == -1001) {
                msg = @"查询超时，请重新加载页面";
            }else{
                msg = @"请检查手机网络限制";
            }
            
        }
        completion(NO,nil,@"0",msg);
        
    }];
}

//断路器查询个数
- (void)breakerCountWithParams:(NSString *)node_Id Completion:(void (^ __nullable)(BOOL success,NSString *count, NSString *errorMsg))completion
{
    NSString *url = [NSString stringWithFormat:@"%@", TOTALCOUNT ];
    
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    if (!window) {
        window = [UIApplication sharedApplication].windows.lastObject;
    }
    if (@available(iOS 13,*)) {
        
    }else{
        window = [UIApplication sharedApplication].keyWindow;
        
    }
    
    [[SessionManger manger] postFunctionWithUrl:url parameters:@{@"node_Id":node_Id,@"user_Id":Center.shared.userID} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (dic) {
                if ([dic.allKeys containsObject:@"count"]) {
                    
                    completion(YES,dic[@"count"],@"");
                }else{
                    completion(NO,@"0",@"没有数据");
                }
                
            }else{
                completion(NO,@"0",@"返回数据为空");
            }
        }else{
            completion(NO,@"0",@"数据格式错误");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSDictionary *json = [errResponse jsonDic];
        NSString *msg = @"";
        if (response.statusCode == 404) {
            msg = @"没有数据";
        }else if (response.statusCode == 500 || response.statusCode == 400) {
            msg = json[@"error"]?json[@"error"]:json.jsonStr;
        }else{
            if (error.code == -1001) {
                msg = @"查询超时，请重新加载页面";
            }else{
                msg = @"请检查手机网络限制";
            }
            
        }
        completion(NO,@"0",msg);
        
    }];
}
#pragma mark 删除整套断路器
- (void)deleteBreakerWithParams:(NSString *)iId Completion:(void (^ __nullable)(BOOL success, NSString *errorMsg))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/%@", BREAKERREGISTER, iId ];
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    if (!window) {
        window = [UIApplication sharedApplication].windows.lastObject;
    }
    if (@available(iOS 13,*)) {
        
    }else{
        window = [UIApplication sharedApplication].keyWindow;
        
    }
    [[SessionManger manger] deleteFunctionWithUrl:url parameters:@{} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;

        if (response.statusCode == 204) {

            completion(YES,@"");
            [MBProgressHUD showSuccess:@"删除成功" toView:window];
        }else{
            completion(NO,@"删除失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSDictionary *json = [errResponse jsonDic];
        NSString *msg = @"";
        if (response.statusCode == 404) {
            msg = @"404 - 删除失败";
        }else if (response.statusCode == 500 || response.statusCode == 400) {
            msg = json[@"error"]?json[@"error"]:json.jsonStr;
        }else{
            if (error.code == -1001) {
                msg = @"删除超时，请稍后重试";
            }else{
                msg = @"请检查手机网络限制";
            }
            
        }
        completion(NO,msg);
        
    }];
}
#pragma mark 更改位置
- (void)updateBreakerLocationWithParams:(NSDictionary *)params Completion:(void (^ __nullable)(BOOL success, NSString *errorMsg))completion
{
    NSString *url = [NSString stringWithFormat:@"%@", LOACTION ];
    
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    if (!window) {
        window = [UIApplication sharedApplication].windows.lastObject;
    }
    if (@available(iOS 13,*)) {
        
    }else{
        window = [UIApplication sharedApplication].keyWindow;
        
    }
    
    [[SessionManger manger] patchFunctionWithUrl:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200) {
            [MBProgressHUD showSuccess:@"更改成功" toView:window];
            completion(YES,@"");

        }else{
            completion(NO,@"更改失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSDictionary *json = [errResponse jsonDic];
        NSString *msg = @"";
        if (response.statusCode == 404) {
            msg = @"404 - 更改失败";
        }else if (response.statusCode == 500 || response.statusCode == 400) {
            msg = json[@"error"]?json[@"error"]:json.jsonStr;
        }else{
            if (error.code == -1001) {
                msg = @"更改超时，请重新加载页面";
            }else{
                msg = @"请检查手机网络限制";
            }
            
        }
        completion(NO,msg);
        
    }];
}
@end
