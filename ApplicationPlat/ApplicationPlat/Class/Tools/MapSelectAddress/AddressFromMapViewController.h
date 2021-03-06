//
//  AddressFromMapViewController.h
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/7/10.
//  Copyright © 2018年 HangZhouFaDaiGuoJiMaoYi Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface AddressFromMapViewController : UIViewController<UISearchBarDelegate,MAMapViewDelegate,AMapSearchDelegate>

@property (nonatomic,  copy) void(^selectedEvent)(NSString* lat, NSString* lon, NSString* address, NSString* sheng, NSString* shi, NSString* qu, NSString* dao,NSString *provinceAcode,NSString *cityAcode,NSString *districeAcode, NSString *streetAcode);

@end
