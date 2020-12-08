//
//  DataItemModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataItemModel : NSObject
@property(nonatomic,copy)NSString *origin_data;
@property(nonatomic,copy)NSString *converted_data;
@property(nonatomic,copy)NSString *protocol_key;
@property(nonatomic,copy)NSString *protocol_desc;
@property(nonatomic,copy)NSString *protocol;
@end

NS_ASSUME_NONNULL_END
