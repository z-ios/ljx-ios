//
//  EquipmentController.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/8.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "EquipmentController.h"
#import "EquipmentModel.h"
#import "EquipmentViewModel.h"
#import "DeviceListController.h"
#import "EquipmentCell.h"
#import "GUSearchBar.h"
#import "LLSearchViewController.h"
#import "WPFPinYinDataManager.h"
#import "WPFPerson.h"
@interface EquipmentController ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate, UISearchBarDelegate,UISearchControllerDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)EquipmentViewModel *equimentViewModel;
@property(nonatomic, strong) UISearchController *searchController;
@property(nonatomic, strong) NSMutableArray *searchResultFonts;
@property (nonatomic, strong) NSMutableArray *personModels;
@property (nonatomic, strong) NSMutableArray *eqModels;
@property(nonatomic, strong) GUSearchBar * searchBar;
@property (nonatomic, strong) HanyuPinyinOutputFormat *outputFormat;

@end

@implementation EquipmentController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    UIBarButtonItem* lItem = [[UIBarButtonItem alloc] initWithCustomView:titleLab];
    titleLab.text = NSLocalizedString(@"typeTitle", nil);
    titleLab.textColor = ColorString(@"#2E3C4D");
    
    titleLab.font = PingFangSCSemibold(20);
    self.navigationItem.leftBarButtonItem = lItem;
    [self.view addSubview:self.tableView];
    
    
    [self refishData];
    
    [self createUI];
    
}
- (void)createUI
{
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    
}


#pragma mark -- 刷新数据
- (void)refishData
{
    
    
    NSArray *imageArray = @[@"icon_device_duanluqi",@"icon_device_jinggai",@"icon_device_yewei",@"icon_device_menci",@"icon_device_shuijin",@"icon_device_wengan",@"icon_device_yangan"];
    NSArray *titleArray = @[@"智能断路器",@"智能井盖",@"智能液位仪",@"门磁锁控制器",@"水浸告警仪",@"无线温感",@"智能烟感"];
    
    for (int i = 0; i < imageArray.count; i++) {
        EquipmentModel *model = [[EquipmentModel alloc]init];
        model.name = titleArray[i];
        model.phone_icon_url = imageArray[i];
        [self.dataArray addObject:model];
        [self.searchResultFonts addObject:model];
        
        
        NSString *name = titleArray[i];
        [WPFPinYinDataManager addInitializeString:name identifer:[@(i) stringValue]];
        WPFPerson *person = [WPFPerson personWithId:[@(i) stringValue] name:name hanyuPinyinOutputFormat:self.outputFormat];
        [self.personModels addObject:person];
        
        EquipmentResultModel *reModel = [[EquipmentResultModel alloc]init];
        reModel.name = titleArray[i];
        reModel.phone_icon_url = imageArray[i];
        [self.eqModels addObject:reModel];

        
        
    }
    
    
    
    
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-Height_NavBar-Height_TabBar) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 80 * HeightScale;
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 64 * HeightScale)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorColor = [UIColor clearColor];
        [headerView addSubview:self.searchBar];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableHeaderView = headerView;
    }
    return _tableView;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 30 * HeightScale)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20 * WidthScale, 5 * HeightScale, 150 * WidthScale, 20 * HeightScale)];
    label.text = NSLocalizedString(@"typeSubtitle", nil);
    label.textColor = ColorString(@"#7A8899");
    label.font = PingFangSCRegular(13);
    [view addSubview:label];
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
    if ([_searchBar.text isEqualToString:@""]) {
        NSArray *eqArray = self.dataArray;
        return eqArray.count;

    }else{
        NSArray *eqArray = self.searchResultFonts;
        return eqArray.count;

    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if ([_searchBar.text isEqualToString:@""]) {
        NSArray *eqArray = self.dataArray;

        EquipmentModel *model =[eqArray objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:model.phone_icon_url];
        cell.textLabel.text = model.name;
        cell.textLabel.textColor = ColorString(@"#242B33");

    }else{
        NSArray *eqArray = self.searchResultFonts;

        EquipmentResultModel *model = [eqArray objectAtIndex:indexPath.row];
       // 设置关键字高亮
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.name];
        UIColor *highlightedColor = DefaColor;
        [attributedString addAttribute:NSForegroundColorAttributeName value:highlightedColor range:model.textRange];
        cell.textLabel.attributedText = attributedString;
        cell.imageView.image = [UIImage imageNamed:model.phone_icon_url];
//        cell.textLabel.text = model.name;
    }
    
    
    
  
    cell.textLabel.font = PingFangSCRegular(16);
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryView = [UIButton z_setImageName:@"back" frame:CGRectMake(0, 0, 6, 11)];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_searchBar resignFirstResponder];
    NSArray *eqArray = [NSArray array];
    if ([_searchBar.text isEqualToString:@""]) {
        eqArray = self.dataArray;
    }else{
        eqArray = self.searchResultFonts;
    }
    EquipmentModel *model =[eqArray objectAtIndex:indexPath.row];
    if ([model.name isEqualToString:@"智能断路器"]) {
        
        DeviceListController *vc = [[DeviceListController alloc]init];
        NSArray *eqArray = self.dataArray;
        
        EquipmentModel *model = [eqArray objectAtIndex:indexPath.row];
        
        vc.title = model.name;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        FFToast *toast = [[FFToast alloc]initToastWithTitle:@"此功能暂未开放" message:nil iconImage:nil];
        toast.duration = 3.f;
        toast.toastType = FFToastTypeDefault;
        toast.toastPosition = FFToastPositionBottomWithFillet;
        [toast show];
    }
    
}


- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;;
}


- (EquipmentViewModel *)equimentViewModel
{
    if (_equimentViewModel == nil) {
        _equimentViewModel = [[EquipmentViewModel alloc]init];
    }
    return _equimentViewModel;
}
- (GUSearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[GUSearchBar alloc] initWithFrame: CGRectMake(20 * WidthScale, 10 * WidthScale, KScreenWidth - 40 * WidthScale, 44 * HeightScale)];
        _searchBar.backgroundColor =ColorString(@"#F6F8FA");
        _searchBar.textColor = ColorString(@"#8F9FB3");
        _searchBar.font = PingFangSCRegular(14);
//        _searchBar.layer.borderColor = ColorString(@"#E6EBF0").CGColor;
//        _searchBar.layer.borderWidth = 1;
        _searchBar.delegate = self;
        [_searchBar borderRoundCornerRadius:22 * HeightScale];
        _searchBar.placeholder =NSLocalizedString(@"typeSearchTitle", nil);
        Ivar ivar = class_getInstanceVariable([GUSearchBar class], "_placeholderLabel");
        UILabel *placeholderLabel = object_getIvar(_searchBar, ivar);
        placeholderLabel.textColor = ColorString(@"#8F9FB3");
        _searchBar.returnKeyType = UIReturnKeySearch;
        
        _searchBar.keyboardToolbar.hidden = YES;
        [_searchBar addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    }
    return _searchBar;
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField{
    if (textField.markedTextRange == nil) {
        
//        NSLog(@"text:%@", textField.text);
        [self searchMatchWithKeyWord:textField.text];

    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
//    self.tableView.userInteractionEnabled = YES;

}
- (void)searchMatchWithKeyWord:(NSString *)keyWord
{
//    NSDate *beginTime = [NSDate date];
//    NSLog(@"开始匹配，开始时间：%@", beginTime);
    
    NSMutableArray *resultDataSource = [NSMutableArray array];
    for (int i =0 ; i < self.personModels.count; i++) {
        WPFPerson *person = [self.personModels objectAtIndex:i];
        EquipmentResultModel *model = [self.eqModels objectAtIndex:i];
        WPFSearchResultModel *resultModel = [WPFPinYinTools searchEffectiveResultWithSearchString:keyWord Person:person];
        
        if (resultModel.highlightedRange.length) {
            model.highlightLoaction = resultModel.highlightedRange.location;
            model.textRange = resultModel.highlightedRange;
            model.matchType = resultModel.matchType;
            model.name = person.name;
            [resultDataSource addObject:model];
        }
    }
    
    self.searchResultFonts = resultDataSource;
    
    [self.searchResultFonts sortUsingDescriptors:[WPFPinYinTools sortingRules]];
//
//    NSDate *endTime = [NSDate date];
//    NSTimeInterval costTime = [endTime timeIntervalSinceDate:beginTime];
//    NSLog(@"匹配结束，结束时间：%@，耗时：%.4f", endTime, costTime);
    CZHWeakSelf(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakself.tableView reloadData];
    });
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
- (NSMutableArray *)searchResultFonts
{
    if (_searchResultFonts == nil) {
        _searchResultFonts = [NSMutableArray array];
    }
    return _searchResultFonts;;
}

- (NSMutableArray *)personModels
{
    if (_personModels == nil) {
        _personModels = [NSMutableArray array];
    }
    return _personModels;
}
- (NSMutableArray *)eqModels
{
    if (_eqModels == nil) {
        _eqModels = [NSMutableArray array];
    }
    return _eqModels;
}
- (HanyuPinyinOutputFormat *)outputFormat {
    if (!_outputFormat) {
        _outputFormat = [WPFPinYinTools getOutputFormat];
    }
    return _outputFormat;
}

@end
