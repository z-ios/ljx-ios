//
//  DeviceAddressSelectController.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/12/3.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "DeviceAddressSelectController.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "SYIToast+SYCategory.h"
#import "EquipmentViewModel.h"
#define KScreenHeight [[UIScreen mainScreen]bounds].size.height

@interface DeviceAddressSelectController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) BOOL isStatusBarContentBlack;
//@property (nonatomic, strong) UIButton *navLeftButton;
@property (nonatomic, strong) UIButton *navRightButton;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, assign) CGFloat mapHeight;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) UIImageView *pin;
@property (nonatomic, strong) UIButton *appearlocationBtn;
@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, assign) CGRect tableViewFrame;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) NSMutableArray *pois;
@property (nonatomic, strong) AMapPOI *selectedPOI;
@property (nonatomic, strong) AMapGeoPoint *userGeoPoint;
@property (nonatomic, strong) AMapAddressComponent *addressComponet;
@property (nonatomic, strong) AMapLocationManager* locationManager;
@property(nonatomic, strong) EquipmentViewModel *equimentViewModel;


@property (nonatomic, strong) NSString* address;
@property (nonatomic, strong) NSString* sheng;
@property (nonatomic, strong) NSString* shi;
@property (nonatomic, strong) NSString* qu;
@property (nonatomic, strong) NSString* dao;
@property (nonatomic, strong) NSString* lat;
@property (nonatomic, strong) NSString* lon;
@property (nonatomic, strong) NSString* provinceAcode;
@property (nonatomic, strong) NSString* cityAcode;
@property (nonatomic, strong) NSString* districtAcode;

@end

@implementation DeviceAddressSelectController
#pragma mark -
#pragma mark - ⚙ 数据初始化
- (void)initDataSource {
    _mapHeight = ([UIScreen mainScreen].bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - 44 - CGRectGetHeight(self.searchBar.frame)) / 2.0;
    self.pois = [NSMutableArray array];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;

    [self dingwei];
}

#pragma mark - ♻️ Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [AMapServices sharedServices].enableHTTPS = YES;
    [self initDataSource];//!<初始化一些数据
    self.navigationItem.title = @"位置";
    //    self.view.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:239 / 255.0 blue:245 / 255.0 alpha:1];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    self.locationManager = [[AMapLocationManager alloc] init];
    [self dingwei];
    
}



- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.isStatusBarContentBlack) {
        return UIStatusBarStyleDefault;
    }
    return UIStatusBarStyleLightContent;
}

#pragma mark - 💤 LazyLoad


- (UIButton *)navRightButton {
    if (!_navRightButton) {
        _navRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _navRightButton.frame = CGRectMake(0, 0, 64, 44);
        [_navRightButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        [_navRightButton setTitle:@"确定" forState:(UIControlStateNormal)];
        _navRightButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _navRightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_navRightButton setTitleColor:UIColor.lightGrayColor forState:(UIControlStateHighlighted)];
        [_navRightButton addTarget:self action:@selector(navRightBarButtonEvent:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _navRightButton;
}

- (UISearchBar *)searchBar {
    
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 56)];
        _searchBar.backgroundImage = [DeviceAddressSelectController imageWithColor:ColorString(@"#F0EFF5")];
        //        _searchBar.backgroundImage = [AddressFromMapViewController imageWithColor:ColorString(@"#F0EFF5")];
        
        //        F2F1F5
        
        UITextField *searchField = [_searchBar valueForKey:@"searchField"];
        searchField.backgroundColor = ColorString(@"#F3F4F5");
        searchField.textColor = ColorString(@"#2F353A");
        if (searchField) {
            for (UIView *subView in searchField.subviews) {
                if ([subView isKindOfClass:NSClassFromString(@"_UISearchBarSearchFieldBackgroundView")]) {
                    subView.layer.cornerRadius = 4.0f;
                    subView.layer.masksToBounds = YES;
                }
            }
        }
        _searchBar.placeholder = @"搜索地点";
        _searchBar.delegate = self;
    }
    return _searchBar;
}


