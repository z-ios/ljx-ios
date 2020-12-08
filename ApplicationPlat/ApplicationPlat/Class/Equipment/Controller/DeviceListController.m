//
//  DeviceListController.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/9.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "DeviceListController.h"
#import "DeviceListCell.h"
#import "SearchController.h"
#import "EquipmentViewModel.h"
#import "BreakerModel.h"
#import "GUSearchBar.h"
#import "SearchModel.h"
#import "ReportController.h"
#import "NewBreakerController.h"
#import "AddressFromMapViewController.h"
#import "LocModel.h"
#import "LocationModel.h"
#import "DeviceAddressSelectController.h"
@interface DeviceListController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,SearchControllerDelegate,MGSwipeTableCellDelegate>
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, assign) NSInteger pageIndex;
@property(nonatomic, strong) EquipmentViewModel *equimentViewModel;
@property(nonatomic, copy) NSString *macStr;
@property(nonatomic, copy) NSString *start_datetime;
@property(nonatomic, copy) NSString *end_datetime;
@property(nonatomic, copy) NSString *province_adcode;
@property(nonatomic, copy) NSString *city_adcode;
@property(nonatomic, copy) NSString *district_adcode;
@property(nonatomic, copy) NSString *street_adcode;

@property(nonatomic, copy) NSString *totalStr;
//@property(nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic, strong) GUSearchBar * searchBar;
@property(nonatomic, strong)UILabel *totalLab;
@end

@implementation DeviceListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = ColorString(@"#2E3C4D");
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    titleLabel.font = PingFangSCRegular(17);
    
    titleLabel.textColor = ColorString(@"#2E3C4D");
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.title;
    self.navigationItem.titleView = titleLabel;
    [self initNavi];
    [self.view addSubview:self.tableView];
    [self refishData];
    
    
    
}
- (void)addDevice:(NSNotification *)noti{
    
    
    
    //这个方法的参数就是发送通知postNotification:方法的参数发送过来额通知。当要使用传递的userInfo的时候，就要使用noti解析出userInfo中需要的字段
    
    [self.tableView.mj_header beginRefreshing];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage coloreImage:[UIColor whiteColor]] forBarMetrics:(UIBarMetricsDefault)];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
    //创建通知中心对象
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    //注册、接收通知
    
    [center addObserver:self selector:@selector(addDevice:) name:@"notification" object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    //    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"notification" object:nil];
    
    
}
- (void)initNavi
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = YES;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [btn setImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* litem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn setTitle:@"     " forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = litem;
    
    UIButton *rBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [rBtn setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
    [rBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* ritem = [[UIBarButtonItem alloc] initWithCustomView:rBtn];
    self.navigationItem.rightBarButtonItem = ritem;
}
- (void)backAction
{
    //    [self.navigationController popViewControllerAnimated:YES];
    [self.searchBar resignFirstResponder];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (void)addAction
{
    ReportController *vc = [[ReportController alloc]init];
    vc.typeName = self.title;
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
    navi.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:navi animated:YES completion:nil];
}
- (void)searchAction
{
    SearchController *vc = [[SearchController alloc]init];
    vc.delegate = self;
    UINavigationController *searchNav = [[UINavigationController alloc] initWithRootViewController:vc];
    searchNav.modalPresentationStyle = 0;
    [self.navigationController presentViewController:searchNav animated:YES completion:nil];
    
}




#pragma mark -- 刷新数据
- (void)refishData
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageIndex = 1;
        [self.dataArray removeAllObjects];
        [self getData];
        [self getCountData];
        
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.pageIndex ++;
        [self getData];
        [self getCountData];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 30 * HeightScale)];
    view.backgroundColor = [UIColor whiteColor];
    self.totalLab = [[UILabel alloc]initWithFrame:CGRectMake(20 * WidthScale, 5 * HeightScale, 120 * WidthScale, 20 * HeightScale)];
    _totalLab.textColor = ColorString(@"#0091FF");
    _totalLab.font = PingFangSCRegular(13);
    _totalLab.text = _totalStr;
    [view addSubview:_totalLab];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80 * HeightScale;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30 * HeightScale;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DeviceListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.accessoryView = [UIButton z_setImageName:@"back" frame:CGRectMake(0, 0, 6, 11)];
    
    BreakerModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.delegate = self;
    cell.model = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewBreakerController *vc = [[NewBreakerController alloc]init];
    NSArray *eqArray = self.dataArray;
    
    BreakerModel *model = [eqArray objectAtIndex:indexPath.row];
    
    vc.title = model.gateway.node_Id;
    vc.iId = model.iId;
    vc.isDiss = @"present";
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)searchDoneWithParmas:(SearchModel *)model
{
    self.macStr = model.mac;
    self.start_datetime = model.start_datetime;
    self.end_datetime = model.end_datetime;
    self.province_adcode = model.province_adcode;
    self.city_adcode = model.city_adcode;
    self.district_adcode = model.district_adcode;
    self.street_adcode = model.street_adcode;
    [self.tableView.mj_header beginRefreshing];
    
}
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;;
}


