//
//  ReportView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/3.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "ReportView.h"
#import "IdentiCodeView.h"
#import "IothubSenceView.h"
#import "IOTHubRegisterView.h"
#import "IothubModel.h"
#import "LocationView.h"
#import "RegisterFinishView.h"
#import "AddressFromMapViewController.h"
#import "ReportFinishController.h"
#import "QRScanViewController.h"
#import "LocModel.h"
@interface ReportView ()<IdentiCodeViewDelegate,IothubSenceViewDelegate,IOTHubRegisterViewDelegate,LocationViewDelegate,RegisterFinishViewDelegate,QRScanDelegate>
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)NSArray *nomalImageArray;
@property(nonatomic, strong)NSArray *selectImageArray;
@property(nonatomic, strong)NSMutableArray *btnArray;
@property(nonatomic, strong)NSMutableArray *labelArray;
@property(nonatomic, strong)NSMutableDictionary *paramsDic;
@property(nonatomic, strong)IOTHubRegisterView *iotHubRegisterView;
@property(nonatomic, strong)LocationView *locView;
@property(nonatomic, strong)RegisterFinishView *finishView;
@property(nonatomic, strong)IdentiCodeView *idCodeView;

@end

@implementation ReportView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.width = KScreenWidth;
        self.paramsDic = [NSMutableDictionary dictionary];
        [self createHeaderView];
        [self createUI];
    }
    return self;
}
- (void)createHeaderView
{
    CGFloat w = (self.width - 160 * WidthScale) / 5;
    self.nomalImageArray = @[@"icon_register_code_focuse",@"icon_register_iothub_default",@"icon_register_iotver_default",@"icon_register_location_default",@"icon_register_regis_default"];
    self.selectImageArray = @[@"icon_register_code_focuse",@"icon_register_iotuhub_focuse",@"icon_register_iotver_focuse",@"icon_register_location_focuse",@"icon_register_regis_focuse"];
    
    
    for (int i = 0; i < 5; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20 * WidthScale + i * (w + 30 * WidthScale), 30 * HeightScale, w, w)];
        [btn setImage:[UIImage imageNamed:self.nomalImageArray[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:self.selectImageArray[i]] forState:UIControlStateSelected];
        btn.userInteractionEnabled = NO;
        [self addSubview:btn];
        [self.btnArray addObject:btn];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(btn.right + 4 * WidthScale, 30 * HeightScale + w / 2- 1.5 /2, 22 * WidthScale, 3)];
        [label borderRoundCornerRadius:1.5];
        label.font = [UIFont systemFontOfSize:10];
        label.text = @"·····";
        label.textColor = ColorString(@"#8696A2");
        label.lineBreakMode = NSLineBreakByCharWrapping;
        [self.labelArray addObject:label];
        if (i <4) {
            
            [self addSubview:label];
        }
        
        
    }
    
}
- (void)createUI
{
    CGFloat w = (self.width - 160 * WidthScale) / 5;
    CGFloat h = self.height - (55 * HeightScale + w);
    self.scrollView = [[UIScrollView  alloc]initWithFrame:CGRectMake(0, 55 * HeightScale + w,self.width , h)];
    _scrollView.contentSize = CGSizeMake(self.width * 5, 0);
    _scrollView.backgroundColor = ColorString(@"#F4F6FC");
    _scrollView.scrollEnabled = NO;
    [self addSubview:_scrollView];
    self.idCodeView = [[IdentiCodeView alloc]initWithFrame:CGRectMake(0, 0, self.width, h)];
    _idCodeView.delagte = self;
    [_scrollView addSubview:_idCodeView];
    
    IothubSenceView *iotHubView = [[IothubSenceView alloc]initWithFrame:CGRectMake(self.width, 0, self.width, h)];
    iotHubView.delagte = self;
    [_scrollView addSubview:iotHubView];
//
    self.iotHubRegisterView = [[IOTHubRegisterView alloc]initWithFrame:CGRectMake(self.width * 2, 0, self.width, h)];
    _iotHubRegisterView.delagte = self;
    [_scrollView addSubview:_iotHubRegisterView];
    self.locView = [[LocationView alloc]initWithFrame:CGRectMake(self.width * 3, 0, self.width, h)];
    _locView.delagte = self;
    [_scrollView addSubview:_locView];
    
    self.finishView = [[RegisterFinishView alloc]initWithFrame:CGRectMake(self.width * 4, 0, self.width, h)];
    _finishView.delagte = self;
    [_scrollView addSubview:_finishView];
}

