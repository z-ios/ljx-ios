//
//  SessionManger.m
//  SFQ_IoT
//
//  Created by ljxMac on 2020/6/4.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "SessionManger.h"

@interface SessionManger ()
@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation SessionManger

static id _instance = nil;
+ (instancetype)manger
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
//使用gcd的dispatch_once()方法，在传入的代码段中，调用父类的内存申请函数
+(id) allocWithZone:(struct _NSZone*)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (AFHTTPSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _sessionManager.requestSerializer.timeoutInterval = 10;
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"text/json", @"text/javascript", nil];
        
    }
    return _sessionManager;
}
- (void)getFunctionWithUrl:(NSString *)urlStr
                parameters:(id)parameters
                   success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                   failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure
{
    
    
    [self.sessionManager GET:urlStr parameters:parameters headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, error);
    }];
}
- (void)postFunctionWithUrl:(NSString *)urlStr
                 parameters:(id)parameters
                    success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                    failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure
{
    [self.sessionManager POST:urlStr parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, error);
    }];
}
- (void)deleteFunctionWithUrl:(NSString *)urlStr
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure
{
    [self.sessionManager DELETE:urlStr parameters:parameters headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task, responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, error);
        
    }];
    
    
}
- (void)putFunctionWithUrl:(NSString *)urlStr
                parameters:(id)parameters
                   success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                   failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure
{
    [self.sessionManager PUT:urlStr parameters:parameters headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task, responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, error);
        
    }];
}
- (void)patchFunctionWithUrl:(NSString *)urlStr
                parameters:(id)parameters
                   success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                   failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure
{
    [self.sessionManager PATCH:urlStr parameters:parameters headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task, responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, error);
        
    }];
}
@end
