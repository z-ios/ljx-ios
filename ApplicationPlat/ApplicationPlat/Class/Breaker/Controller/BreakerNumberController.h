//
//  BreakerNumberController.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/26.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BreakerNumberController : UIViewController
@property(nonatomic,strong) NSArray *selectArr;
@property(nonatomic, strong)void(^backBlock)(NSString *str );
@property(nonatomic, copy)NSString *selectStr;
@end

NS_ASSUME_NONNULL_END
