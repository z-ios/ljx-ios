//
//  TopView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/23.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "TopView.h"
#import "BranchbreakViewModel.h"
@interface TopView ()
@property(nonatomic, copy)NSString *typeStr;
@property(nonatomic, strong)BranchbreakViewModel *branchViewModel;
@property(nonatomic, assign)BOOL isNormal;

@end


@implementation TopView
- (instancetype)initWithFrame:(CGRect)frame typeStr:(NSString *)typeStr
{
    self = [super initWithFrame:frame];
    if (self) {
        //        [self borderRoundCornerRadius:12];
        [self createUIWithTypeStr: typeStr];
        _typeStr = typeStr;
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = 12.5;
        self.layer.shadowColor = [UIColor colorWithRed:37/255.0 green:51/255.0 blue:75/255.0 alpha:0.1].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,5);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 10;
        _isNormal = YES;
    }
    return self;
}
- (void)createUIWithTypeStr:(NSString *)typeStr
{
    self.imageBtn = [[UIButton alloc]initWithFrame:CGRectMake(20 * WidthScale, 20 * HeightScale, 30 * WidthScale, 30 * WidthScale)];
    [self addSubview:_imageBtn];
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20 * WidthScale, _imageBtn.bottom + 13 * HeightScale, self.width - 40 * WidthScale, 25 * HeightScale)];
    _titleLab.textColor = ColorString(@"#1E2933");
    _titleLab.font = PingFangSCRegular(17);
    [self addSubview:_titleLab];
    self.detialLab = [[UILabel alloc]initWithFrame:CGRectMake(20 * WidthScale, _titleLab.bottom + 5 * HeightScale, self.width - 40 * WidthScale, 20 * HeightScale)];
    _detialLab.font = PingFangSCRegular(13);
    _detialLab.textColor = ColorString(@"#9CA3AB");
    
    [self addSubview:_detialLab];
    if ([typeStr isEqualToString:@"auto"]) {
        //        self.imageBtn.backgroundColor = ColorString(@"#FA6400");
        
        self.paperSwitch = [[RAMPaperSwitch alloc]initWithFrame:CGRectMake(self.width - 70.0f * WidthScale, 20 * HeightScale,50.0f * WidthScale, 24 * HeightScale) superView:self color:[UIColor colorWithWhite:1 alpha:0.35] bgColor:ColorString(@"#FA6400")];
        
        //        ColorString(@"#923A00")
    }else{
        //        self.imageBtn.backgroundColor = ColorString(@"#0091FF");
        
        self.paperSwitch = [[RAMPaperSwitch alloc]initWithFrame:CGRectMake(self.width - 70.0f * WidthScale, 20 * HeightScale,50.0f * WidthScale, 24 * HeightScale) superView:self color:[UIColor colorWithWhite:1 alpha:0.35] bgColor:ColorString(@"#0091FF")];
        
    }
    //    _paperSwitch.centerY = _detialLab.centerY;
    //    _paperSwitch.on = false;
    _paperSwitch.enabled = NO;
    _paperSwitch.userInteractionEnabled = YES;
    self.paperSwitch.transform = CGAffineTransformMakeScale(0.75,0.75);
    [self addSubview:self.paperSwitch];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(switTapGesture)]];
    
    
    
}
- (void)switTapGesture
{
    
    if ([self.typeStr isEqualToString:@"auto"]) {
        [self updateModeWithIsAuto:self.paperSwitch.isOn animation:self.paperSwitch.on duration:0.35];
        
    }else{
        if (self.paperSwitch.isOn) {
            [self breakerOpenWithonAnimation:self.paperSwitch.on duration:0.35 isTitle:NO];
        }else{
            [self breakerCloseWithonAnimation:self.paperSwitch.on duration:0.35 isTitle:NO];
        }
    }
}
- (void)setIId:(NSString *)iId
{
    _iId = iId;
}
- (void)setAddress_485:(NSString *)address_485
{
    _address_485 = address_485;
}

- (void)switchOnWithIsnormal:(BOOL)isNormal isAnimal:(BOOL)isAnimal
{
    
    [self.paperSwitch setOn:isAnimal animated:YES];
    
    
    CZHWeakSelf(self)
    _paperSwitch.swithTagBlock = ^(BOOL onAnimation) {
        weakself.isNormal = NO;
      
    };
    
    
    self.paperSwitch.animationDidStartClosure = ^(BOOL onAnimation) {
        if ([weakself.typeStr isEqualToString:@"auto"]) {
            [weakself animateLabelWithLable:weakself.titleLab onAnimation:onAnimation duration:0.35 isTitle:YES];
            [weakself animateLabelWithLable:weakself.detialLab onAnimation:onAnimation duration:0.35 isTitle:NO];
            [weakself animateLabelWithImageV:weakself.imageBtn onAnimation:onAnimation duration:0.35];
        }else{

            
            if (weakself.isNormal) {
                [weakself animateLabelWithLable:weakself.titleLab onAnimation:onAnimation duration:0.35 isTitle:YES];
                [weakself animateLabelWithLable:weakself.detialLab onAnimation:onAnimation duration:0.35 isTitle:NO];
                [weakself animateLabelWithImageV:weakself.imageBtn onAnimation:onAnimation duration:0.35];
//                NSLog(@"0000000000");
            }
            else{
                [weakself animateLabelWithLable:weakself.titleLab onAnimation:onAnimation duration:0.35 isTitle:YES];
                [weakself animateLabelWithLable:weakself.detialLab onAnimation:onAnimation duration:0.35 isTitle:NO];
                [weakself animateLabelWithImageV:weakself.imageBtn onAnimation:onAnimation duration:0.35];
            }
            
        }
        
        
    };
    self.paperSwitch.animationDidStopClosure = ^(BOOL onAnimation, BOOL finished) {

    };
    
}

