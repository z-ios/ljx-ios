//
//  CustomTextField.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/3.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTextField : UIView
@property(nonatomic, strong)UITextField *textField;
@property(nonatomic, strong)UIButton *functionBtn;
- (instancetype)initWithFrame:(CGRect)frame isLine:(BOOL)isLine;
@end

NS_ASSUME_NONNULL_END
