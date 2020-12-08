//
//  AddressPickerView.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/16.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTAreaPickViewModel.h"



NS_ASSUME_NONNULL_BEGIN
@class AddressPickerView;
@protocol AddressPickerViewDelegate <NSObject>
@optional;
/// 选中后调用的方法
/// @param areaPickerView 地区视图控制器
/// @param model 模型数据
- (void)areaPickerView:(AddressPickerView *)areaPickerView didSelectAreaModel:(BTAreaPickViewModel*)model;

/// 点击完成后
/// @param areaPickerView 地区视图控制器
/// @param model 模型数据
//- (void)areaPickerView:(AddressPickerView *)areaPickerView doneAreaModel:(BTAreaPickViewModel*)model;

@end
@interface AddressPickerView : UIView


/// 选择器
@property (nonatomic, strong) UIPickerView *pickerView;


/// 代理方法
@property (nonatomic, weak) id<AddressPickerViewDelegate> delegate;
/// 数据模型
@property (nonatomic, strong) BTAreaPickViewModel *model;
//滚动到对应的下标
-(void)scrollToRow:(NSInteger)firstRank  secondRand:(NSInteger)secondRand thirdRand:(NSInteger)thirdRand forRand:(NSInteger)forRand;

@end

NS_ASSUME_NONNULL_END
