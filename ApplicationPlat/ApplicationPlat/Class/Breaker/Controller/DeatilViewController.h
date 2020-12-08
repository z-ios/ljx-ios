//
//  DeatilViewController.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/27.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ENestScrollPageView.h"
#import "PageItem.h"
#import "BaseViewController.h"
#import "JXCategoryView.h"
NS_ASSUME_NONNULL_BEGIN
@interface DeatilViewController : BaseViewController
@property(nonatomic, copy)NSString *address_485;
@property(nonatomic, copy)NSString *iId;
@property (nonatomic, strong) NSArray *titles;
//@property (nonatomic, assign) BOOL shouldHandleScreenEdgeGesture;




@end

NS_ASSUME_NONNULL_END