- (void)nextPageWithMacCode:(NSString *)macCode
{
    [_scrollView setContentOffset:CGPointMake(self.width, 0) animated:YES];
    self.paramsDic[@"node_Id"] = macCode;
    [self selectFunctionWithIndex:2];
}
- (void)scanCodeVc
{
    QRScanViewController *vc = [[QRScanViewController alloc]init];
    vc.delegate = self;
    [_reportVc.navigationController pushViewController:vc animated:YES];
}
- (void)qrScanResult:(NSString *)result viewController:(QRScanViewController *)qrScanVC
{
    [qrScanVC.navigationController popViewControllerAnimated:YES];
    if (result) {
        _idCodeView.customText.textField.text = result;
        _idCodeView.nextBtn.backgroundColor = DefaColor;
        _idCodeView.nextBtn.userInteractionEnabled = YES;

    }
    
}
- (void)iothubNextPageWithIotModel:(IothubModel *)model
{
    [_scrollView setContentOffset:CGPointMake(self.width * 2, 0) animated:YES];
    [self.paramsDic setValue:model.iId forKey:@"iothub_id"];
    [self.paramsDic setValue:model.instance_name forKey:@"instance_name"];
    [self.paramsDic setValue:model.root_ip forKey:@"root_ip"];
    _iotHubRegisterView.paramsDic = _paramsDic;
    [self selectFunctionWithIndex:3];

}
- (void)iothubRegisterNextPageWithIOTHubRegisterModel:(IOTHubRegisterModel *)model
{
    [self.paramsDic setValue:model forKey:@"IOTHubRegisterModel"];

    [_scrollView setContentOffset:CGPointMake(self.width * 3, 0) animated:YES];
    [self selectFunctionWithIndex:4];


}
- (void)iothubRegisterBackPage
{
    [_scrollView setContentOffset:CGPointMake(self.width, 0) animated:YES];
    [self selectFunctionWithIndex:2];
}
- (void)iothubFailRegisterBackPage
{
    CZHWeakSelf(self)
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"是否取消注册？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setCancelBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *comAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setDefineBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself.reportVc dismissViewControllerAnimated:YES completion:nil];

  
    }];
    [alertVc addAction:cancleAc];
    [alertVc addAction:comAc];
    [weakself.reportVc presentViewController:alertVc animated:YES completion:^{
        
    }];
}
- (void)setTypeName:(NSString *)typeName
{
    _typeName = typeName;
    [self.paramsDic setValue:typeName forKey:@"typeName"];

}
- (void)iothubBackPage
{
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self selectFunctionWithIndex:1];

}
- (void)locationNextPageWithLocationDic:(NSDictionary *)dic
{
    [_scrollView setContentOffset:CGPointMake(self.width * 4, 0) animated:YES];
    _paramsDic[@"location"] = dic;
    _finishView.paramsDic = _paramsDic;
    [self selectFunctionWithIndex:5];

}
- (void)locationBackPage
{
    [_scrollView setContentOffset:CGPointMake(self.width*2, 0) animated:YES];
    [self selectFunctionWithIndex:3];
}
- (void)registerFinishNextPageWithParams:(NSDictionary *)params
{
    ReportFinishController *vc = [[ReportFinishController alloc]init];
    vc.feedBackDic = params;
    [_reportVc.navigationController pushViewController:vc animated:YES];

}
- (void)registerFinishBackPage
{
    [_scrollView setContentOffset:CGPointMake(self.width*3, 0) animated:YES];
    [self selectFunctionWithIndex:4];
}
- (void)setReportVc:(UIViewController *)reportVc
{
    _reportVc = reportVc;
}
- (void)locationSelectPoint
{
    AddressFromMapViewController *vc = [[AddressFromMapViewController alloc]init];
    CZHWeakSelf(self)
    vc.selectedEvent = ^(NSString *lat, NSString *lon, NSString *address, NSString *sheng, NSString *shi, NSString *qu, NSString *dao,NSString *provinceAcode,NSString *cityAcode,NSString *districeAcode, NSString *streetAcode) {
        LocModel *locModel = [[LocModel alloc]init];
        locModel.country_name = @"中国";
        locModel.country_adcode = @"100000";
        locModel.province_name = sheng;
        locModel.province_adcode = provinceAcode;
        locModel.city_name = shi;
        locModel.city_adcode = cityAcode;
        locModel.district_name = qu;
        locModel.district_adcode = districeAcode;
        locModel.street_name = dao;
        locModel.street_adcode = streetAcode;
        locModel.address = address;
        locModel.lat = lat;
        locModel.lng = lon;

//        NSDictionary *params = @{@"country_name":@"中国",@"country_adcode":@"100000", @"province_name":sheng,@"province_adcode":provinceAcode,@"city_name":shi,@"city_adcode":cityAcode,@"district_name":qu,
//                                 @"district_adcode":districeAcode,@"street_name":dao,@"street_adcode":streetAcode
//                                 ,@"address":address,@"lat":lat,@"lng":lon};
        [weakself.locView setDateWithParams:locModel];
    };
    [_reportVc.navigationController pushViewController:vc animated:YES];
}

- (void)selectFunctionWithIndex:(int)index
{
    for (int i = 0; i < self.btnArray.count; i++) {
        UIButton *btn = self.btnArray[i];
        UILabel *label = self.labelArray[i];
        if (i < index) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
        
        
        if (i < index -1) {
            label.text = @"————";
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = ColorString(@"#0091FF");
          
        }else{
            label.text = @"·····";
            label.font = [UIFont systemFontOfSize:10];
            label.textColor = ColorString(@"#8696A2");
        }
        
    }
    
}
- (NSMutableArray *)btnArray
{
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}
- (NSMutableArray *)labelArray
{
    if (_labelArray == nil) {
        _labelArray = [NSMutableArray array];
    }
    return _labelArray;
}

@end
