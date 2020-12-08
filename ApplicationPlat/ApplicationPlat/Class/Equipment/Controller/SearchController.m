//
//  SearchController.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/9.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "SearchController.h"
#import "CGXPickerView.h"
#import "CustomDateView.h"
//#import <AMapFoundationKit/AMapFoundationKit.h>
//#import <AMapSearchKit/AMapSearchKit.h>
#import "BTAreaPickViewController.h"
#import "LDateView.h"
#import "LAddressView.h"


@interface SearchController ()<UITextFieldDelegate,BTAreaPickViewControllerDelegate>
@property(nonatomic, strong)UITextField *macText;
@property(nonatomic, strong)UITextField *addressText;
@property(nonatomic, strong)UITextField *installDateText;
@property(nonatomic, strong)UITextField *rangeDateText;
//@property(nonatomic, strong)AMapSearchAPI *search;
@property(nonatomic, strong)NSString *provinceCode;
@property(nonatomic, strong)NSString *cityCode;
@property(nonatomic, strong)NSString *areaCode;
@property(nonatomic, strong)NSString *streatCode;


@end

@implementation SearchController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"筛选";
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    titleLabel.font = PingFangSCRegular(17);
    
    titleLabel.textColor = ColorString(@"#2E3C4D");
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.title;
    self.navigationItem.titleView = titleLabel;
    [self initNavi];
    [self createUI];
    [self searchCity];
}

