//
//  RegisterAlertView.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/6.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol RegisterAlertViewDelegate <NSObject>

- (void)successWithIothub_id:(NSString *)iothub_id iId:(NSString *)iId nodId:(NSString *)nodId;
- (void)failFinishBackPage;

@end
@interface RegisterAlertView : UIView
@property(nonatomic, strong)NSDictionary *feedBackDic;
@property(nonatomic, assign)id <RegisterAlertViewDelegate>delagte;

@end

NS_ASSUME_NONNULL_END
