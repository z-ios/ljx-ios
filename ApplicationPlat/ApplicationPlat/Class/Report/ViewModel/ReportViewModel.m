//
//  ReportViewModel.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/3.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "ReportViewModel.h"
#import "IothubModel.h"
@implementation ReportViewModel


#pragma mark - 获取系统中所有IoTHub文档 按名称正序排列
- (void)iotHubDataCompletion:(void (^ __nullable)(BOOL success,NSArray *dataList, NSString *errorMsg))completion
{
    NSString *url = [NSString stringWithFormat:@"%@", IOTHUBLIST ];
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
                    
                    NSArray* deviceModels = [NSArray yy_modelArrayWithClass:[IothubModel class] json:array];
                    completion(YES,deviceModels,@"");
                }else{
                    completion(NO,nil,@"没有数据");
                }
                
            }else{
                completion(NO,nil,@"返回数据为空");
            }
        }else{
            completion(response.statusCode,nil,@"数据格式错误");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSDictionary *json = [errResponse jsonDic];
        NSString *msg = @"";
        if (response.statusCode == 404) {
            msg = @"没有数据";
        } else if (response.statusCode == 500 || response.statusCode == 400) {
            
            msg = json[@"error"]?json[@"error"]:json.jsonStr;
        }else{
            if (error.code == -1001) {
                msg = @"查询超时，请重新查询";
            }else{
                msg = @"请检查手机网络限制";
            }
            
        }
        completion(NO,nil,msg);
        
    }];
    
}
#pragma mark - IoTHub注册验证
- (void)iotHubRegisterWithParams:(NSDictionary *)params Completion:(void (^ __nullable)(BOOL success,NSString *msg,IOTHubRegisterModel *model))completion
{
    NSString *url = [NSString stringWithFormat:@"%@", IOTHUBREGIATERAVAILE];
    [[SessionManger manger] postFunctionWithUrl:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (dic&&![dic isEqual:[NSNull null]]) {
                IOTHubRegisterModel *model = [IOTHubRegisterModel yy_modelWithDictionary:dic];
                completion(YES,@"此设备已注册在IoTHub中",model);
                
                
            }else{
                completion(NO,@"IoTHub中不存在此设备",nil);
            }
        }else{
            completion(NO,@"IoTHub中不存在此设备",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSDictionary *json = [errResponse jsonDic];
        if(response.statusCode == 404){
            completion(NO,json[@"message"],nil);
        }else if (response.statusCode == 500 || response.statusCode == 400) {
            completion(NO,json[@"error"],nil);
        }
        else{
            if (error.code == -1001) {
                completion(NO,@"注册超时，请稍后重试",nil);
            }else{
                completion(NO,@"请检查手机网络限制",nil);
            }
            
        }
    }];
}
#pragma mark - 设备 注册

- (void)deviceRegisterWithParams:(NSDictionary *)params Completion:(void (^ __nullable)(BOOL success,NSString *msg,NSString *iId))completion
{
    NSString *url = [NSString stringWithFormat:@"%@", BREAKERREGISTER];
    [[SessionManger manger] postFunctionWithUrl:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 201) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (dic&&![dic isEqual:[NSNull null]]) {
                completion(YES,@"注册成功",dic[@"id"]);
                
                
            }else{
                completion(NO,@"注册失败",@"");
            }
        }else{
            completion(NO,@"注册失败",@"");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSDictionary *json = [errResponse jsonDic];
        NSString *str = json[@"error"]?json[@"error"]:[NSString stringWithFormat:@"%ld-注册失败", (long)response.statusCode];
        if (response.statusCode == 400) {
            completion(NO,str,@"");
        }else if(response.statusCode == 500 ){
            completion(NO,str,@"");
        }
        else{
            if (error.code == -1001) {
                completion(NO,@"注册超时，请稍后重试",@"");
            }else{
                completion(NO,@"请检查手机网络限制",@"");
            }
            
        }
    }];
}
@end