- (void)updateModeWithIsAuto:(BOOL)isAuto animation:(BOOL)onAnimation duration:(NSTimeInterval)duration{
    
    NSString *aa = @"";
    if ([_address_485 isEqualToString:@"0"]) {
        aa = @"母开关";
        
    }else{
        aa = @"子开关";
        
    }
    NSString *autos = @"";
    if (isAuto) {
        autos = @"手动";
        
    }else{
        autos = @"自动";
        
    }
    NSString *num = _address_485.length == 1 ? [NSString stringWithFormat:@"0%@", _address_485]:[NSString stringWithFormat:@"%@", _address_485];
    NSString *str = [NSString stringWithFormat:@"确定将“%@%@”状态改为“%@”吗？",aa,num,autos ];
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setCancelBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *comAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setDefineBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self.deleagte respondsToSelector:@selector(presentTopViewWithAlert:isDismiss:)]) {
            [self.deleagte presentTopViewWithAlert:alertVc isDismiss:YES];
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"operator"] = @{@"id":Center.shared.userID};
        NSDictionary *dic = @{@"id":self.iId};
        params[@"device"] = dic;
        params[@"payload"] = @{@"address_485":self.address_485};
        
        [self.branchViewModel breakerModeWithParams:params isAuto:!isAuto Completion:^(BOOL success, NSString * _Nonnull errorMsg) {
            
            if (success) {
                NSLog(@"%@", [NSString stringWithFormat:@"更新------------------%d", !isAuto]);
                
                //                [weakself animateLabelWithLable:weakself.titleLab onAnimation:onAnimation duration:duration isTitle:YES];
                //                [weakself animateLabelWithLable:weakself.detialLab onAnimation:onAnimation duration:duration isTitle:NO];
                //                [weakself animateLabelWithImageV:weakself.imageBtn onAnimation:onAnimation duration:duration];
                //                [weakself.paperSwitch setOn:!isAuto animated:YES];
                
            }else{
                [CustomAlert alertVcWithMessage:errorMsg Vc:self.superview.viewController];
            }
        }];
        
        
    }];
    [alertVc addAction:cancleAc];
    [alertVc addAction:comAc];
    if ([self.deleagte respondsToSelector:@selector(presentTopViewWithAlert:isDismiss:)]) {
        [self.deleagte presentTopViewWithAlert:alertVc isDismiss:NO];
    }
    
}
- (void)animateLabelWithLable:(UILabel *)label onAnimation:(BOOL)onAnimation duration:(NSTimeInterval)duration isTitle:(BOOL)isTitle
{
    CZHWeakSelf(self)
    
    [UIView transitionWithView:label duration:duration options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        if (isTitle) {
            
            label.textColor = onAnimation ? [UIColor whiteColor] : ColorString(@"#1E2933");
            if ([weakself.typeStr isEqualToString:@"auto"]) {
                
                label.text = onAnimation? NSLocalizedString(@"breakerDeitalAutomatic", nil) : NSLocalizedString(@"breakerDeitalManual", nil);
            }else{
                
                label.text = onAnimation ?    NSLocalizedString(@"breakerDeitalClose", nil) : NSLocalizedString(@"breakerDeitalOpen", nil);
            }
            
        }else{
            label.textColor = onAnimation ? [UIColor whiteColor] : ColorString(@"#9CA3AB");
            
        }
        
    } completion:nil];
    
}
#pragma mark --  合闸
-(void)breakerCloseWithonAnimation:(BOOL)onAnimation duration:(NSTimeInterval)duration isTitle:(BOOL)isTitle
{
    
    
    CZHWeakSelf(self)
    NSString *aa = @"";
    if ([_address_485 isEqualToString:@"0"]) {
        aa = @"母开关";
        
    }else{
        aa = @"子开关";
        
    }
    NSString *num = _address_485.length == 1 ? [NSString stringWithFormat:@"0%@", _address_485]:[NSString stringWithFormat:@"%@", _address_485];
    NSString *str = [NSString stringWithFormat:@"确定将“%@%@”状态改为“合闸”吗？",aa,num ];
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setCancelBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *comAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setDefineBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self.deleagte respondsToSelector:@selector(presentTopViewWithAlert:isDismiss:)]) {
            [self.deleagte presentTopViewWithAlert:alertVc isDismiss:YES];
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"operator"] = @{@"id":Center.shared.userID,@"username":Center.shared.userName};
        NSDictionary *dic = @{@"address_485":weakself.address_485,@"id":weakself.iId};
        params[@"device"] = dic;
        params[@"payload"] = @{};
        
        [self.branchViewModel breakerCloseWithParams:params Completion:^(BOOL success, NSString * _Nonnull errorMsg) {
            
            if (success) {
                //                [weakself animateLabelWithLable:weakself.titleLab onAnimation:onAnimation duration:duration isTitle:YES];
                //                [weakself animateLabelWithLable:weakself.detialLab onAnimation:onAnimation duration:duration isTitle:NO];
                //                [weakself animateLabelWithImageV:weakself.imageBtn onAnimation:onAnimation duration:duration];
                //                [weakself.paperSwitch setOn:YES animated:YES];
                
            }else{
                [CustomAlert alertVcWithMessage:errorMsg Vc:self.superview.viewController];
            }
        }];
        
        
    }];
    [alertVc addAction:cancleAc];
    [alertVc addAction:comAc];
    if ([self.deleagte respondsToSelector:@selector(presentTopViewWithAlert:isDismiss:)]) {
        [self.deleagte presentTopViewWithAlert:alertVc isDismiss:NO];
    }
    
    
    
    
    
    
}
#pragma mark --  开闸
-(void)breakerOpenWithonAnimation:(BOOL)onAnimation duration:(NSTimeInterval)duration isTitle:(BOOL)isTitle
{
    
    CZHWeakSelf(self)
    NSString *aa = @"";
    if ([_address_485 isEqualToString:@"0"]) {
        aa = @"母开关";
        
    }else{
        aa = @"子开关";
        
    }
    NSString *num = _address_485.length == 1 ? [NSString stringWithFormat:@"0%@", _address_485]:[NSString stringWithFormat:@"%@", _address_485];
    NSString *str = [NSString stringWithFormat:@"确定将“%@%@”状态改为“跳闸”吗？",aa,num ];
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setCancelBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *comAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setDefineBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self.deleagte respondsToSelector:@selector(presentTopViewWithAlert:isDismiss:)]) {
            [self.deleagte presentTopViewWithAlert:alertVc isDismiss:YES];
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"operator"] = @{@"id":Center.shared.userID,@"username":Center.shared.userName};
        NSDictionary *dic = @{@"address_485":weakself.address_485,@"id":weakself.iId};
        params[@"device"] = dic;
        params[@"payload"] = @{};
        
        [self.branchViewModel breakerOpenWithParams:params Completion:^(BOOL success, NSString * _Nonnull errorMsg) {
            if (success) {
                //                [weakself animateLabelWithLable:weakself.titleLab onAnimation:onAnimation duration:duration isTitle:YES];
                //                [weakself animateLabelWithLable:weakself.detialLab onAnimation:onAnimation duration:duration isTitle:NO];
                //                [weakself animateLabelWithImageV:weakself.imageBtn onAnimation:onAnimation duration:duration];
                //                NSLog(@"开闸------------------");
                //                [weakself.paperSwitch setOn:NO animated:YES];
                
                
            }else{
                [CustomAlert alertVcWithMessage:errorMsg Vc:self.superview.viewController];
            }
        }];
        
    }];
    [alertVc addAction:cancleAc];
    [alertVc addAction:comAc];
    if ([self.deleagte respondsToSelector:@selector(presentTopViewWithAlert:isDismiss:)]) {
        [self.deleagte presentTopViewWithAlert:alertVc isDismiss:NO];
    }
    
    
    
    
}
- (void)animateLabelWithImageV:(UIButton *)imageV onAnimation:(BOOL)onAnimation duration:(NSTimeInterval)duration
{
    CZHWeakSelf(self)
    
    [UIView transitionWithView:imageV duration:duration options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        if ([weakself.typeStr isEqualToString:@"auto"]) {
            [imageV setImage:onAnimation ? [UIImage imageNamed:@"icon_mode-s"]:[UIImage imageNamed:@"icon_mode-n"] forState:UIControlStateNormal];
        }else{
            [imageV setImage:onAnimation ? [UIImage imageNamed:@"icon_stats-s"]:[UIImage imageNamed:@"icon_stats-n"] forState:UIControlStateNormal];
            
        }
        
        
    } completion:nil];
}
- (BranchbreakViewModel *)branchViewModel
{
    if (_branchViewModel == nil) {
        _branchViewModel = [[BranchbreakViewModel alloc]init];
    }
    return _branchViewModel;
}
@end