- (UIImageView *)pin {
    if (!_pin) {
        UIImage *image = [UIImage imageNamed:@"located_pin"];
        _pin = [[UIImageView alloc] initWithImage:image];
        _pin.center = CGPointMake(self.mapView.center.x, self.mapView.center.y - CGRectGetHeight(self.pin.bounds) / 2 - Height_NavBar - self.searchBar.bounds.size.height);
    }
    return _pin;
}

- (UIButton *)appearlocationBtn {
    if (!_appearlocationBtn) {
        UIImage *image = [UIImage imageNamed:@"location_my_current"];
        _appearlocationBtn = [[UIButton alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - image.size.width - 5, KScreenHeight - Height_NavBar - self.searchBar.bounds.size.height - image.size.height - 10, image.size.width, image.size.height)];
        //        [_appearlocationBtn setImage:image forState:(UIControlStateNormal)];
        [_appearlocationBtn setImage:[UIImage imageNamed:@"location_my_current"] forState:UIControlStateNormal];
        _appearlocationBtn.backgroundColor = [UIColor whiteColor];
        _appearlocationBtn.layer.cornerRadius=image.size.height/2;
        _appearlocationBtn.layer.masksToBounds=YES;
        [_appearlocationBtn addTarget:self action:@selector(displayCurrentLocation) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _appearlocationBtn;
}

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KScreenHeight, UIScreen.mainScreen.bounds.size.width, self.mapHeight) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        //        _tableView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];//#F5F5F5
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}

- (AMapSearchAPI *)search {
    if (!_search) {
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return _search;
}


#pragma mark - 🔨 CustomMethod
- (void)setupUI {
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, self.searchBar.bounds.size.height, UIScreen.mainScreen.bounds.size.width, KScreenHeight  - self.searchBar.bounds.size.height)];
    _mapView.showsUserLocation = YES;
    _mapView.rotateEnabled = NO;
    _mapView.delegate = self;
    _mapView.showsCompass =NO;          /// 是否显示指南针
    _mapView.showsScale = NO;
    _mapView.zoomLevel = 12;
    _mapView.mapType = MAMapTypeStandard;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [btn setImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* litem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn setTitle:@"     " forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = litem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navRightButton];
    [self.view addSubview:_mapView];
    [self.mapView addSubview:self.pin];
    [self.mapView addSubview:self.appearlocationBtn];
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
    
    
}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)pinAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        UIImage *image = [UIImage imageNamed:@"location_icon_pin"];
        self.pin.center = CGPointMake(UIScreen.mainScreen.bounds.size.width / 2.0, self.mapHeight / 2.0 - image.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            UIImage *image = [UIImage imageNamed:@"location_icon_pin"];
            self.pin.center = CGPointMake(UIScreen.mainScreen.bounds.size.width / 2.0, self.mapHeight / 2.0 - image.size.height / 2.0);
        }];
    }];
}
/* 移动窗口弹一下的动画 */
- (void)centerAnnotationAnimimate
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGPoint center = self.pin.center;
                         center.y -= 20;
                         [self.pin setCenter:center];}
                     completion:nil];
    
    [UIView animateWithDuration:0.45
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGPoint center = self.pin.center;
                         center.y += 20;
                         [self.pin setCenter:center];}
                     completion:nil];
}


#pragma mark - 🎬 ActionMethod 确定