- (void)initNavi
{
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    //    [btn setImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateNormal];
    [btn setTitle:@"×" forState:UIControlStateNormal];
    [btn setTitleColor:ColorString(@"#2E3C4D") forState:UIControlStateNormal];
    btn.titleLabel.font = PingFangSCMedium(30);
    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* litem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    //    [btn setTitle:@"     " forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = litem;
    
    
}
- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createUI
{
    CGFloat textHeight = 44 * HeightScale;
    UILabel *macLab = [UILabel labelWithframe:CGRectMake(20 * WidthScale, 23 * HeightScale , 60 * WidthScale, 20 * WidthScale) title:@"MAC地址" font:PingFangSCRegular(12) color:ColorString(@"#8F9BB3") line:0];
    [self.view addSubview:macLab];
    self.macText = [[UITextField alloc]initWithFrame:CGRectMake(20 * WidthScale, macLab.bottom + 8 * HeightScale, KScreenWidth - 40 * WidthScale, textHeight)];
    _macText.font = PingFangSCRegular(12);
    _macText.textColor = ColorString(@"#101426");
    //    _macText.text = @"6043552190";
    Ivar ivar = class_getInstanceVariable([UITextField class], "_placeholderLabel");
    UILabel *placeholderLabel = object_getIvar(_macText, ivar);
    placeholderLabel.textColor = ColorString(@"#C5CEE0");
    placeholderLabel.font = PingFangSCRegular(12);
    _macText.placeholder = @"母开关MAC地址";
    _macText.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_macText];
    
    UILabel *addressLab = [UILabel labelWithframe:CGRectMake(20 * WidthScale, _macText.bottom + 20 * HeightScale , 50 * WidthScale, 20 * WidthScale) title:@"安装地址" font:[UIFont italicSystemFontOfSize:38] color:ColorString(@"#8F9BB3") line:0];
    addressLab.font = PingFangSCRegular(12);
    [self.view addSubview:addressLab];
    self.addressText = [[UITextField alloc]initWithFrame:CGRectMake(20 * WidthScale, addressLab.bottom + 8 * HeightScale, KScreenWidth - 40 * WidthScale, textHeight)];
    _addressText.font = PingFangSCRegular(12);
    _addressText.textColor = ColorString(@"#101426");
    //    _addressText.text = @"天津市/西青区/大寺镇";
    Ivar addIvar = class_getInstanceVariable([UITextField class], "_placeholderLabel");
     UILabel *addLab = object_getIvar(_addressText, addIvar);
     addLab.textColor = ColorString(@"#C5CEE0");
     addLab.font = PingFangSCRegular(12);
    _addressText.placeholder = @"点击选取区域";
    _addressText.delegate = self;
    _addressText.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_addressText];
    
    UILabel *installLab = [UILabel labelWithframe:CGRectMake(20 * WidthScale, _addressText.bottom + 20 * HeightScale , 50 * WidthScale, 20 * WidthScale) title:@"安装日期" font:[UIFont italicSystemFontOfSize:38] color:ColorString(@"#8F9BB3") line:0];
    installLab.font = PingFangSCRegular(12);
    [self.view addSubview:installLab];
    self.installDateText = [[UITextField alloc]initWithFrame:CGRectMake(20 * WidthScale, installLab.bottom + 8 * HeightScale, (KScreenWidth - 80 * WidthScale) / 2, textHeight)];
    _installDateText.font = PingFangSCRegular(12);
    _installDateText.textColor = ColorString(@"#101426");
    Ivar instIvar = class_getInstanceVariable([UITextField class], "_placeholderLabel");
    UILabel *instLab = object_getIvar(_installDateText, instIvar);
    instLab.textColor = ColorString(@"#C5CEE0");
    instLab.font = PingFangSCRegular(12);
    _installDateText.placeholder = @"- -";
    _installDateText.delegate = self;
    _installDateText.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_installDateText];
    
    UIView *installView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 32 * WidthScale, textHeight)];
    _installDateText.leftView = installView;
    _installDateText.leftViewMode = UITextFieldViewModeAlways;
    UIButton *leftInstallBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32 * HeightScale, textHeight)];
    leftInstallBtn.centerY = installView.centerY;
    [installView addSubview:leftInstallBtn];
    leftInstallBtn.backgroundColor = [UIColor redColor];
    [leftInstallBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    
    UILabel *rangeLab = [UILabel labelWithframe:CGRectMake(_installDateText.right + 10 * WidthScale, installLab.bottom + 8 * HeightScale , 20 * WidthScale, 32 * WidthScale) title:@"至" font:[UIFont italicSystemFontOfSize:38] color:ColorString(@"#8F9BB3") line:0];
    rangeLab.font = PingFangSCRegular(12);
    rangeLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:rangeLab];
    self.rangeDateText = [[UITextField alloc]initWithFrame:CGRectMake( rangeLab.right + 10 * WidthScale, installLab.bottom + 8 * HeightScale, (KScreenWidth - 80 * WidthScale) / 2, textHeight)];
    _rangeDateText.font = [UIFont systemFontOfSize:12];
    _rangeDateText.textColor = ColorString(@"#101426");
    Ivar rangIvar = class_getInstanceVariable([UITextField class], "_placeholderLabel");
    UILabel *rangLab = object_getIvar(_rangeDateText, rangIvar);
    rangLab.textColor = ColorString(@"#C5CEE0");
    rangLab.font = PingFangSCRegular(12);
    _rangeDateText.placeholder = @"- -";
    _rangeDateText.delegate = self;
    _rangeDateText.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_rangeDateText];
    
    
    UIView *rangeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 32 * WidthScale,textHeight)];
    _rangeDateText.leftView = rangeView;
    _rangeDateText.leftViewMode = UITextFieldViewModeAlways;
    UIButton *leftRangeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32 * HeightScale, textHeight)];
    leftRangeBtn.centerY = rangeView.centerY;
    [rangeView addSubview:leftRangeBtn];
    leftRangeBtn.backgroundColor = [UIColor redColor];
    [leftRangeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    
    UIButton *restBtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth /2 - 50 * WidthScale,_addressText.bottom + 144 * HeightScale, 100 * WidthScale , 30 * HeightScale)];
    [restBtn setTitle:@"全部重置" forState:UIControlStateNormal];
    [restBtn setTitleColor:ColorString(@"#8A9199") forState:UIControlStateNormal];
    restBtn.titleLabel.font = PingFangSCRegular(14);
    [restBtn addTarget:self action:@selector(restBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:restBtn];
    
    
    UIButton *fixBtn = [[UIButton alloc]initWithFrame:CGRectMake(20 * WidthScale,restBtn.bottom + 15* HeightScale, KScreenWidth - 20 * WidthScale * 2, 52 * HeightScale)];
    [fixBtn setTitle:@"确定" forState:UIControlStateNormal];
    fixBtn.backgroundColor = ColorString(@"#0091FF");
    fixBtn.titleLabel.font = PingFangSCSemibold(16);
    [fixBtn borderRoundCornerRadius:8];
    [fixBtn addTarget:self action:@selector(fixBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fixBtn];
    
}
- (void)searchCity
{
    //    self.search = [[AMapSearchAPI alloc] init];
    //    self.search.delegate = self;
    //    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
    //    geo.address = @"东城区";
    //    [self.search AMapGeocodeSearch:geo];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _addressText) {
        //        [CGXPickerView showAddressPickerWithTitle:@"请选择你的城市" DefaultSelected:@[@4, @0,@0] IsAutoSelect:YES Manager:nil ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
        //            NSLog(@"%@-%@",selectAddressArr,selectAddressRow);
        //            NSString *address =  [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
        //            self.addressText.text = address;
        //
        //        }];
        
        //        BTAreaPickViewController * vc = [[BTAreaPickViewController alloc]initWithDragDismissEnabal:YES];
        //        vc.delegate = self;
        //        [self presentViewController:vc animated:YES completion:nil];
        [_macText resignFirstResponder];
        [self showAddressView];
        return NO;
    }
    if (textField == _installDateText || textField == _rangeDateText) {
        [_macText resignFirstResponder];

        [self showDateView];
        //        [self.calendarPicker showInView:self.view.window];
        
        
        return NO;
    }
    
    return YES;
}
- (void)areaPickerView:(BTAreaPickViewController *)areaPickerView doneAreaModel:(BTAreaPickViewModel*)model
{
    NSString *address =  [NSString stringWithFormat:@"%@%@%@%@", model.selectedProvince.name, model.selectedCitie.name,model.selectedArea.name,model.selectedStreet.name];
    self.addressText.text = address;
    self.provinceCode = [NSString stringWithFormat:@"%ld",model.selectedProvince.code];
    self.cityCode = [NSString stringWithFormat:@"%ld",model.selectedCitie.code];
    self.areaCode = [NSString stringWithFormat:@"%ld",model.selectedArea.code];
    self.streatCode = [NSString stringWithFormat:@"%ld",model.selectedStreet.code];
    
}

