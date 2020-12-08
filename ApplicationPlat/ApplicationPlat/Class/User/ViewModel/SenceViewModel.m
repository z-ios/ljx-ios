//
//  SenceViewModel.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/8.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "SenceViewModel.h"

@implementation SenceViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark -- 获取版本列表
- (void)setUpdateListCallBack:(void (^)(NSUInteger statuCode,BOOL isSuccess ,NSError * error))callBack
{
    NSString* url = [NSString stringWithFormat:@"http://api.fir.im/apps/elco.iot.swt.ElectricityKanban?api_token=dcff7f1027fe9475f3d44ca7fb38ac81" ];
//    NSDictionary* dict = @{
//                            @"bundle_id" : @"elco.iot.swt.ElectricityKanban",
//                            @"api_token" : @"dcff7f1027fe9475f3d44ca7fb38ac81",
//                            @"type" : @"ios",
//                            };
//    AFHTTPSessionManager.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    [AFHTTPSessionManager.manager GET:url parameters:dict headers: nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//acceptableContentTypes
//           NSString* changelog = ![responseObject[@"changelog"] isKindOfClass:[NSNull class]] ? responseObject[@"changelog"] : @"";
//
//           NSString *versionShort = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//
//           if (![responseObject[@"versionShort"] isEqualToString:versionShort]){
//
////               [SELUpdateAlert showUpdateAlertWithVersion:responseObject[@"versionShort"] Description:changelog Url:responseObject[@"update_url"]];
//           }
//
//       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//           NSLog(@"%@",error);
//       }];
    
    NSString *getFacilitiesUrl = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [[SessionManger manger] getFunctionWithUrl:getFacilitiesUrl parameters:@{} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200) {
            id array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (array) {
//                if (![array isEqual:[NSNull null]] && array && array.count !=0) {
//
////                    NSArray* deviceModels = [NSArray yy_modelArrayWithClass:[SingleModel class] json:array];
////                    callBack(response.statusCode,deviceModels,nil);
//                }else{
//                    [MBProgressHUD showError:@"没有数据" toView:[UIApplication sharedApplication].windows.lastObject];
//                    callBack(response.statusCode,nil,nil);
//                }
//
            }else{
                [MBProgressHUD showError:@"返回数据为空" toView:[UIApplication sharedApplication].windows.lastObject];
                callBack(response.statusCode,nil,nil);
            }
        }else{
            [MBProgressHUD showError:@"数据格式错误" toView:[UIApplication sharedApplication].windows.lastObject];
            callBack(response.statusCode,nil,nil);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].windows.lastObject animated:YES];


        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSDictionary *json = [errResponse jsonDic];
        NSLog(@"%@", json);
        if (response.statusCode == 400) {
            hud.label.text = @"查询失败";
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
        callBack(response.statusCode,nil,error);
    }];
}
@end
