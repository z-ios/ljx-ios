//
//  HTTPSManager.h
//  Test
//
//  Created by elco on 2018/4/4.
//  Copyright © 2018年 elco. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface HTTPSManager : AFHTTPSessionManager
+ (HTTPSManager *)shared;
@end
