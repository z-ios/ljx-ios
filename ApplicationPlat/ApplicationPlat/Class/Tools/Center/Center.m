//
//  CenterString.m
//  GuiZhouYiDong
//
//  Created by elco on 2018/5/1.
//  Copyright © 2018年 elco. All rights reserved.
//

#import "Center.h"

@implementation Center
+ (instancetype)shared{
    static Center *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [Center new];

       
    });

    return  instance;
    
}



@end
