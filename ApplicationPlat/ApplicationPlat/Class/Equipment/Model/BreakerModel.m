//
//  BreakerModel.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/14.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "BreakerModel.h"





@implementation BreakerModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"edit_info" : [EditInfoModel class],@"gateway":[GatewayModel class],@"location":[LocationModel class]};
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"iId" : @"id"};
}
@end
