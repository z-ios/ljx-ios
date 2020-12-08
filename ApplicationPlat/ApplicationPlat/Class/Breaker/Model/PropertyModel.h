//
//  PropertyModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/12/2.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PropertyModel : NSObject
@property(nonatomic, copy)NSString *parsed_data;
@property(nonatomic, copy)NSString *protocol_key;
@property(nonatomic, copy)NSString *protocol_desc;
@property(nonatomic, copy)NSString *unit;
@property(nonatomic, copy)NSString *raw_data;

@end

NS_ASSUME_NONNULL_END