- (void)getData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSDictionary *pagerDic = @{@"page_number":[NSNumber numberWithInteger:self.pageIndex],@"page_size":@30};
    params[@"pager"] = pagerDic;
    
    NSMutableDictionary *filterDic = [NSMutableDictionary dictionary];
    if (self.macStr && self.macStr.length != 0 && ![self.macStr isEqualToString:@""] ) {
        filterDic[@"node_Id"] = self.macStr;
    }
    filterDic[@"user_Id"] = Center.shared.userID;

    params[@"filter"] = filterDic;

    [self.equimentViewModel breakerDatasWithParams:params Completion:^(BOOL success, NSArray * _Nonnull dataList, NSString * _Nonnull total, NSString * _Nonnull errorMsg) {
        
        if (success) {
            if (dataList) {
                if (dataList.count>0) {
                    [self.dataArray addObjectsFromArray:dataList];
                    // 空
                    if (dataList.count<30) {
                        [self.tableView.mj_footer setHidden:YES];
                    }else{
                        [self.tableView.mj_footer setHidden:NO];
                    }
                }else{
                    [self.tableView.mj_footer setHidden:NO];
                    
                }
            }else{
                // 空
                [self.tableView.mj_footer setHidden:YES];
                
            }
        }else{
            [CustomAlert alertVcWithMessage:errorMsg Vc:self];
            [self.tableView.mj_footer setHidden:YES];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        [self.tableView reloadData];
    }];
    
    
}
- (void)getCountData
{
    
    NSString *macStr = @"";
    if (self.macStr && self.macStr.length != 0 && ![self.macStr isEqualToString:@""] ) {
        
        macStr = self.macStr;
        
        
    }
    
    [self.equimentViewModel breakerCountWithParams:macStr Completion:^(BOOL success, NSString * _Nonnull count, NSString * _Nonnull errorMsg) {
        if (!success) {
            [CustomAlert alertVcWithMessage:errorMsg Vc:self];
            
        }
        self.totalStr =  [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"deviceTotalTitle", nil), count];

        self.totalLab.text =  [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"deviceTotalTitle", nil), count];
        
    }];
    
    
    
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 , KScreenWidth, KScreenHeight - Height_NavBar) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 80 * HeightScale;
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 64 * HeightScale)];
        [headerView addSubview:self.searchBar];
        _tableView.tableHeaderView = headerView;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[DeviceListCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableView;
}

- (GUSearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[GUSearchBar alloc] initWithFrame: CGRectMake(20 * WidthScale, 10 * WidthScale, KScreenWidth - 40 * WidthScale, 44 * HeightScale)];
        _searchBar.backgroundColor = ColorString(@"#F6F8FA");
        _searchBar.textColor = ColorString(@"#8F9FB3");
        _searchBar.font = PingFangSCRegular(14);
        [_searchBar borderRoundCornerRadius:22 * HeightScale];
        
        _searchBar.delegate = self;
        
        //        _searchBar.borderStyle = UITextBorderStyleRoundedRect;
        _searchBar.placeholder = NSLocalizedString(@"deviceMACSearchTitle", nil);
        Ivar ivar = class_getInstanceVariable([GUSearchBar class], "_placeholderLabel");
        UILabel *placeholderLabel = object_getIvar(_searchBar, ivar);
        placeholderLabel.textColor = ColorString(@"#8F9FB3");
        _searchBar.returnKeyType = UIReturnKeySearch;
        
        
        _searchBar.keyboardToolbar.hidden = YES;
        
    }
    return _searchBar;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   
    return YES;
}
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//
//
//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self deleteAllBreakerWithIndexPath:indexPath];
//
//    }
//
//}
#pragma mark Swipe Delegate

-(NSArray*) swipeTableCell:(MGSwipeTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings
{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    swipeSettings.transition = MGSwipeTransitionBorder;
    if (direction == MGSwipeDirectionRightToLeft){
        
        
        CZHWeakSelf(self)
        MGSwipeButton * del = [MGSwipeButton buttonWithTitle:@"删除" icon:nil backgroundColor:ColorString(@"#FE4F4C") insets:UIEdgeInsetsMake(0, 0, 0, 0) callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
            [weakself deleteAllBreakerWithIndexPath:indexPath];
            return YES;
        }];
        
        BreakerModel *model = [self.dataArray objectAtIndex:indexPath.row];

        MGSwipeButton * loaction = [MGSwipeButton buttonWithTitle:@"编辑" icon:nil backgroundColor:ColorString(@"#26C464") insets:UIEdgeInsetsMake(0, 0, 0, 0) callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
            
            [weakself changeLocationWithModel:model indexPath:indexPath];
            return YES;
        }];
        
        
        del.buttonWidth = 80 * WidthScale;
        loaction.buttonWidth = 80 * WidthScale;

        return @[del,loaction];
        
        
        
    }
    
    
    
    
    return nil;
    
}

