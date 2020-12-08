//
//  CenterString.h
//  GuiZhouYiDong
//
//  Created by elco on 2018/5/1.
//  Copyright © 2018年 elco. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Center : NSObject

+ (instancetype)shared;




//登录记录数据
@property (nonatomic, copy) NSString* userID;
@property (nonatomic, copy) NSString* userName;
@property (nonatomic, copy) NSString* phoneNumber;





@end
