//
//  StateModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OnlineStateModel.h"
#import "AlarmStateModel.h"
//@class OnlineStateModel,AlarmStateModel;
NS_ASSUME_NONNULL_BEGIN

@interface StateModel : NSObject
@property(nonatomic,strong)OnlineStateModel *onlineState;
@property(nonatomic,strong)AlarmStateModel *alarmState;
@end

NS_ASSUME_NONNULL_END
