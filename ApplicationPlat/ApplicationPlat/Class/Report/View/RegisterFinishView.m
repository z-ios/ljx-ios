//
//  RegisterFinishView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/5.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "RegisterFinishView.h"
#import "FinishView.h"
#import "DottedLineView.h"
#import "IOTHubRegisterModel.h"
#import "ReportViewModel.h"
#import "AILoadingView.h"
@interface RegisterFinishView ()

@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UIButton *nextBtn;
@property(nonatomic, strong)FinishView *macDetilLab;
@property(nonatomic, strong)FinishView *iotNameDetilLab;
@property(nonatomic, strong)FinishView *iotIpDetilLab;
@property(nonatomic, strong)FinishView *iotApiDetilLab;
@property(nonatomic, strong)FinishView *iotMqttDetilLab;
@property(nonatomic, strong)FinishView *iotHttpDetilLab;
@property(nonatomic, strong)FinishView *iotVDetilLab;
@property(nonatomic, strong)FinishView *iotIDDetilLab;
@property(nonatomic, strong)FinishView *iotThingDetilLab;
@property(nonatomic, strong)FinishView *addressDetilLab;
@property(nonatomic, strong)AILoadingView *loadingView;

@property(nonatomic, strong)ReportViewModel *reportViewModel;

@end


@implementation RegisterFinishView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = KScreenWidth;
//        [self borderRoundCornerRadius:36];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight|UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(36, 36)];

        CAShapeLayer *layer = [[CAShapeLayer alloc] init];

        layer.frame = self.bounds;

        layer.path = path.CGPath;

        self.layer.mask = layer;
        [self createUI];
        
        
    }
    return self;
}

