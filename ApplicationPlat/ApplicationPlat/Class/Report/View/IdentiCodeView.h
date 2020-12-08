//
//  IdentiCodeView.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/3.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
NS_ASSUME_NONNULL_BEGIN
@protocol IdentiCodeViewDelegate <NSObject>

- (void)nextPageWithMacCode:(NSString *)macCode;
- (void)scanCodeVc;

@end


@interface IdentiCodeView : UIView
@property(nonatomic, strong)CustomTextField *customText;
@property(nonatomic, strong)UIButton *nextBtn;

@property(nonatomic, assign)id <IdentiCodeViewDelegate>delagte;
@end

NS_ASSUME_NONNULL_END
