//
//  BreakSingleModel.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "BreakSingleModel.h"

@implementation BreakSingleModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"branch_breakers" : [MainbreakerModel class]};
}


@end