- (void)createUI
{
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(25 * WidthScale, 30 * HeightScale, 250, 33 * HeightScale)];
    titleLab.text = @"注册内容";
    titleLab.textColor = ColorString(@"#121212");
    titleLab.font = PingFangSCMedium(20);
    [self addSubview:titleLab];
    
    CGFloat buttonY = 0;
    if (IS_IPHONE_8 || IS_IPHONE_8P) {
        buttonY = self.height - (30 + 52) * HeightScale;
    }else{
        buttonY =  self.height - (44 + 52) * HeightScale;
    }
    
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, titleLab.bottom + 20 * HeightScale, self.width, buttonY - titleLab.bottom- 20 * HeightScale)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_scrollView];
    CGFloat titleW = 150 * WidthScale;
    CGFloat titleH = 24 * HeightScale;
    CGFloat detialW = self.width - 50 * WidthScale;
    CGFloat detialX = 25 * WidthScale;
    CGFloat detialH = 40 * HeightScale;
    CGFloat spaceY = 10 * HeightScale;

    UILabel *macTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(25 * WidthScale,0, titleW, titleH)];
    macTitleLab.textColor = ColorString(@"#8F9FB3");
    macTitleLab.font = PingFangSCRegular(14);
    macTitleLab.text = @"1.设备标识码";
    [_scrollView addSubview:macTitleLab];
    self.macDetilLab = [[FinishView alloc]initWithFrame:CGRectMake(detialX, macTitleLab.bottom + spaceY, detialW, detialH)];
    [_macDetilLab.imageBtn setImage:[UIImage imageNamed:@"icon_instance_mac"] forState:UIControlStateNormal];
    [_scrollView addSubview:_macDetilLab];
    DottedLineView *macLine = [[DottedLineView alloc]initWithFrame:CGRectMake(detialX, _macDetilLab.bottom + spaceY, detialW, 1)];
    [_scrollView addSubview:macLine];
    
    
    UILabel *iotTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(detialX,macLine.bottom + 20 * HeightScale, titleW, titleH)];
    iotTitleLab.textColor = ColorString(@"#8F9FB3");
    iotTitleLab.font = PingFangSCRegular(14);
    iotTitleLab.text = @"2.指定IoTHub实例";
    [_scrollView addSubview:iotTitleLab];
    self.iotNameDetilLab = [[FinishView alloc]initWithFrame:CGRectMake(detialX, iotTitleLab.bottom + spaceY, detialW, detialH)];
    [_iotNameDetilLab.imageBtn setImage:[UIImage imageNamed:@"icon_instancename-s"] forState:UIControlStateNormal];
    [_scrollView addSubview:_iotNameDetilLab];
    
    self.iotIpDetilLab = [[FinishView alloc]initWithFrame:CGRectMake(detialX, _iotNameDetilLab.bottom + spaceY, detialW, detialH)];
    [_iotIpDetilLab.imageBtn setImage:[UIImage imageNamed:@"icon_instanceroot"] forState:UIControlStateNormal];
    [_scrollView addSubview:_iotIpDetilLab];
    
    
    self.iotApiDetilLab = [[FinishView alloc]initWithFrame:CGRectMake(detialX, _iotIpDetilLab.bottom + spaceY, detialW/2, detialH)];
    [_iotApiDetilLab.imageBtn setImage:[UIImage imageNamed:@"icon_instanceapi"] forState:UIControlStateNormal];
    [_scrollView addSubview:_iotApiDetilLab];
    
    self.iotMqttDetilLab = [[FinishView alloc]initWithFrame:CGRectMake(_iotApiDetilLab.right, _iotIpDetilLab.bottom + spaceY, detialW/2, detialH)];
    [_iotMqttDetilLab.imageBtn setImage:[UIImage imageNamed:@"icon_instancemqtt"] forState:UIControlStateNormal];
    [_scrollView addSubview:_iotMqttDetilLab];
    
    self.iotHttpDetilLab = [[FinishView alloc]initWithFrame:CGRectMake(detialX, _iotApiDetilLab.bottom + spaceY, detialW/2, detialH)];
    [_iotHttpDetilLab.imageBtn setImage:[UIImage imageNamed:@"icon_instancehttp"] forState:UIControlStateNormal];
    [_scrollView addSubview:_iotHttpDetilLab];
    
    self.iotVDetilLab = [[FinishView alloc]initWithFrame:CGRectMake(_iotHttpDetilLab.right, _iotMqttDetilLab.bottom + spaceY, detialW/2, detialH)];
    [_iotVDetilLab.imageBtn setImage:[UIImage imageNamed:@"icon_instanceversion"] forState:UIControlStateNormal];
    [_scrollView addSubview:_iotVDetilLab];
    
    DottedLineView *iotLine = [[DottedLineView alloc]initWithFrame:CGRectMake(detialX, _iotVDetilLab.bottom + spaceY, detialW, 1)];
    [_scrollView addSubview:iotLine];
    
    
    UILabel *iotAvailTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(detialX,iotLine.bottom + 20 * HeightScale, titleW, titleH)];
    iotAvailTitleLab.textColor = ColorString(@"#8F9FB3");
    iotAvailTitleLab.font = PingFangSCRegular(14);
    iotAvailTitleLab.text = @"3.IoTHub注册验证";
    iotAvailTitleLab.width = [iotAvailTitleLab.text widthWithFont: PingFangSCRegular(14) h:titleH];
    [_scrollView addSubview:iotAvailTitleLab];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(iotAvailTitleLab.right+25 * WidthScale, iotLine.bottom + spaceY, 24 * WidthScale, 24 * WidthScale)];
    imageV.centerY = iotAvailTitleLab.centerY;
    imageV.image = [UIImage imageNamed:@"icon_success"];
    [_scrollView addSubview:imageV];
    
    UILabel *successLab = [[UILabel alloc]initWithFrame:CGRectMake(imageV.right + 10 * WidthScale, iotLine.bottom + 20 * HeightScale, titleW, titleH)];
    successLab.textColor = ColorString(@"#26C464");
    successLab.font = PingFangSCRegular(14);
    successLab.text = @"验证通过！";
    [_scrollView addSubview:successLab];
    
    self.iotIDDetilLab = [[FinishView alloc]initWithFrame:CGRectMake(detialX, iotAvailTitleLab.bottom + spaceY, detialW, detialH)];
    [_iotIDDetilLab.imageBtn setImage:[UIImage imageNamed:@"icon_instance_ID"] forState:UIControlStateNormal];
    [_scrollView addSubview:_iotIDDetilLab];
    
    self.iotThingDetilLab = [[FinishView alloc]initWithFrame:CGRectMake(detialX, _iotIDDetilLab.bottom + spaceY, detialW, detialH)];
    [_iotThingDetilLab.imageBtn setImage:[UIImage imageNamed:@"icon_instance_xinghao"] forState:UIControlStateNormal];
    [_scrollView addSubview:_iotThingDetilLab];
    
    
    DottedLineView *iotAvailLine = [[DottedLineView alloc]initWithFrame:CGRectMake(detialX, _iotThingDetilLab.bottom + spaceY, detialW, 1)];
    [_scrollView addSubview:iotAvailLine];
    
    UILabel *addressTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(detialX,iotAvailLine.bottom + 20 * HeightScale, titleW, titleH)];
    addressTitleLab.textColor = ColorString(@"#8F9FB3");
    addressTitleLab.font = PingFangSCRegular(14);
    addressTitleLab.text = @"4.安装地址";
    [_scrollView addSubview:addressTitleLab];
    self.addressDetilLab = [[FinishView alloc]initWithFrame:CGRectMake(detialX, addressTitleLab.bottom + spaceY, detialW, detialH)];
    [_addressDetilLab.imageBtn setImage:[UIImage imageNamed:@"icon_instance_location"] forState:UIControlStateNormal];
    [_scrollView addSubview:_addressDetilLab];
    
    _scrollView.contentSize = CGSizeMake(0, _addressDetilLab.bottom + 40 * HeightScale);
    
   
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(16 * WidthScale, buttonY, 121 * WidthScale, 52 * HeightScale)];
    [backBtn setTitle:@"上一步" forState:UIControlStateNormal];
    [backBtn setTitleColor:DefaColor forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor colorWithHex:@"#0091FF" alpha:0.15];
    backBtn.titleLabel.font = PingFangSCMedium(17);
    [backBtn borderRoundCornerRadius:6];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    
    self.nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(backBtn.right +  10 * WidthScale, buttonY , self.width - 26 * WidthScale - backBtn.right, 52 * HeightScale)];
    [_nextBtn setTitle:@"提交注册" forState:UIControlStateNormal];
    _nextBtn.backgroundColor = DefaColor;
    _nextBtn.titleLabel.font = PingFangSCMedium(17);
    [_nextBtn borderRoundCornerRadius:6];
    [_nextBtn addTarget:self action:@selector(nextBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nextBtn];
    
    self.loadingView  = [[AILoadingView alloc]initWithFrame:CGRectMake(_nextBtn.width / 2- 30/2, _nextBtn.height / 2- 30/2, 30, 30)];
    _loadingView.strokeColor = [UIColor whiteColor];
    _loadingView.hidden = YES;

    [_nextBtn addSubview:_loadingView];
    
}


