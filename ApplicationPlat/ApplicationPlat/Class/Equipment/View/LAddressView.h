//
//  LAddressView.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/16.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTAreaPickViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LAddressView : UIView
@property(nonatomic,copy)void(^cancleBack)(void);
@property(nonatomic,copy)void(^setAddressBack)(BTAreaPickViewModel *addressModel);
@end

NS_ASSUME_NONNULL_END
