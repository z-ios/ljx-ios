//
//  BindBreakerView.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/13.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
NS_ASSUME_NONNULL_BEGIN
@protocol BindBreakerViewDelagte <NSObject>

- (void)presentWithNum:(UIAlertController *)alert isDismiss:(BOOL)isDiss;

@end
@interface BindBreakerView : UIView
@property (nonatomic, copy) void(^determineBlock)(void);
@property (nonatomic, copy) void(^scanCodeVc)(void);
@property (nonatomic, copy) void(^dropCodeVc)(NSString *selectStr);

@property (nonatomic, copy) void(^comBtnActionBlock)(NSString *errorMsg,BOOL success);
@property(nonatomic, copy)NSString *iId;

@property(nonatomic, strong)CustomTextField *customText;
@property(nonatomic, strong)CustomTextField *numText;
@property(nonatomic, strong)id <BindBreakerViewDelagte>delagate;

@end

NS_ASSUME_NONNULL_END
