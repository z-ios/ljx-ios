//
//  IothubSenceView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/3.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "IothubSenceView.h"
#import "LDYSelectivityAlertView.h"
#import "ReportViewModel.h"
#import "LMJDropdownMenu.h"
#import "CustomLabView.h"
@interface IothubSenceView ()<LDYSelectivityAlertViewDelegate,UITextFieldDelegate,LMJDropdownMenuDelegate,LMJDropdownMenuDataSource>
@property(nonatomic, strong)ReportViewModel *reportViewModel;
@property(nonatomic, strong)UIButton *nextBtn;
@property(nonatomic, strong)UIView *iotDetailView;
@property(nonatomic, strong)CustomLabView *ipView;
@property(nonatomic, strong)CustomLabView *apiPortView;
@property(nonatomic, strong)CustomLabView *mqttPortView;
@property(nonatomic, strong)CustomLabView *httpView;
@property(nonatomic, strong)CustomLabView *versionView;
@property(nonatomic, strong)NSArray *dataArray;
@property(nonatomic, strong)IothubModel *iotModel;
@property(nonatomic, strong)LMJDropdownMenu *dropMenu;
@property(nonatomic, assign)BOOL isFirst;
@end

@implementation IothubSenceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = KScreenWidth;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight|UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(36, 36)];

        CAShapeLayer *layer = [[CAShapeLayer alloc] init];

        layer.frame = self.bounds;

        layer.path = path.CGPath;

        self.layer.mask = layer;
        self.isFirst = YES;
        [self moreAction];
        [self createUI];
        
        
        
    }
    return self;
}

- (void)createUI
{
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(25 * WidthScale, 30 * HeightScale, 250, 33 * HeightScale)];
    titleLab.text = @"指定IoTHub实例";
    titleLab.textColor = ColorString(@"#121212");
    titleLab.font = PingFangSCMedium(20);
    [self addSubview:titleLab];
    
    UILabel *subtitleLab = [[UILabel alloc]initWithFrame:CGRectMake(25 * WidthScale,titleLab.bottom + 15 * HeightScale, 80, 33 * HeightScale)];
    subtitleLab.text = @"实例名称";
    subtitleLab.textColor = ColorString(@"#808080");
    subtitleLab.font = PingFangSCRegular(14);
    [self addSubview:subtitleLab];
    
    
