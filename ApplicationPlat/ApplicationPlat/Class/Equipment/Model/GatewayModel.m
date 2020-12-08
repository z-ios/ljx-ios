//
//  GatewayModel.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "GatewayModel.h"

@implementation GatewayModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data_items" : [DataItemModel class]};
}
@end
