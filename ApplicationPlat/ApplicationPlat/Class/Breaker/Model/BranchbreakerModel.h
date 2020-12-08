//
//  BranchbreakerModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BranchbreakerModel : NSObject
@property(nonatomic, copy)NSString *address_485;
@property(nonatomic, strong)NSArray<DataItemModel *> *data_items;
@end

NS_ASSUME_NONNULL_END