//    self.customText = [[CustomTextField alloc]initWithFrame:CGRectMake(25 * WidthScale,subtitleLab.bottom + 3 * HeightScale, self.width - 50 * WidthScale, 48 * HeightScale) isLine:NO];
//    _customText.textField.font = PingFangSCRegular(16);
//    _customText.textField.textColor = ColorString(@"#121212");
//    [_customText.functionBtn setImage:[UIImage imageNamed:@"icon_arrow_more"] forState:UIControlStateNormal];
//    [_customText.functionBtn addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
//    _customText.textField.delegate = self;
//    [self addSubview:_customText];
    
    
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(25 * WidthScale, subtitleLab.bottom + 3 * HeightScale, self.width - 50 * WidthScale, 48 * HeightScale)];
//    [bgview border:[UIColor colorWithWhite:0 alpha:0.19] width:1 CornerRadius:4];

    [self addSubview:bgview];
    
    self.dropMenu = [[LMJDropdownMenu alloc] init];
    [_dropMenu setFrame:CGRectMake(0, 0, bgview.width, 48 * HeightScale)];
    _dropMenu.dataSource = self;
    _dropMenu.delegate   = self;

    [_dropMenu border:[UIColor colorWithWhite:0 alpha:0.19] width:1 CornerRadius:4];

    _dropMenu.title           = @"";
    _dropMenu.titleBgColor    = ColorString(@"#F6F8FA");
    _dropMenu.titleFont       = PingFangSCRegular(16);
    _dropMenu.titleColor      =  ColorString(@"#121212");
    _dropMenu.titleAlignment  = NSTextAlignmentLeft;
    _dropMenu.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    
    _dropMenu.rotateIcon      = [UIImage imageNamed:@"icon_arrow_more"];
    _dropMenu.rotateIconSize  = CGSizeMake(15, 15);
    
    _dropMenu.optionBgColor         = [UIColor whiteColor];
    _dropMenu.optionFont            = PingFangSCRegular(15);
    _dropMenu.optionTextColor       = [UIColor blackColor];
    _dropMenu.optionTextAlignment   = NSTextAlignmentLeft;
    _dropMenu.optionNumberOfLines   = 0;
    _dropMenu.optionLineColor       = [UIColor colorWithWhite:0 alpha:0.19];
    _dropMenu.optionIconSize        = CGSizeMake(24 * WidthScale, 24 * WidthScale);
    _dropMenu.optionIconMarginRight = 30;
    
    [bgview addSubview:_dropMenu];
    
    
    self.iotDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, bgview.bottom + 25 * HeightScale, self.width, 273 * HeightScale)];
    self.iotDetailView.backgroundColor = [UIColor whiteColor];
    self.iotDetailView.hidden = YES;
    [self addSubview:_iotDetailView];

    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(40 * WidthScale, 0, self.width - 80, 1)];
    lineView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.19];
    [_iotDetailView addSubview:lineView];
    self.ipView = [[CustomLabView alloc]initWithFrame:CGRectMake(25 * WidthScale, lineView.bottom + 24 * HeightScale, self.width - 50 * WidthScale, 73 * HeightScale)];
    _ipView.titleLab.text = @"Root_IP";
    [_ipView.imageBtn setImage:[UIImage imageNamed:@"icon_instanceroot"] forState:UIControlStateNormal];
    [_iotDetailView addSubview:_ipView];

    self.apiPortView = [[CustomLabView alloc]initWithFrame:CGRectMake(25 * WidthScale, _ipView.bottom + 16 * HeightScale, (self.width - 50 * WidthScale) / 2, 73 * HeightScale)];
    _apiPortView.titleLab.text = @"API_Port";
    [_apiPortView.imageBtn setImage:[UIImage imageNamed:@"icon_instanceapi"] forState:UIControlStateNormal];
    [_iotDetailView addSubview:_apiPortView];

    self.mqttPortView = [[CustomLabView alloc]initWithFrame:CGRectMake(_apiPortView.right, _ipView.bottom + 16 * HeightScale, (self.width - 50 * WidthScale) / 2, 73 * HeightScale)];
    _mqttPortView.titleLab.text = @"MQTT_Port";
    [_mqttPortView.imageBtn setImage:[UIImage imageNamed:@"icon_instancemqtt"] forState:UIControlStateNormal];
    [_iotDetailView addSubview:_mqttPortView];


    self.httpView = [[CustomLabView alloc]initWithFrame:CGRectMake(25 * WidthScale, _apiPortView.bottom + 16 * HeightScale, (self.width - 50 * WidthScale) / 2, 73 * HeightScale)];
    _httpView.titleLab.text = @"HTTP/s";
    [_httpView.imageBtn setImage:[UIImage imageNamed:@"icon_instancehttp"] forState:UIControlStateNormal];
    [_iotDetailView addSubview:_httpView];

    self.versionView = [[CustomLabView alloc]initWithFrame:CGRectMake(_httpView.right, _mqttPortView.bottom + 16 * HeightScale, (self.width - 50 * WidthScale) / 2, 73 * HeightScale)];
    _versionView.titleLab.text = @"版本";
    [_versionView.imageBtn setImage:[UIImage imageNamed:@"icon_instanceversion"] forState:UIControlStateNormal];
    [_iotDetailView addSubview:_versionView];
    
    
    CGFloat buttonY = 0;
    if (IS_IPHONE_8 || IS_IPHONE_8P) {
        buttonY = self.height - (30 + 52) * HeightScale;
    }else{
        buttonY =  self.height - (44 + 52) * HeightScale;
    }
    
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(16 * WidthScale, buttonY , 121 * WidthScale, 52 * HeightScale)];
    [backBtn setTitle:@"上一步" forState:UIControlStateNormal];
    [backBtn setTitleColor:DefaColor forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor colorWithHex:@"#0091FF" alpha:0.15];
    backBtn.titleLabel.font = PingFangSCMedium(17);
    [backBtn borderRoundCornerRadius:6];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    
    self.nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(backBtn.right +  10 * WidthScale, buttonY , self.width - 26 * WidthScale - backBtn.right, 52 * HeightScale)];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    _nextBtn.backgroundColor = ColorString(@"#D7DBDE");
    _nextBtn.userInteractionEnabled = NO;
    _nextBtn.titleLabel.font = PingFangSCMedium(17);
    [_nextBtn borderRoundCornerRadius:6];
    [_nextBtn addTarget:self action:@selector(nextBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nextBtn];
    
    
    
    
}
- (void)nextBtnAction
{
    if (_iotModel) {
        if ([self.delagte respondsToSelector:@selector(iothubNextPageWithIotModel:)]) {
            
            [self.delagte iothubNextPageWithIotModel:_iotModel];
        }
    }
}
-(void)backBtnAction
{
    if ([self.delagte respondsToSelector:@selector(iothubBackPage)]) {
        
        [self.delagte iothubBackPage];
    }

}
-  (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self moreAction];
    return NO;
}
- (void)moreAction
{
    CZHWeakSelf(self)
    [self.reportViewModel iotHubDataCompletion:^(BOOL success, NSArray * _Nonnull dataList, NSString * _Nonnull errorMsg) {
        weakself.customText.userInteractionEnabled = YES;
        if (success) {
            if (dataList.count != 0) {
                NSMutableArray *datas = [NSMutableArray array];
                for (IothubModel *model in dataList) {
                    [datas addObject:model.instance_name];
                }
                weakself.dataArray = dataList;
                if (weakself.isFirst) {
                    weakself.isFirst = NO;
                    for (IothubModel *model in dataList) {
                        if (model.isDefault) {
                            weakself.dropMenu.title = model.instance_name;
                            weakself.nextBtn.userInteractionEnabled = YES;
                            weakself.nextBtn.backgroundColor = DefaColor;
                            weakself.iotModel = model;
                            if (model) {
                                [weakself createViewWithModel:model];
                            }
                        }
                    }
                    
                }else{
                    
                    [weakself.dropMenu reloadOptionsData];
                }
                
                
                
            }
        }else{
            [CustomAlert alertVcWithMessage:errorMsg Vc:self.superview.viewController];
        }
    }];
    
    
  
}
- (void)singleChoiceBlockData:(NSString *)data index:(NSInteger)index
{
    _customText.textField.text = data;
    _nextBtn.userInteractionEnabled = YES;
    _nextBtn.backgroundColor = DefaColor;
    IothubModel *model = [self.dataArray objectAtIndex:index];
    _iotModel = model;
    if (model) {
        [self createViewWithModel:model];
    }
    
}

