//
//  LocationView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/4.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "LocationView.h"
#import "LocLabView.h"
@interface LocationView ()<UITextFieldDelegate>
@property(nonatomic, strong)UIButton *nextBtn;
@property(nonatomic, strong)UIView *locDetailView;
@property(nonatomic, strong)LocLabView *provinceView;
@property(nonatomic, strong)LocLabView *cityView;
@property(nonatomic, strong)LocLabView *areaView;
@property(nonatomic, strong)LocLabView *streetView;
@property(nonatomic, strong)LocLabView *longitudeView;
@property(nonatomic, strong)LocLabView *latitudeView;
@property(nonatomic, strong)NSDictionary *params;
@end


@implementation LocationView

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
    titleLab.text = @"安装位置";
    titleLab.textColor = ColorString(@"#121212");
    titleLab.font = PingFangSCMedium(20);
    [self addSubview:titleLab];
    
    UILabel *subtitleLab = [[UILabel alloc]initWithFrame:CGRectMake(25 * WidthScale,titleLab.bottom + 15 * HeightScale, 80, 33 * HeightScale)];
    subtitleLab.text = @"详细位置";
    subtitleLab.textColor = ColorString(@"#808080");
    subtitleLab.font = PingFangSCRegular(14);
    [self addSubview:subtitleLab];
    
    
    self.customText = [[CustomTextField alloc]initWithFrame:CGRectMake(25 * WidthScale,subtitleLab.bottom + 3 * HeightScale, self.width - 50 * WidthScale, 48 * HeightScale) isLine:YES];
    _customText.textField.font = PingFangSCRegular(16);
    _customText.textField.textColor = ColorString(@"#121212");
    [_customText.functionBtn setImage:[UIImage imageNamed:@"icon_location-r"] forState:UIControlStateNormal];
    [_customText.functionBtn addTarget:self action:@selector(locationAction) forControlEvents:UIControlEventTouchUpInside];
    _customText.textField.delegate = self;
    [self addSubview:_customText];
    
    self.locDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, _customText.bottom + 25 * HeightScale, self.width, 273 * HeightScale)];
    self.locDetailView.backgroundColor = [UIColor whiteColor];
    self.locDetailView.hidden = YES;
    [self addSubview:_locDetailView];
    
    self.provinceView = [[LocLabView alloc]initWithFrame:CGRectMake(25 * WidthScale, 0, (self.width - 65 * WidthScale) / 2, 73 * HeightScale)];
    _provinceView.titleLab.text = @"省";
    [_locDetailView addSubview:_provinceView];

    self.cityView = [[LocLabView alloc]initWithFrame:CGRectMake(15 * WidthScale + _provinceView.right, 0, (self.width - 50 * WidthScale) / 2, 73 * HeightScale)];
    _cityView.titleLab.text = @"市";
    [_locDetailView addSubview:_cityView];

    self.areaView = [[LocLabView alloc]initWithFrame:CGRectMake(25 * WidthScale, _provinceView.bottom + 12 * HeightScale, (self.width - 50 * WidthScale), 73 * HeightScale)];
    _areaView.titleLab.text = @"区";
    [_locDetailView addSubview:_areaView];


    self.streetView = [[LocLabView alloc]initWithFrame:CGRectMake(25 * WidthScale, _areaView.bottom + 12 * HeightScale, (self.width - 50 * WidthScale), 73 * HeightScale)];
    _streetView.titleLab.text = @"街道";
    [_locDetailView addSubview:_streetView];

    self.longitudeView = [[LocLabView alloc]initWithFrame:CGRectMake(25 * WidthScale, _streetView.bottom + 12 * HeightScale, (self.width - 65 * WidthScale) / 2, 73 * HeightScale)];
    _longitudeView.titleLab.text = @"经度";
    [_locDetailView addSubview:_longitudeView];

    self.latitudeView = [[LocLabView alloc]initWithFrame:CGRectMake(15 * WidthScale + _longitudeView.right, _streetView.bottom + 12 * HeightScale, (self.width - 50 * WidthScale) / 2, 73 * HeightScale)];
    _latitudeView.titleLab.text = @"纬度";
    [_locDetailView addSubview:_latitudeView];
    
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
    if ([self.delagte respondsToSelector:@selector(locationNextPageWithLocationDic:)]) {
        
        [self.delagte locationNextPageWithLocationDic:_params];
    }
    
}
-(void)backBtnAction
{
    if ([self.delagte respondsToSelector:@selector(locationBackPage)]) {
        
        [self.delagte locationBackPage];
    }

}
-  (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self locationAction];
    return NO;
}
- (void)locationAction
{
    if ([self.delagte respondsToSelector:@selector(locationSelectPoint)]) {
        
        [self.delagte locationSelectPoint];
    }
   
}
- (void)setDateWithParams:(LocModel *)model
{
    self.locDetailView.hidden = NO;
    NSString *str  = [model yy_modelToJSONString];
    NSDictionary *dic = [str jsonDic];
    _params = dic;
    _provinceView.detailLab.text = model.province_name ;
    _cityView.detailLab.text = model.city_name ;
    _areaView.detailLab.text = model.district_name;
    _streetView.detailLab.text = model.street_name ;
    _longitudeView.detailLab.text = model.lng ;
    _latitudeView.detailLab.text = model.lat ;
    _nextBtn.backgroundColor = DefaColor;
    _nextBtn.userInteractionEnabled = YES;
    _customText.textField.text = model.address;
}

@end