- (void)showDateView
{
    
    LDateView *dateView = [[LDateView alloc]initWithFrame:CGRectMake(15 * WidthScale, 0, KScreenWidth - 30 * WidthScale, 450 * HeightScale)];
    FFToast *customDateViewToast = [[FFToast alloc]initCentreToastWithView:dateView autoDismiss:NO duration:3 enableDismissBtn:NO dismissBtnImage:nil];
    
    [customDateViewToast show];
    CZHWeakSelf(self)
    
    dateView.cancleBack = ^{
        [customDateViewToast dismissCentreToast];
        
    };
    dateView.setTimeBack = ^(NSString * _Nonnull startDate, NSString * _Nonnull endDate) {
        weakself.installDateText.text = startDate;
        weakself.rangeDateText.text = endDate;
        [customDateViewToast dismissCentreToast];
    };
    
}
- (void)showAddressView
{
    LAddressView *addressView = [[LAddressView alloc]initWithFrame:CGRectMake(15 * WidthScale, 0, KScreenWidth - 30 * WidthScale, 450 * HeightScale)];
    FFToast *customDateViewToast = [[FFToast alloc]initCentreToastWithView:addressView autoDismiss:NO duration:3 enableDismissBtn:NO dismissBtnImage:nil];
    
    [customDateViewToast show];
    //       CZHWeakSelf(self)
    
    addressView.cancleBack = ^{
        [customDateViewToast dismissCentreToast];
        
    };
    addressView.setAddressBack = ^(BTAreaPickViewModel * _Nonnull addressModel) {
        NSString *address =  [NSString stringWithFormat:@"%@%@%@%@", addressModel.selectedProvince.name, addressModel.selectedCitie.name,addressModel.selectedArea.name,addressModel.selectedStreet.name];
        self.addressText.text = address;
        self.provinceCode = [NSString stringWithFormat:@"%ld",addressModel.selectedProvince.code];
        self.cityCode = [NSString stringWithFormat:@"%ld",addressModel.selectedCitie.code];
        self.areaCode = [NSString stringWithFormat:@"%ld",addressModel.selectedArea.code];
        self.streatCode = [NSString stringWithFormat:@"%ld",addressModel.selectedStreet.code];
        [customDateViewToast dismissCentreToast];
    };
    //    addressView.setAddressBack = ^(BTAreaPickViewModel *addressModel) {
    //        NSString *address =  [NSString stringWithFormat:@"%@%@%@%@", model.selectedProvince.name, model.selectedCitie.name,model.selectedArea.name,model.selectedStreet.name];
    //           self.addressText.text = address;
    //           self.provinceCode = [NSString stringWithFormat:@"%ld",model.selectedProvince.code];
    //           self.cityCode = [NSString stringWithFormat:@"%ld",model.selectedCitie.code];
    //           self.areaCode = [NSString stringWithFormat:@"%ld",model.selectedArea.code];
    //           self.streatCode = [NSString stringWithFormat:@"%ld",model.selectedStreet.code];
    //         [customDateViewToast dismissCentreToast];
    //    };
    //       addressView.setTimeBack = ^(NSString * _Nonnull startDate, NSString * _Nonnull endDate) {
    //           weakself.installDateText.text = startDate;
    //           weakself.rangeDateText.text = endDate;
    //           [customDateViewToast dismissCentreToast];
    //       };
}
- (void)restBtnAction
{
    _addressText.text = @"";
    _macText.text = @"";
    _installDateText.text = @"";
    _rangeDateText.text = @"";
    
}
- (void)fixBtnAction
{
    if ([self.delegate respondsToSelector:@selector(searchDoneWithParmas:)]) {
        SearchModel *model = [[SearchModel alloc]init];
        model.mac = self.macText.text;
        model.province_adcode = self.provinceCode;
        model.city_adcode = self.cityCode;
        model.district_adcode = self.areaCode;
        model.street_adcode = self.streatCode;
        model.start_datetime = self.installDateText.text;
        model.end_datetime = self.rangeDateText.text;
        [self.delegate searchDoneWithParmas:model];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}


#pragma mark - Private

- (NSDate *)defaultStartDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter dateFromString:@"2019-01-01"];
}

- (NSDate *)defaultEndDate {
    return [NSDate date];
}
@end
