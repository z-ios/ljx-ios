//
//  IothubSenceView.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/3.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "IothubModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol IothubSenceViewDelegate <NSObject>

- (void)iothubNextPageWithIotModel:(IothubModel *)model;
- (void)iothubBackPage;

@end
@interface IothubSenceView : UIView
@property(nonatomic, strong)CustomTextField *customText;

@property(nonatomic, assign)id <IothubSenceViewDelegate>delagte;
@end

NS_ASSUME_NONNULL_END
