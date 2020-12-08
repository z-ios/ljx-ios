//
//  NewBreakerListCell.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/12.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "NewBreakerListCell.h"
#import "BranchbreakViewModel.h"
#import "ModeAlertView.h"
#import "AlertTypeView.h"
#import "ZQTColorSwitch.h"
@interface NewBreakerListCell ()
@property(nonatomic, strong)UIView *bgView;
@property(nonatomic, strong)UILabel *titleLab;
@property(nonatomic, strong)UILabel *switLab;

@property(nonatomic, strong)UILabel *numLab;
@property(nonatomic, strong)UILabel *kwhLab;
@property(nonatomic, strong)UILabel *kwLab;
@property(nonatomic, strong)UILabel *volLab;
@property(nonatomic, strong)UILabel *curLab;
@property(nonatomic, strong)UILabel *templateLab;
@property(nonatomic, strong)UILabel *alertNumLab;
//@property(nonatomic, strong)UISwitch *swit;
@property(nonatomic, strong)ZQTColorSwitch *openSwitch;
@property(nonatomic, strong)UIButton *alertBtn;
@property(nonatomic, strong)UIButton *modeBtn;

@property(nonatomic, strong)BranchbreakViewModel *branchViewModel;

@end


@implementation NewBreakerListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = ColorString(@"#F4F6FC");
        self.contentView.backgroundColor = ColorString(@"#FE4F4C");
       
        
        if (@available(iOS 13,*)) {
            self.contentView.layer.cornerRadius = 12;
            self.contentView.layer.masksToBounds = YES;
            
            self.layer.cornerRadius = 12;
            self.layer.shadowColor =[UIColor colorWithRed:37/255.0 green:51/255.0 blue:75/255.0 alpha:0.19].CGColor;;
            self.layer.shadowOpacity = 1;
            self.layer.shadowRadius = 6;
            self.layer.shadowOffset = CGSizeMake(0,0);
//            self.layer.borderColor = self.layer.shadowColor; // 边框颜色建议和阴影颜色一致
//            self.layer.borderWidth = 0.000001; // 只要不为0就行
        }else{
            self.contentView.layer.cornerRadius = 12;
            self.layer.cornerRadius = 12;
            self.layer.masksToBounds = YES;
            self.layer.shadowColor =[UIColor colorWithRed:37/255.0 green:51/255.0 blue:75/255.0 alpha:0.19].CGColor;;
            self.layer.borderColor = self.layer.shadowColor; // 边框颜色建议和阴影颜色一致
            self.layer.borderWidth = 0.5; // 只要不为0就行
        }
        
    
        

        [self createUI];
    }
    return self;
}
- (void)createUI
{
    CGFloat titleW = 34 * WidthScale;
    CGFloat leftW = self.width/2;
    self.bgView = [[UIView alloc]initWithFrame:self.contentView.frame];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bgView];
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20 * WidthScale, 15 * HeightScale, 60 * WidthScale, 24 * HeightScale)];
    _titleLab.font = PingFangSCMedium(16);
    _titleLab.textColor = ColorString(@"#121212");
    [_bgView addSubview:_titleLab];
    
    self.numLab = [[UILabel alloc]initWithFrame:CGRectMake(_titleLab.right + 8 * WidthScale, 20 * HeightScale, 30 * WidthScale, 20 * HeightScale)];
    _numLab.textAlignment = NSTextAlignmentCenter;
    if (IS_IPHONE_8 || IS_IPHONE_8P) {
        _numLab.font = [UIFont fontWithName:@"DINCondensed-Bold" size:18];
    }else{
        _numLab.font = [UIFont fontWithName:@"DINCondensed-Bold" size:20];
        
    }
    _numLab.textColor = ColorString(@"#0090FD");
    [_bgView addSubview:_numLab];
    CAShapeLayer *layer3 =  [UIView drawRect:CGRectMake(_titleLab.right + 8 * WidthScale, 15 * HeightScale, 30 * WidthScale, 24 * HeightScale) radius:2 color:ColorString(@"#0090FD")];
    [_bgView.layer addSublayer:layer3];
    
    self.openSwitch = [[ZQTColorSwitch alloc]initWithFrame:CGRectMake(self.contentView.width - 60.0f * WidthScale, 15 * HeightScale,40.0f * WidthScale, 24 * HeightScale)];
    _openSwitch.enabled = NO;
    _openSwitch.thumbTintColor = [UIColor whiteColor];
    _openSwitch.tintColor = [UIColor colorWithHex:@"#787880" alpha:0.16];
    UIView *switView = [[UIView alloc]initWithFrame:CGRectMake(self.contentView.width - 65.0f * WidthScale, 0, 64, 52 * HeightScale)];
    [_bgView addSubview:switView];
    [switView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switOpenOrClose)]];
    _openSwitch.centerY = _numLab.centerY;
    [_bgView addSubview:_openSwitch];
    
    self.switLab = [[UILabel alloc]initWithFrame:CGRectMake(_openSwitch.x - 44 * WidthScale, 15 * HeightScale, titleW, 24 * HeightScale)];
    
    _switLab.font = PingFangSCRegular(14);
    _switLab.textColor = ColorString(@"#8F9FB3");
    _openSwitch.centerY = _switLab.centerY;
    switView.centerY = _switLab.centerY;
    [_bgView addSubview:_switLab];
    
    CAShapeLayer *layer =   [UIView drawRect:CGRectMake(25 * WidthScale, _switLab.bottom+ 13 * HeightScale, self.width - 50 * WidthScale, 0.5) radius:0 color:[UIColor colorWithHex:@"#000000" alpha:0.08]];
    [_bgView.layer addSublayer:layer];
    
    
    UILabel *kwhTitleLab = [UILabel labelWithframe:CGRectMake(25 * WidthScale,_switLab.bottom+ 33 * HeightScale + 1, titleW, 30 * HeightScale) title:@"电量" font:PingFangSCRegular(14) color:ColorString(@"#8F9FB3") line:0];
    [_bgView addSubview:kwhTitleLab];
    
    
    self.kwhLab = [[UILabel alloc]initWithFrame:CGRectMake(kwhTitleLab.right, kwhTitleLab.bottom + 5 * HeightScale, self.contentView.width / 2 -  kwhTitleLab.right - titleW - 10* WidthScale, 32 * HeightScale)];
    _kwhLab.font =[UIFont fontWithName:@"DINCondensed-Bold" size:25];
    _kwhLab.textColor = ColorString(@"#0091FF");
    _kwhLab.adjustsFontSizeToFitWidth = YES;
    [_bgView addSubview:_kwhLab];
    UILabel *_label5 = [[UILabel alloc]initWithFrame:CGRectMake(_kwhLab.right + 5 * WidthScale, kwhTitleLab.bottom + 17 * HeightScale, titleW, 20 * HeightScale)];
    _label5.text = @"kWh";
    _label5.font = PingFangSCRegular(14);
    _label5.textColor = ColorString(@"#8F9FB3");
    [_bgView addSubview:_label5];
    
    UILabel *kwTitleLab = [UILabel labelWithframe:CGRectMake(25 * WidthScale,_kwhLab.bottom+ 10 * HeightScale, titleW, 30 * HeightScale) title:@"功率" font:PingFangSCRegular(14) color:ColorString(@"#8F9FB3") line:0];
    [_bgView addSubview:kwTitleLab];
    
    self.kwLab = [[UILabel alloc]initWithFrame:CGRectMake(kwTitleLab.right, kwTitleLab.bottom + 10 * HeightScale, self.contentView.width / 2 -  kwTitleLab.right - titleW - 10* WidthScale, 32 * HeightScale)];
    _kwLab.font =[UIFont fontWithName:@"DINCondensed-Bold" size:25];
    _kwLab.textColor = ColorString(@"#26C464");
    _kwLab.adjustsFontSizeToFitWidth = YES;
    [_bgView addSubview:_kwLab];
    UILabel *kwlabel = [[UILabel alloc]initWithFrame:CGRectMake(_kwLab.right + 5 * WidthScale, kwTitleLab.bottom + 17 * HeightScale, titleW, 20 * HeightScale)];
    kwlabel.text = @"kW";
    kwlabel.font = PingFangSCRegular(14);
    kwlabel.textColor = ColorString(@"#8F9FB3");
    [_bgView addSubview:kwlabel];
    
    UIButton *volImageV = [[UIButton alloc]initWithFrame:CGRectMake(leftW + 25  * WidthScale, _switLab.bottom+ 40 * HeightScale + 1, 24 * WidthScale, 24 * WidthScale)];
    volImageV.userInteractionEnabled = NO;
    [volImageV setImage:[UIImage imageNamed:@"icon_dianya"] forState:UIControlStateNormal];
    [_bgView addSubview:volImageV];
    
    UILabel *vlabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width - 50 * WidthScale, 0, 10 * WidthScale, 24 * HeightScale)];
    vlabel.text = @"V";
    vlabel.font = PingFangSCRegular(14);
    vlabel.textColor = ColorString(@"#8F9FB3");
    vlabel.centerY = volImageV.centerY;
    [_bgView addSubview:vlabel];
    
    
    self.volLab = [[UILabel alloc]initWithFrame:CGRectMake(volImageV.right+ 10  * WidthScale, 0, self.contentView.width  -  volImageV.right - vlabel.width - 35* WidthScale, 24 * HeightScale)];
    _volLab.font = PingFangSCRegular(16);
    _volLab.textColor = ColorString(@"#121212");
    _volLab.adjustsFontSizeToFitWidth = YES;
    _volLab.centerY = volImageV.centerY;
    [_bgView addSubview:_volLab];
    
    
    UIButton *cImageV = [[UIButton alloc]initWithFrame:CGRectMake(leftW + 25  * WidthScale, volImageV.bottom+ 35 * HeightScale , 24 * WidthScale, 24 * WidthScale)];
    cImageV.userInteractionEnabled = NO;
    [cImageV setImage:[UIImage imageNamed:@"icon_dianliu"] forState:UIControlStateNormal];
    [_bgView addSubview:cImageV];
    
    UILabel *clabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width - 50 * WidthScale, 0, 10 * WidthScale, 24 * HeightScale)];
    clabel.text = @"A";
    clabel.font = PingFangSCRegular(14);
    clabel.textColor = ColorString(@"#8F9FB3");
    clabel.centerY = cImageV.centerY;
    [_bgView addSubview:clabel];
    
    
    self.curLab = [[UILabel alloc]initWithFrame:CGRectMake(cImageV.right+ 10  * WidthScale, 0, self.contentView.width -  cImageV.right - clabel.width - 35* WidthScale, 24 * HeightScale)];
    _curLab.font = PingFangSCRegular(16);
    _curLab.textColor = ColorString(@"#121212");
    _curLab.adjustsFontSizeToFitWidth = YES;
    _curLab.centerY = cImageV.centerY;
    [_bgView addSubview:_curLab];
    
    UIButton *tempImageV = [[UIButton alloc]initWithFrame:CGRectMake(leftW + 25  * WidthScale, cImageV.bottom+ 35 * HeightScale, 24 * WidthScale, 24 * WidthScale)];
    tempImageV.userInteractionEnabled = NO;
    [tempImageV setImage:[UIImage imageNamed:@"icon_wendu"] forState:UIControlStateNormal];
    [_bgView addSubview:tempImageV];
    
    UILabel *templabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width - 50 * WidthScale, 0, 10 * WidthScale, 24 * HeightScale)];
    templabel.text = @"℃";
    templabel.font = PingFangSCRegular(14);
    templabel.textColor = ColorString(@"#8F9FB3");
    templabel.centerY = tempImageV.centerY;
    [_bgView addSubview:templabel];
    
    
    self.templateLab = [[UILabel alloc]initWithFrame:CGRectMake(tempImageV.right + 10  * WidthScale, 0, self.contentView.width  -  tempImageV.right - templabel.width - 35* WidthScale, 24 * HeightScale)];
    _templateLab.font = PingFangSCRegular(16);
    _templateLab.textColor = ColorString(@"#121212");
    _templateLab.adjustsFontSizeToFitWidth = YES;
    _templateLab.centerY = tempImageV.centerY;
    [_bgView addSubview:_templateLab];
    
    // 未完成 kwhTitleLab
    UIView *selectView = [[UIView alloc]initWithFrame:CGRectMake(0, kwhTitleLab.y - 15 * HeightScale, _bgView.width,templabel.y - 15 * HeightScale)];
    selectView.centerX = _bgView.centerX;
