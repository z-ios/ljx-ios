//
//  GatewayModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataItemModel.h"
#import "PropertiesModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GatewayModel : NSObject
@property(nonatomic,copy)NSString *node_Id;
@property(nonatomic,copy)NSString *model;
@property(nonatomic,copy)NSString *period;
@property(nonatomic,strong)PropertiesModel *data_properties;
@property(nonatomic,strong)NSDictionary *state;
@end

NS_ASSUME_NONNULL_END
