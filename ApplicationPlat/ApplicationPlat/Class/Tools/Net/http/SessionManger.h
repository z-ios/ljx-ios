//
//  SessionManger.h
//  SFQ_IoT
//
//  Created by ljxMac on 2020/6/4.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SessionManger : NSObject

/**
 *  单例
 */
+ (instancetype)manger;
- (void)getFunctionWithUrl:(NSString *)urlStr
                parameters:(id)parameters
                   success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                   failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;
- (void)postFunctionWithUrl:(NSString *)urlStr
                 parameters:(id)parameters
                    success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                    failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;
- (void)deleteFunctionWithUrl:(NSString *)urlStr
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;


- (void)putFunctionWithUrl:(NSString *)urlStr
                parameters:(id)parameters
                   success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                   failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;
- (void)patchFunctionWithUrl:(NSString *)urlStr
                parameters:(id)parameters
                   success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                     failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;
@end

NS_ASSUME_NONNULL_END