- (void)createViewWithModel:(IothubModel *)iotModel
{
    self.iotDetailView.hidden = NO;
    self.ipView.detailLab.text = iotModel.root_ip;
    self.apiPortView.detailLab.text = iotModel.api_port;
    self.mqttPortView.detailLab.text = iotModel.mqtt_port;
    self.httpView.detailLab.text = iotModel.http_protocol;
    self.versionView.detailLab.text = iotModel.version;

    
}

#pragma mark - LMJDropdownMenu DataSource
- (NSUInteger)numberOfOptionsInDropdownMenu:(LMJDropdownMenu *)menu{
    
    return self.dataArray.count;
}
- (CGFloat)dropdownMenu:(LMJDropdownMenu *)menu heightForOptionAtIndex:(NSUInteger)index{
    
    return 64 * HeightScale;
}
- (NSString *)dropdownMenu:(LMJDropdownMenu *)menu titleForOptionAtIndex:(NSUInteger)index{
    IothubModel *model = self.dataArray[index];
    
    return model.instance_name;
}
- (UIImage *)dropdownMenu:(LMJDropdownMenu *)menu iconForOptionAtIndex:(NSUInteger)index{
    
    return nil;
}
#pragma mark - LMJDropdownMenu Delegate
- (void)dropdownMenu:(LMJDropdownMenu *)menu didSelectOptionAtIndex:(NSUInteger)index optionTitle:(NSString *)title{
    _customText.textField.text = title;

    _nextBtn.userInteractionEnabled = YES;
    _nextBtn.backgroundColor = DefaColor;
    IothubModel *model = [self.dataArray objectAtIndex:index];
    _iotModel = model;
    if (model) {
        [self createViewWithModel:model];
    }
}

- (void)dropdownMenuWillShow:(LMJDropdownMenu *)menu{
    [self moreAction];
//        NSLog(@"--将要显示(will appear)--menu2");
}
- (void)dropdownMenuDidShow:(LMJDropdownMenu *)menu{
   
//        NSLog(@"--已经显示(did appear)--menu2");
}

- (void)dropdownMenuWillHidden:(LMJDropdownMenu *)menu{
  
//        NSLog(@"--将要隐藏(will disappear)--menu2");
}
- (void)dropdownMenuDidHidden:(LMJDropdownMenu *)menu{

//        NSLog(@"--已经隐藏(did disappear)--menu2");
}



- (ReportViewModel *)reportViewModel
{
    if (_reportViewModel == nil) {
        _reportViewModel = [[ReportViewModel alloc]init];
    }
    return _reportViewModel;
}

@end
