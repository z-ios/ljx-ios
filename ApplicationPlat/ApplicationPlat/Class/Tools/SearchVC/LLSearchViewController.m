//
//  LLSearchViewController.m
//  LLSearchView
//
//  Created by 王龙龙 on 2017/7/25.
//  Copyright © 2017年 王龙龙. All rights reserved.
//

#import "LLSearchViewController.h"
#import "LLSearchResultViewController.h"
#import "LLSearchSuggestionVC.h"
#import "LLSearchView.h"
#import "DeviceListController.h"
#import "EquipmentModel.h"
@interface LLSearchViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) LLSearchView *searchView;
@property (nonatomic, strong) NSMutableArray *hotArray;
@property (nonatomic, strong) NSMutableArray *historyArray;
@property (nonatomic, strong) LLSearchSuggestionVC *searchSuggestVC;

@end

@implementation LLSearchViewController

- (NSMutableArray *)hotArray
{
    if (!_hotArray) {
        self.hotArray = [NSMutableArray arrayWithObjects:@"断路器", @"井盖", @"液位仪", @"控制器",@"烟感",@"温感", nil];
    }
    return _hotArray;
}

- (NSMutableArray *)historyArray
{
    if (!_historyArray) {
        _historyArray = [NSKeyedUnarchiver unarchiveObjectWithFile:KHistorySearchPath];
        if (!_historyArray) {
            self.historyArray = [NSMutableArray array];
        }
    }
    return _historyArray;
}


- (LLSearchView *)searchView
{
    if (!_searchView) {
        self.searchView = [[LLSearchView alloc] initWithFrame:CGRectMake(0, Height_NavBar, KScreenWidth, KScreenHeight - Height_NavBar) hotArray:self.hotArray historyArray:self.historyArray];
        __weak LLSearchViewController *weakSelf = self;
        _searchView.tapAction = ^(NSString *str) {
            //            [weakSelf pushToSearchResultWithSearchStr:str];
            
            if (str == nil || [str length] <= 0) {
                weakSelf.searchSuggestVC.view.hidden = YES;
                [weakSelf.view bringSubviewToFront:weakSelf.searchView];
            } else {
                weakSelf.searchBar.text = str;
                weakSelf.searchSuggestVC.view.hidden = NO;
                [weakSelf.view bringSubviewToFront:weakSelf.searchSuggestVC.view];
                [weakSelf.searchSuggestVC searchTestChangeWithTest:str];
            }
        };
    }
    return _searchView;
}


- (LLSearchSuggestionVC *)searchSuggestVC
{
    if (!_searchSuggestVC) {
        self.searchSuggestVC = [[LLSearchSuggestionVC alloc] init];
        _searchSuggestVC.view.frame = CGRectMake(0, Height_NavBar, KScreenWidth, KScreenHeight - Height_NavBar);
        _searchSuggestVC.view.hidden = YES;
        __weak LLSearchViewController *weakSelf = self;
        _searchSuggestVC.searchBlock = ^(NSInteger index, EquipmentModel *model) {
            [weakSelf pushToSearchResultWithSearchStr:index equipmentModel:model];
            
        };
        
    }
    return _searchSuggestVC;
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!_searchBar.isFirstResponder) {
        [self.searchBar becomeFirstResponder];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 回收键盘
    [self.searchBar resignFirstResponder];
    _searchSuggestVC.view.hidden = YES;
    _historyArray = [NSKeyedUnarchiver unarchiveObjectWithFile:KHistorySearchPath];

    [_searchView reloadHistoryArray:_historyArray];
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = YES;
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBarButtonItem];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.searchSuggestVC.view];
    [self addChildViewController:_searchSuggestVC];
    _searchSuggestVC.array = self.array;
    
}


- (void)setBarButtonItem
{
    [self.navigationItem setHidesBackButton:YES];
    // 创建搜索框
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, self.view.frame.size.width, 40)];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(titleView.frame) - 65, 40)];
    searchBar.placeholder = NSLocalizedString(@"typeSearchTitle", nil);
    searchBar.backgroundImage = [UIImage imageNamed:@"clearImage"];
    searchBar.delegate = self;
    searchBar.showsCancelButton = NO;
    UITextField *searchTextField = [searchBar valueForKey:@"searchField"];
    searchTextField.backgroundColor = [UIColor colorWithRed:234/255.0 green:235/255.0 blue:237/255.0 alpha:1];
    searchTextField.font = [UIFont systemFontOfSize:14];
    searchTextField.layer.cornerRadius = 15;
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(searchBar.right + 5, 0, 50, 40)];
    [cancleBtn addTarget:self action:@selector(presentVCFirstBackClick:) forControlEvents:UIControlEventTouchUpInside];
    //修改标题和标题颜色setCancelBtn
    [cancleBtn setTitle:NSLocalizedString(@"setCancelBtn", nil) forState:UIControlStateNormal];
    [cancleBtn setTitleColor:DefaColor forState:UIControlStateNormal];
//    [searchBar.qmui_backgroundView removeFromSuperview];
    [titleView addSubview:searchBar];
    [titleView addSubview:cancleBtn];
    self.searchBar = searchBar;
    [self.searchBar becomeFirstResponder];
    self.navigationItem.titleView = titleView;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
}


- (void)presentVCFirstBackClick:(UIButton *)sender
{
    if ([self.searchBar isFirstResponder]) {
        
        [self.searchBar resignFirstResponder];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


/** 点击取消 */
- (void)cancelDidClick
{
    [self.searchBar resignFirstResponder];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void)pushToSearchResultWithSearchStr:(NSInteger )index equipmentModel:(EquipmentModel *)model
{
        
    
    [self setHistoryArrWithStr:self.searchBar.text];
    self.searchBar.text = @"";
    if ([model.name isEqualToString:@"智能断路器"]) {
        DeviceListController *vc = [[DeviceListController alloc]init];
        vc.title = model.name;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];

        FFToast *toast = [[FFToast alloc]initToastWithTitle:@"此功能暂未开放" message:nil iconImage:nil];
        toast.duration = 3.f;
        toast.toastType = FFToastTypeDefault;
        toast.toastPosition = FFToastPositionBottomWithFillet;
        [toast show];
    }
  
  
}

- (void)setHistoryArrWithStr:(NSString *)str
{
    for (int i = 0; i < _historyArray.count; i++) {
        if ([_historyArray[i] isEqualToString:str]) {
            [_historyArray removeObjectAtIndex:i];
            break;
        }
    }
    [_historyArray insertObject:str atIndex:0];
    [NSKeyedArchiver archiveRootObject:_historyArray toFile:KHistorySearchPath];
}


#pragma mark - UISearchBarDelegate -


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //    [self pushToSearchResultWithSearchStr:searchBar.text];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    if ([self.searchBar isFirstResponder]) {
        
        [self.searchBar resignFirstResponder];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
//    searchBar.showsCancelButton = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchBar.text == nil || [searchBar.text length] <= 0) {
        _searchSuggestVC.view.hidden = YES;
        [self.view bringSubviewToFront:_searchView];
    } else {
        _searchSuggestVC.view.hidden = NO;
        [self.view bringSubviewToFront:_searchSuggestVC.view];
        [_searchSuggestVC searchTestChangeWithTest:searchBar.text];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