//    selectView.backgroundColor = [UIColor redColor];
    [selectView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAction )]];
    [_bgView addSubview:selectView];
    
    
    CAShapeLayer *layer1 =   [UIView drawRect:CGRectMake(25 * WidthScale, tempImageV.bottom+ 23 * HeightScale, self.width - 50 * WidthScale, 0.5) radius:0 color:[UIColor colorWithHex:@"#000000" alpha:0.08]];
    [_bgView.layer addSublayer:layer1];
    
    
    self.alertBtn = [[UIButton alloc]initWithFrame:CGRectMake(25 * WidthScale, tempImageV.bottom+ 24 * HeightScale, 45 * WidthScale, 54 * HeightScale)];
    [_alertBtn setTitle:@"告警" forState:UIControlStateNormal];
    [_alertBtn setTitleColor:ColorString(@"#121212") forState:UIControlStateNormal];
    _alertBtn.titleLabel.font = PingFangSCRegular(14);
    [_alertBtn addTarget:self action:@selector(alertBtnAction ) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_alertBtn];
    
    UILabel *modeLab = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.width - 70 * WidthScale - 100 * WidthScale, tempImageV.bottom+ 35 * HeightScale, 60 * WidthScale, 30 * HeightScale)];
    modeLab.text = @"工作模式";
    
    modeLab.font = PingFangSCRegular(14);
    modeLab.textColor = ColorString(@"#8F9FB3");
    [_bgView addSubview:modeLab];
    
    
    self.modeBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.contentView.width - 100 * WidthScale, tempImageV.bottom+ 24 * HeightScale, 80* WidthScale, 54 * HeightScale)];
    [_modeBtn setTitle:@"手动" forState:UIControlStateNormal];
    [_modeBtn setImage:[UIImage imageNamed:@"icon_arrow_more"] forState:UIControlStateNormal];
    [_modeBtn setTitleColor:ColorString(@"#121212") forState:UIControlStateNormal];
    _modeBtn.titleLabel.font = PingFangSCRegular(14);
    [_modeBtn addTarget:self action:@selector(modeBtnAction ) forControlEvents:UIControlEventTouchUpInside];
    modeLab.centerY = _modeBtn.centerY;
    [_bgView addSubview:_modeBtn];
    
    // button标题的偏移量
    _modeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -_modeBtn.imageView.bounds.size.width+2, 0, _modeBtn.imageView.bounds.size.width);
    // button图片的偏移量
    _modeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, _modeBtn.titleLabel.bounds.size.width, 0, -_modeBtn.titleLabel.bounds.size.width);
    
    self.alertNumLab = [[UILabel alloc]initWithFrame:CGRectMake(5 * WidthScale,17 * HeightScale , 30 * WidthScale, 20 * HeightScale)];
    _alertNumLab.font = PingFangSCRegular(13);
    _alertNumLab.textColor = [UIColor whiteColor];
    [_alertNumLab borderRoundCornerRadius:10 * HeightScale];
    _alertNumLab.adjustsFontSizeToFitWidth = YES;
    _alertNumLab.userInteractionEnabled = YES;
    // 未完成
    _alertNumLab.text = @"0";
    _alertNumLab.backgroundColor = ColorString(@"#C5CED4");
    _alertNumLab.textAlignment = NSTextAlignmentCenter;
    
    UIView *alertNumView = [[UIView alloc]initWithFrame:CGRectMake(_alertBtn.right + 5  * WidthScale, _alertBtn.y , 50* WidthScale, _alertBtn.height)];
    [alertNumView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alertBtnAction )]];

    [_bgView addSubview:alertNumView];
    [alertNumView addSubview:_alertNumLab];
    
    
}
#pragma mark -- 点击cell
- (void)selectAction
{
    if ([self.delea respondsToSelector:@selector(selecCellWithModel:)]) {
        [self.delea selecCellWithModel:_mainModel];
    }
}
#pragma mark --  告警

