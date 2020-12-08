//
//  EquipmentCell.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/17.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EquipmentModel.h"
#import "EquipmentResultModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EquipmentCell : UITableViewCell
@property(nonatomic, strong)EquipmentModel * eqModel;
@property(nonatomic, strong)EquipmentResultModel *resuletModel;
@end

NS_ASSUME_NONNULL_END
