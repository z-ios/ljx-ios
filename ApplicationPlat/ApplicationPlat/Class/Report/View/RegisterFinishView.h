//
//  RegisterFinishView.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/5.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol RegisterFinishViewDelegate <NSObject>

- (void)registerFinishNextPageWithParams:(NSDictionary *)params;
- (void)registerFinishBackPage;

@end
@interface RegisterFinishView : UIView
@property(nonatomic, assign)id <RegisterFinishViewDelegate>delagte;

@property(nonatomic, strong)NSMutableDictionary *paramsDic;
@end

NS_ASSUME_NONNULL_END