- (void)setParamsDic:(NSMutableDictionary *)paramsDic
{
    _paramsDic = paramsDic;
    self.macDetilLab.titleLab.text = paramsDic[@"node_Id"];
    self.iotNameDetilLab.titleLab.text = paramsDic[@"instance_name"];
    self.iotIpDetilLab.titleLab.text = paramsDic[@"root_ip"];
    IOTHubRegisterModel * model = paramsDic[@"IOTHubRegisterModel"];
    self.iotApiDetilLab.titleLab.text = model.instance.api_port;
    self.iotMqttDetilLab.titleLab.text = model.instance.mqtt_port;
    self.iotHttpDetilLab.titleLab.text = model.instance.http_protocol;
    self.iotVDetilLab.titleLab.text = model.instance.version;
    self.iotIDDetilLab.titleLab.text = model.thing_id;
    self.iotThingDetilLab.titleLab.text = model.thing_title;
    NSString *address = paramsDic[@"location"][@"address"];
    self.addressDetilLab.titleLab.text = address;
    CGFloat h =[address heightWithCustomFont: PingFangSCRegular(17) w:_addressDetilLab.titleLab.width];
    _addressDetilLab.height = (h + 20 * HeightScale)> 48 * HeightScale ? (h + 20 * HeightScale) : 48 * HeightScale;
    _addressDetilLab.titleLab.height = (h + 20 * HeightScale)> 48 * HeightScale ? (h + 20 * HeightScale) : 48 * HeightScale;
    _scrollView.contentSize = CGSizeMake(0, _addressDetilLab.bottom + 40 * HeightScale);

}


- (void)nextBtnAction
{
    _nextBtn.userInteractionEnabled = NO;
    [_nextBtn setTitle:@"" forState:UIControlStateNormal];
    _loadingView.hidden = NO;
    [_loadingView starAnimation];

    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"location"] = [_paramsDic objectForKey:@"location"];
    NSMutableDictionary *gatewayDic = [[NSMutableDictionary alloc]init];
    gatewayDic[@"node_Id"] = [_paramsDic objectForKey:@"node_Id"];
    gatewayDic[@"iothub_id"] = [_paramsDic objectForKey:@"iothub_id"];

    params[@"gateway"] = gatewayDic;
    params[@"installation_userId"] = Center.shared.userID;
    CZHWeakSelf(self)
    [self.reportViewModel deviceRegisterWithParams:params Completion:^(BOOL success, NSString * _Nonnull msg, NSString * _Nonnull iId) {
        weakself.nextBtn.userInteractionEnabled = YES;
        [weakself.nextBtn setTitle:@"提交注册" forState:UIControlStateNormal];
        weakself.loadingView.hidden = YES;
        [weakself.loadingView stopAnimation];
        if (success) {
            if ([weakself.delagte respondsToSelector:@selector(registerFinishNextPageWithParams:)]) {
                
                [weakself.delagte registerFinishNextPageWithParams:@{@"isSuccess":@"1",@"iothub_id":weakself.paramsDic[@"iothub_id"],@"msg":msg,@"iId": iId,@"node_Id":weakself.paramsDic[@"node_Id"]}];
            }
            
        }else{
            if ([weakself.delagte respondsToSelector:@selector(registerFinishNextPageWithParams:)]) {
               NSString *msgStr = msg ? msg : @"注册失败";
                [weakself.delagte registerFinishNextPageWithParams:@{@"isSuccess":@"0",@"msg":msgStr}];
            }
            
        }
        
    }];
    
//    int x = arc4random() % 5;
//
//    if (x>3) {
//        [self.delagte registerFinishNextPageWithParams:@{@"isSuccess":@"1",@"iothub_id":_paramsDic[@"iothub_id"],@"msg":@""}];
//
//
//
//    }else{
//        [self.delagte registerFinishNextPageWithParams:@{@"isSuccess":@"0",@"iothub_id":@"",@"msg":@"注册失败"}];
//
//    }
    
}
-(void)backBtnAction
{
    if ([self.delagte respondsToSelector:@selector(registerFinishBackPage)]) {
        
        [self.delagte registerFinishBackPage];
    }

}
- (ReportViewModel *)reportViewModel
{
    if (_reportViewModel == nil) {
        _reportViewModel = [[ReportViewModel alloc]init];
    }
    return _reportViewModel;
}
@end
