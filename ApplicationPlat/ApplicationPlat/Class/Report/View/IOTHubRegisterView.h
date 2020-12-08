//
//  IOTHubRegisterView.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/4.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IOTHubRegisterModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol IOTHubRegisterViewDelegate <NSObject>

- (void)iothubRegisterNextPageWithIOTHubRegisterModel:(IOTHubRegisterModel *)model;
- (void)iothubRegisterBackPage;
- (void)iothubFailRegisterBackPage;

@end
@interface IOTHubRegisterView : UIView
@property(nonatomic, strong)NSDictionary *paramsDic;
@property(nonatomic, assign)id <IOTHubRegisterViewDelegate>delagte;

@end

NS_ASSUME_NONNULL_END
