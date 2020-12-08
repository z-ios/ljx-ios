//
//  TopView.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/23.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RAMPaperSwitch.h"
NS_ASSUME_NONNULL_BEGIN
@protocol TopViewCellDelagte <NSObject>

- (void)presentTopViewWithAlert:(UIAlertController *)alert isDismiss:(BOOL)isDiss;

@end
@interface TopView : UIView
@property(nonatomic, strong)UIButton *imageBtn;
@property(nonatomic, strong)UILabel *titleLab;
@property(nonatomic, strong)UILabel *detialLab;
@property(nonatomic, strong)RAMPaperSwitch *paperSwitch;
@property(nonatomic, copy)NSString *address_485;
@property(nonatomic, copy)NSString *iId;
@property(nonatomic, assign)id <TopViewCellDelagte>deleagte;

- (void)switchOnWithIsnormal:(BOOL)isNormal isAnimal:(BOOL)isAnimal;
- (instancetype)initWithFrame:(CGRect)frame typeStr:(NSString *)typeStr;
@end

NS_ASSUME_NONNULL_END
