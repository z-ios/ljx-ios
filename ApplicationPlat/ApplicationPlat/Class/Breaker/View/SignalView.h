//
//  SignalView.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/23.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignalView : UIView
@property(nonatomic, strong)UIButton *imageBtn;
@property(nonatomic, strong)UILabel *titleLab;
@property(nonatomic, strong)UILabel *detialLab;
@property(nonatomic, strong)UILabel *unitLab;

- (instancetype)initWithFrame:(CGRect)frame typeStr:(NSString *)typeStr;
@end

NS_ASSUME_NONNULL_END
