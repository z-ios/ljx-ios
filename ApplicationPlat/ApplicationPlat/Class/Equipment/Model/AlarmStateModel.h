//
//  AlarmStateModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlarmStateModel : NSObject
@property(nonatomic,copy)NSString *alarm_state;
@property(nonatomic,copy)NSString *descri;
@property(nonatomic,copy)NSString *record_time;
@end

NS_ASSUME_NONNULL_END
