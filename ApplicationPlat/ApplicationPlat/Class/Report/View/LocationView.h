//
//  LocationView.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/4.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "LocModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol LocationViewDelegate <NSObject>

- (void)locationSelectPoint;
- (void)locationNextPageWithLocationDic:(NSDictionary *)dic;
- (void)locationBackPage;

@end
@interface LocationView : UIView
@property(nonatomic, strong)CustomTextField *customText;
@property(nonatomic, assign)id <LocationViewDelegate>delagte;
- (void)setDateWithParams:(LocModel *)model;
@end

NS_ASSUME_NONNULL_END
