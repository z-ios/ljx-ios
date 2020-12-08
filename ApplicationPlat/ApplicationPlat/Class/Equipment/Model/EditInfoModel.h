//
//  EditInfoModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/26.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EditInfoModel : NSObject
@property(nonatomic,copy)NSString *installation_userId;
@property(nonatomic,copy)NSString *installation_user;
@property(nonatomic,copy)NSString *installation_datetime;
@property(nonatomic,copy)NSString *lastest_edit_user;
@property(nonatomic,copy)NSString *lastest_edit_datetime;
@end

NS_ASSUME_NONNULL_END