- (void)alertBtnAction
{
    
    CGFloat h = 0;
    if (IS_IPHONE_8P) {
        h = 400 * HeightScale;
    }else{
        h = 350 * HeightScale;
        
    }
    AlertTypeView *alertTypeView = [[AlertTypeView alloc]initWithFrame:CGRectMake(15 * WidthScale, 0, KScreenWidth - 30 * WidthScale, h)];
    FFToast *customDateViewToast = [[FFToast alloc]initCentreToastWithView:alertTypeView autoDismiss:NO duration:3 enableDismissBtn:NO dismissBtnImage:[UIImage imageNamed:@"icon_close"]];
    
    [customDateViewToast show];
    alertTypeView.determineBlock = ^{
        [customDateViewToast dismissCentreToast];
        
    };
    
    
}
#pragma mark --  改变模式
- (void)modeBtnAction
{
    CGFloat h = 0;
    if (IS_IPHONE_8P) {
        h = 400 * HeightScale;
    }else{
        h = 350 * HeightScale;
        
    }
    ModeAlertView *modeView = [[ModeAlertView alloc]initWithFrame:CGRectMake(15 * WidthScale, 0, KScreenWidth - 30 * WidthScale, h)];
    FFToast *customDateViewToast = [[FFToast alloc]initCentreToastWithView:modeView autoDismiss:NO duration:3 enableDismissBtn:NO dismissBtnImage:[UIImage imageNamed:@"icon_close"]];
    if ([_modeBtn.currentTitle isEqualToString:NSLocalizedString(@"breakerManualIcon", nil)]) {
        
        modeView.modeStr = @"matue";
    }else{
        modeView.modeStr = @"auto";
        
    }
    
    [customDateViewToast show];
    CZHWeakSelf(self)
    modeView.determineBlock = ^{
        [customDateViewToast dismissCentreToast];
        
    };
    modeView.comBtnActionBlock = ^(NSString * _Nonnull modeString) {
        [customDateViewToast dismissCentreToast];
        [weakself updateModeWithIsAuto:[modeString isEqualToString:@"auto"]];
//        if ([modeString isEqualToString:@"auto"]) {
//            [weakself.modeBtn setTitle:NSLocalizedString(@"breakerAtuoIcon", nil) forState:UIControlStateNormal];
//
//        }else{
//            [weakself.modeBtn setTitle:NSLocalizedString(@"breakerManualIcon", nil) forState:UIControlStateNormal];
//
//        }
    };
   
}

