//
//  ReportFinishController.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/6.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReportFinishController : UIViewController
@property(nonatomic, strong)NSDictionary *feedBackDic;
@property(nonatomic, strong)void(^backBlock)(void);
@end

NS_ASSUME_NONNULL_END