-(void) swipeTableCellWillBeginSwiping:(nonnull MGSwipeTableCell *) cell
{
//    NSLog(@"开始=============");
    cell.swipeContentView.layer.cornerRadius = 0;
    cell.swipeContentView.layer.masksToBounds = YES;
}
-(void) swipeTableCellWillEndSwiping:(nonnull MGSwipeTableCell *) cell
{
    cell.swipeContentView.layer.cornerRadius = 12;
    cell.swipeContentView.layer.masksToBounds = NO;
    
//    NSLog(@"结束=============");
}
#pragma mark --  删除整套断路器
- (void)deleteAllBreakerWithIndexPath:(NSIndexPath *)indexPath
{
    
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"是否删除断路器？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setCancelBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *comAc = [UIAlertAction actionWithTitle:NSLocalizedString(@"setDefineBtn", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        BreakerModel *model = [self.dataArray objectAtIndex:indexPath.row];
        CZHWeakSelf(self)
        [self.equimentViewModel deleteBreakerWithParams:model.iId Completion:^(BOOL success, NSString * _Nonnull errorMsg) {
            
            if (success) {
                [weakself.dataArray removeObject:model];
                [weakself.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                //                self.totalLab.text = [NSString stringWithFormat:@"%@%lu",NSLocalizedString(@"deviceTotalTitle", nil), (unsigned long)weakself.dataArray.count];
                [weakself getCountData];
                
                
            }else{
                [CustomAlert alertVcWithMessage:errorMsg Vc:self];
            }
        }];
        
    }];
    [alertVc addAction:cancleAc];
    [alertVc addAction:comAc];
    [self presentViewController:alertVc animated:YES completion:nil];
    
    
    
    
}
#pragma mark -- 更改位置
- (void)changeLocationWithModel:(BreakerModel *)model indexPath:(NSIndexPath *)indexPath
{
//    AddressFromMapViewController *vc = [[AddressFromMapViewController alloc]init];
//    CZHWeakSelf(self)
//    vc.selectedEvent = ^(NSString *lat, NSString *lon, NSString *address, NSString *sheng, NSString *shi, NSString *qu, NSString *dao,NSString *provinceAcode,NSString *cityAcode,NSString *districeAcode, NSString *streetAcode) {
//        LocModel *locModel = [[LocModel alloc]init];
//        locModel.country_name = @"中国";
//        locModel.country_adcode = @"100000";
//        locModel.province_name = sheng;
//        locModel.province_adcode = provinceAcode;
//        locModel.city_name = shi;
//        locModel.city_adcode = cityAcode;
//        locModel.district_name = qu;
//        locModel.district_adcode = districeAcode;
//        locModel.street_name = dao;
//        locModel.street_adcode = streetAcode;
//        locModel.address = address;
//        locModel.lat = lat;
//        locModel.lng = lon;
//        NSDictionary *params = @{@"country_name":@"中国",@"country_adcode":@"100000", @"province_name":sheng,@"province_adcode":provinceAcode,@"city_name":shi,@"city_adcode":cityAcode,@"district_name":qu,
//                                 @"district_adcode":districeAcode,@"street_name":dao,@"street_adcode":streetAcode
//                                 ,@"address":address,@"lat":lat,@"lng":lon};
//
//        [weakself changeLocationWithParams:params model:model locModel:locModel indexPath:indexPath];
//    };
//    [self.navigationController pushViewController:vc animated:YES];
    
    DeviceAddressSelectController *vc = [[DeviceAddressSelectController alloc]init];
    vc.model = model;
    CZHWeakSelf(self)
    vc.selectedEvent = ^(BOOL isSuccess, LocationModel * _Nonnull model1) {
        model.location = model1;
        [weakself.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)changeLocationWithParams:(NSDictionary *)params model:(BreakerModel *)model locModel:(LocModel *)locModel indexPath:(NSIndexPath *)indexPath
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
      
            [weakself.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
        }else{
            [CustomAlert alertVcWithMessage:errorMsg Vc:self];

        }
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return  [textField resignFirstResponder];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.macStr = textField.text;
    [self.tableView.mj_header beginRefreshing];
    
}


- (EquipmentViewModel *)equimentViewModel
{
    if (_equimentViewModel == nil) {
        _equimentViewModel = [[EquipmentViewModel alloc]init];
    }
    return _equimentViewModel;
}
- (void)dealloc
{
    //    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"notification" object:nil];
    
}
@end
