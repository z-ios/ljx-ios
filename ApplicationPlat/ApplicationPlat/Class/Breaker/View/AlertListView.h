//
//  AlertListView.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/25.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertListView : UIView
@property(nonatomic, strong)void(^updateAlertHeight)(CGFloat height);
- (void)addData;
@end

NS_ASSUME_NONNULL_END