- (void)navRightBarButtonEvent:(UIButton *)button {
    if (![self.address isEqualToString:@""]) {
//        self.selectedEvent(self.lat, self.lon, self.address, self.sheng, self.shi, self.qu, self.dao, self.provinceAcode,self.cityAcode,self.districtAcode, self.districtAcode);
        
        
        LocModel *locModel = [[LocModel alloc]init];
        locModel.country_name = @"中国";
        locModel.country_adcode = @"100000";
        locModel.province_name = _sheng;
        locModel.province_adcode = _provinceAcode;
        locModel.city_name = _shi;
        locModel.city_adcode = _cityAcode;
        locModel.district_name = _qu;
        locModel.district_adcode = _districtAcode;
        locModel.street_name = _dao;
        locModel.street_adcode = _districtAcode;
        locModel.address = _address;
        locModel.lat = _lat;
        locModel.lng = _lon;
        NSDictionary *params = @{@"country_name":@"中国",@"country_adcode":@"100000", @"province_name":_sheng,@"province_adcode":_provinceAcode,@"city_name":_shi,@"city_adcode":_cityAcode,@"district_name":_qu,
                                 @"district_adcode":_districtAcode,@"street_name":_dao,@"street_adcode":_districtAcode
                                 ,@"address":_address,@"lat":_lat,@"lng":_lon};
        
        
        [self changeLocationWithParams:params model:self.model locModel:locModel];
        
        
        
        
    }
}
- (void)changeLocationWithParams:(NSDictionary *)params model:(BreakerModel *)model locModel:(LocModel *)locModel
{
    CZHWeakSelf(self)
    NSDictionary *dic = @{@"id":model.iId,@"location":params};
    [self.equimentViewModel updateBreakerLocationWithParams:dic Completion:^(BOOL success, NSString * _Nonnull errorMsg) {
        if (success) {
            LocationModel *locationModel = [[LocationModel alloc]init];
            locationModel.address = locModel.address;
            locationModel.province_name = locModel.province_name;
            locationModel.city_name = locModel.city_name;
            locationModel.district_name = locModel.district_name;
            model.location = locationModel;
            weakself.selectedEvent(YES, locationModel);
//            [weakself.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
                [weakself.navigationController popViewControllerAnimated:YES];

        }else{
            [CustomAlert alertVcWithMessage:errorMsg Vc:self];

        }
    }];
}

- (void)displayCurrentLocation {
    [self dingwei];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pois.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"UITableViewCell"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.textColor = UIColor.lightGrayColor;
    cell.textLabel.textColor = ColorString(@"#2F353A");
    cell.backgroundColor = [UIColor whiteColor];
    if (self.pois.count > 0) {
        AMapPOI *poi = self.pois[indexPath.row];
        cell.textLabel.text = poi.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@%@%@", poi.province, poi.city, poi.district, poi.address];
        if ([poi.uid isEqualToString:self.selectedPOI.uid]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    AMapPOI *poi = self.pois[indexPath.row];
    self.searchBar.text = poi.name;
    self.selectedPOI = poi;
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude)];
    [self centerAnnotationAnimimate];
    
    [self searchBarCancelButtonClicked:self.searchBar];
    
    [tableView reloadData];
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    if (CGRectEqualToRect(self.tableViewFrame, CGRectZero)) { self.tableViewFrame = self.tableView.frame; }
    [self changeUIDisplay];
    self.mapView.delegate = nil;
    return YES;
}

- (void)changeUIDisplay {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.searchBar.frame = CGRectMake(0, CGRectGetMaxY([UIApplication sharedApplication].statusBarFrame), UIScreen.mainScreen.bounds.size.width, CGRectGetHeight(self.searchBar.frame));
    [self.searchBar setShowsCancelButton:YES animated:YES];
    self.isStatusBarContentBlack = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), UIScreen.mainScreen.bounds.size.width, self.mapHeight * 2.0 + 44);
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length == 0) {
        AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
        request.location = self.userGeoPoint;
        [self.search AMapPOIKeywordsSearch:request];
    } else {
        [self searchBarSearchButtonClicked:searchBar];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    self.searchBar.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, CGRectGetHeight(self.searchBar.frame));
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.searchBar setShowsCancelButton:NO animated:YES];
    self.isStatusBarContentBlack = NO;
    [self setNeedsStatusBarAppearanceUpdate];
    
    [self.searchBar resignFirstResponder];
    self.tableView.frame = self.tableViewFrame;
    self.tableViewFrame = CGRectZero;
    self.mapView.delegate = self;
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.keywords = searchBar.text;
    [self.search AMapPOIKeywordsSearch:request];
}

