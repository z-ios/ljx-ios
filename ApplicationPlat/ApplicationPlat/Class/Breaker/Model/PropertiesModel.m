//
//  PropertiesModel.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/12/2.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "PropertiesModel.h"

@implementation PropertiesModel
//获取对象的所有属性
- (NSArray *)getAllProperties
{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}
@end
