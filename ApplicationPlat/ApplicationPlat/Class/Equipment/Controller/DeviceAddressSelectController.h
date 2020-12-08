//
//  DeviceAddressSelectController.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/12/3.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "LocModel.h"
#import "LocationModel.h"
#import "BreakerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DeviceAddressSelectController : UIViewController<UISearchBarDelegate,MAMapViewDelegate,AMapSearchDelegate>
@property (nonatomic,  copy) void(^selectedEvent)(BOOL isSuccess,LocationModel *model);
@property (nonatomic, strong)BreakerModel *model;
@end

NS_ASSUME_NONNULL_END