#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    AMapReGeocodeSearchRequest *reGeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
    reGeoRequest.location = [AMapGeoPoint locationWithLatitude:mapView.region.center.latitude longitude:mapView.region.center.longitude];
    reGeoRequest.requireExtension = YES;
    [self.search AMapReGoecodeSearch:reGeoRequest];
    self.lat = [NSString stringWithFormat:@"%f",mapView.region.center.latitude];
    self.lon = [NSString stringWithFormat:@"%f",mapView.region.center.longitude];
    
    
    if (!self.userGeoPoint) {
        self.userGeoPoint = reGeoRequest.location;
    }
}

- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction {
    [self centerAnnotationAnimimate];
}

#pragma mark - AMapSearchDelegate
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response {
    if (response) {
        [self.pois removeAllObjects];
        AMapAddressComponent *addressComponet = response.regeocode.addressComponent;
        for (AMapPOI *poi in response.regeocode.pois) {
            poi.province = addressComponet.province;
            poi.city = addressComponet.city;
            poi.district = addressComponet.district;
            
            // 详细地址
            self.address = response.regeocode.formattedAddress;
            // 省
            self.sheng = response.regeocode.addressComponent.province;
            // 市
            self.shi = response.regeocode.addressComponent.city;
            // 区
            self.qu = response.regeocode.addressComponent.district;
            self.districtAcode = response.regeocode.addressComponent.adcode;
            // 街道
            self.dao = response.regeocode.addressComponent.township;
            
            [self.pois addObject:poi];
            
            
            
            
        }
        AMapDistrictSearchRequest *privinceRequest = [[AMapDistrictSearchRequest alloc] init];
        privinceRequest.keywords = self.sheng;
        privinceRequest.subdistrict = 0;
        privinceRequest.requireExtension = YES;
        
        [self.search AMapDistrictSearch:privinceRequest];
        
        AMapDistrictSearchRequest *cityRequest = [[AMapDistrictSearchRequest alloc] init];
        cityRequest.keywords = self.shi;
        cityRequest.subdistrict = 0;
        cityRequest.requireExtension = YES;
        
        [self.search AMapDistrictSearch:cityRequest];
        NSLog(@"dizhi ======   %@", response.regeocode.formattedAddress);
        [SYIToast alertWithTitleBottom:response.regeocode.formattedAddress];
        [self.tableView reloadData];
    }
}
- (void)onDistrictSearchDone:(AMapDistrictSearchRequest *)request response:(AMapDistrictSearchResponse *)response
{
    
    if (response == nil)
    {
        
        
        return;
    }
    
    if ([request.keywords isEqualToString:self.sheng]) {
        self.provinceAcode = response.districts.firstObject.adcode;
    }
    
    if ([request.keywords isEqualToString:self.shi]) {
        self.cityAcode = response.districts.firstObject.adcode;
    }
    
    
}
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    self.addressComponet = nil;
    [self.pois removeAllObjects];
    for (AMapPOI *poi in response.pois) {
        
        [self.pois addObject:poi];
    }
    [self.tableView reloadData];
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    NSLog(@"输出🍀 %@",error);
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark----定位
- (void)dingwei{
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout =2;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;
    
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        NSLog(@"location:%@", location);
        
        self.userGeoPoint.latitude = location.coordinate.latitude;
        self.userGeoPoint.longitude = location.coordinate.longitude;
        CLLocationCoordinate2D locations = CLLocationCoordinate2DMake(self.userGeoPoint.latitude, self.userGeoPoint.longitude);
        [self.mapView setCenterCoordinate:locations animated:YES];
        //        [self centerAnnotationAnimimate];
        
        
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode.province);
            
            
        }
    }];
}

- (EquipmentViewModel *)equimentViewModel
{
    if (_equimentViewModel == nil) {
        _equimentViewModel = [[EquipmentViewModel alloc]init];
    }
    return _equimentViewModel;
}
@end