- (void)updateModeWithIsAuto:(BOOL)isAuto{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"operator"] = @{@"id":Center.shared.userID};
    NSDictionary *dic = @{@"id":self.iId};
    params[@"device"] = dic;
    params[@"payload"] = @{@"address_485":self.mainModel.address_485};
    CZHWeakSelf(self)
    [self.branchViewModel breakerModeWithParams:params isAuto:isAuto Completion:^(BOOL success, NSString * _Nonnull errorMsg) {
        if (success) {
            
            NSLog(@"%@", [NSString stringWithFormat:@"更新------------------%d", isAuto]);

        }else{
            [CustomAlert alertVcWithMessage:errorMsg Vc:weakself.superview.viewController];
        }
    }];
}


#pragma mark -- 开合闸
- (void)switOpenOrCloseChange:(UISwitch *)swith
{
    if (swith.isOn) {
        swith.on = NO;
    }else{
        swith.on = YES;

    }
    
}

- (void)switOpenOrClose
{
    if (!_openSwitch.isOn) {
        [self breakerCloseWithSwith:_openSwitch];

    }else{
        [self breakerOpenWithSwith:_openSwitch];
    }
}
#pragma mark --  合闸
-(void)breakerCloseWithSwith:(ZQTColorSwitch *)swith
{
//    swith.on = NO;
    CZHWeakSelf(self)
    NSString *aa = @"";
    if ([_mainModel.address_485 isEqualToString:@"0"]) {
        aa = @"母开关";
        
    }else{
        aa = @"子开关";
        
    }

    NSString *num =  _mainModel.address_485_pad;

    NSString *str = [NSString stringWithFormat:@"确定将“%@%@”状态改为“合闸”吗？",aa,num ];
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setCancelBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *comAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setDefineBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self.delea respondsToSelector:@selector(presentWithAlert:isDismiss:)]) {
            [self.delea presentWithAlert:alertVc isDismiss:YES];
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"operator"] = @{@"id":Center.shared.userID};
        NSDictionary *dic = @{@"id":weakself.iId};
        params[@"device"] = dic;
        params[@"payload"] = @{@"address_485":weakself.mainModel.address_485};
        
        [self.branchViewModel breakerCloseWithParams:params Completion:^(BOOL success, NSString * _Nonnull errorMsg) {
            
            if (success) {
                
//                swith.on = YES;
//                weakself.switLab.text = @"合闸";
                
                NSLog(@"合闸------------------");
            }else{
                [CustomAlert alertVcWithMessage:errorMsg Vc:weakself.superview.viewController];
            }
        }];
        
        
    }];
    [alertVc addAction:cancleAc];
    [alertVc addAction:comAc];
    if ([self.delea respondsToSelector:@selector(presentWithAlert:isDismiss:)]) {
        [self.delea presentWithAlert:alertVc isDismiss:NO];
    }
    
    
    
    
}
#pragma mark --  开闸
-(void)breakerOpenWithSwith:(ZQTColorSwitch *)swith
{
    CZHWeakSelf(self)
    NSString *aa = @"";
    if ([_mainModel.address_485 isEqualToString:@"0"]) {
        aa = @"母开关";
        
    }else{
        aa = @"子开关";
        
    }
//    swith.on = YES;
    NSString *num =  _mainModel.address_485_pad;

    NSString *str = [NSString stringWithFormat:@"确定将“%@%@”状态改为“跳闸”吗？",aa,num ];
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setCancelBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    
    UIAlertAction *comAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setDefineBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self.delea respondsToSelector:@selector(presentWithAlert:isDismiss:)]) {
            [self.delea presentWithAlert:alertVc isDismiss:YES];
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"operator"] = @{@"id":Center.shared.userID};
        NSDictionary *dic = @{@"id":weakself.iId};
        params[@"device"] = dic;
        params[@"payload"] = @{@"address_485":weakself.mainModel.address_485};
        [self.branchViewModel breakerOpenWithParams:params Completion:^(BOOL success, NSString * _Nonnull errorMsg) {
            
            if (success) {
                
//                swith.on = NO;
//                weakself.switLab.text = @"跳闸";
                
                NSLog(@"开闸------------------");
                
            }else{
                [CustomAlert alertVcWithMessage:errorMsg Vc:self.superview.viewController];
            }
        }];
        
    }];
    [alertVc addAction:cancleAc];
    [alertVc addAction:comAc];
    if ([self.delea respondsToSelector:@selector(presentWithAlert:isDismiss:)]) {
        [self.delea presentWithAlert:alertVc isDismiss:NO];
    }
}
- (void)setMainModel:(MainbreakerModel *)mainModel
{
    _mainModel = mainModel;

    PropertiesModel *proModel = mainModel.data_properties;

    if ([proModel.work_mode.parsed_data isEqualToString:@"M"]) {
        [_modeBtn setTitle:NSLocalizedString(@"breakerManualIcon", nil) forState:UIControlStateNormal];
        
    }else{
        [_modeBtn setTitle:NSLocalizedString(@"breakerAtuoIcon", nil) forState:UIControlStateNormal];
        
    }
    if ([mainModel.address_485 isEqualToString:@"0"]) {
        _titleLab.text = @"母开关";
        
    }else{
        _titleLab.text = @"子开关";
        
    }
    _kwLab.text = proModel.power.parsed_data?proModel.power.parsed_data:@"0.00";
    _volLab.text = proModel.voltage.parsed_data?proModel.voltage.parsed_data:@"0.00";
    _templateLab.text = proModel.temperature.parsed_data?proModel.temperature.parsed_data:@"0.00";
    
    _curLab.text = proModel.electric_current.parsed_data?proModel.electric_current.parsed_data:@"0.00";
    
    _numLab.text = mainModel.address_485_pad;

    NSString *str = proModel.electric_quantity.parsed_data ? [proModel.electric_quantity.parsed_data componentsSeparatedByString:@","][0]: @"0.00";
    _kwhLab.text = str;
    
    NSString *openStr = [proModel.open_close.raw_data substringToIndex:2];
    _openSwitch.on = ![openStr isEqualToString:@"01"];
    _switLab.text = [proModel.open_close.parsed_data isEqualToString:@"-.-"]?@"合闸": proModel.open_close.parsed_data;
    if ([openStr isEqualToString:@"01"]) {
        
        
    }else{
        
        if ([mainModel.address_485 isEqualToString:@"0"]) {
            _openSwitch.onTintColor = ColorString(@"#0091FF");
            
        }else{
            _openSwitch.onTintColor = ColorString(@"#3BC4A6");
            
        }
        
    }
    
    
}
- (void)setFrame:(CGRect)frame
{
    frame.origin.x += 20 * WidthScale;
    frame.origin.y +=10 * HeightScale;
    if (IS_IPHONE_8 || IS_IPHONE_8P) {
        
        frame.size.height = 320 * HeightScale;
    }else{
        frame.size.height = 300 * HeightScale;
        
    }
    frame.size.width = KScreenWidth- 40 * WidthScale;
    [super setFrame:frame];
}
- (BranchbreakViewModel *)branchViewModel
{
    if (_branchViewModel == nil) {
        _branchViewModel = [[BranchbreakViewModel alloc]init];
    }
    return _branchViewModel;
}

@end
