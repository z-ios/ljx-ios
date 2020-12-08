//
//  ModeView.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/13.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModeView : UIView
@property(nonatomic, strong) UIButton *imageV1;
@property(nonatomic, strong) UIButton *imageV;
@property(nonatomic, strong) UILabel *titleLab;
- (instancetype)initWithFrame:(CGRect)frame aOrMStr:(NSString *)aOrMStr;
@end

NS_ASSUME_NONNULL_END
