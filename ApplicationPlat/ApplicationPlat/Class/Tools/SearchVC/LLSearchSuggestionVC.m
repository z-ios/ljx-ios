//
//  LLSearchSuggestionVC.m
//  LLSearchView
//
//  Created by 王龙龙 on 2017/7/25.
//  Copyright © 2017年 王龙龙. All rights reserved.
//

#import "LLSearchSuggestionVC.h"
#import "EquipmentCell.h"

#import "WPFPinYinDataManager.h"
#import "WPFPerson.h"
#import "EquipmentResultModel.h"
@interface LLSearchSuggestionVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentView;
@property (nonatomic, copy)   NSString *searchTest;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *personModels;
@property (nonatomic, strong) NSMutableArray *eqModels;

@property (nonatomic, strong) HanyuPinyinOutputFormat *outputFormat;

@end

@implementation LLSearchSuggestionVC

- (UITableView *)contentView
{
    if (!_contentView) {
        self.contentView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
        _contentView.delegate = self;
        _contentView.dataSource = self;
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.tableFooterView = [UIView new];
    }
    return _contentView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.contentView];
}
- (void)setArray:(NSArray *)array
{
    _array = array;
    [self _initializeData];
    
}
#pragma mark - Private Method
- (void)_initializeData {
    
    
    NSDate *beginTime = [NSDate date];
    NSLog(@"开始解析数据了，开始时间：%@，数据条数：%ld", beginTime, (unsigned long)self.array.count);
    
    // 以下测试数据均为 iPhone SE（10.2） 真机测试
    
    
    /**
     2017-12-06 11:53:51.251045 HighlightedSearch[4407:1868685] 开始解析数据了，开始时间：2017-12-06 03:53:51 +0000，数据条数：1006
     2017-12-06 11:53:53.052466 HighlightedSearch[4407:1868685] 解析结束，结束时间：2017-12-06 03:53:53 +0000，耗时：1.8038 秒
     */
    // 使用容器的block版本的枚举器时，内部会自动添加一个AutoreleasePool：
    //    NSLog(@"personArray-->%p", personArray);
    //    dispatch_queue_t queue = dispatch_queue_create("wpf.initialize.test", DISPATCH_QUEUE_SERIAL);
    //    [personArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
    /**
     2017-12-06 11:51:17.994211 HighlightedSearch[4387:1867649] 开始解析数据了，开始时间：2017-12-06 03:51:17 +0000，数据条数：1006
     2017-12-06 11:51:19.064917 HighlightedSearch[4387:1867649] 解析结束，结束时间：2017-12-06 03:51:19 +0000，耗时：1.0728 秒
     */
    //    for (NSString *name in personArray) {
    /**
     2017-12-06 11:52:08.656280 HighlightedSearch[4397:1868099] 开始解析数据了，开始时间：2017-12-06 03:52:08 +0000，数据条数：1006
     2017-12-06 11:52:09.683399 HighlightedSearch[4397:1868099] 解析结束，结束时间：2017-12-06 03:52:09 +0000，耗时：1.0291 秒
     */
    //    NSArray * arr1 = [WPFPinYinDataManager getInitializedDataSource];
    //
    //    NSArray * arr2 = self.array;
    //
    //     NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",arr1];
    //
    //     NSArray * filter = [arr2 filteredArrayUsingPredicate:filterPredicate];
    //    NSLog(@"%@",filter);
//    NSMutableArray *arr1 = [NSMutableArray array];
//    NSMutableArray *arr2 = [NSMutableArray array];
//    NSLog(@"shujuData ===== %@", [WPFPinYinDataManager getInitializedDataSource]);
//    for (WPFPerson *person in [WPFPinYinDataManager getInitializedDataSource]) {
//        [arr1 addObject:person.name];
//    }
//    for (EquipmentModel *eqModel in self.array) {
//        [arr2 addObject:eqModel.name];
//    }
//    NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",arr1];
//    NSArray * filter = [arr2 filteredArrayUsingPredicate:filterPredicate];
    for (NSInteger i = 0; i < self.array.count; ++i) {
        @autoreleasepool {
            EquipmentResultModel *model = [[EquipmentResultModel alloc]init];
            EquipmentModel *eqModel = [self.array objectAtIndex:i];
            model.name = eqModel.name;
            model.descriptions = eqModel.descriptions;
            model.web_icon_url = eqModel.web_icon_url;
            model.phone_icon_url = eqModel.phone_icon_url;
            model.iId = eqModel.iId;

            NSString *name = eqModel.name;
            [WPFPinYinDataManager addInitializeString:name identifer:[@(i) stringValue]];
            WPFPerson *person = [WPFPerson personWithId:[@(i) stringValue] name:name hanyuPinyinOutputFormat:self.outputFormat];
            [self.personModels addObject:person];
            [self.eqModels addObject:model];
        }
    }
    
    NSDate *endTime = [NSDate date];
    NSTimeInterval costTime = [endTime timeIntervalSinceDate:beginTime];
    NSLog(@"解析结束，结束时间：%@，耗时：%.4f 秒", endTime, costTime);
    
}
- (void)searchTestChangeWithTest:(NSString *)test
{
    _searchTest = test;
    [self searchMatchWithKeyWord:test];
    [_contentView reloadData];
}
- (void)searchMatchWithKeyWord:(NSString *)keyWord
{
    NSDate *beginTime = [NSDate date];
    NSLog(@"开始匹配，开始时间：%@", beginTime);
    
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
//    for (WPFPerson *person in self.personModels) {
//        EquipmentResultModel *model = self;
//
//        WPFSearchResultModel *resultModel = [WPFPinYinTools searchEffectiveResultWithSearchString:keyWord Person:person];
//
//        if (resultModel.highlightedRange.length) {
//            model.highlightLoaction = resultModel.highlightedRange.location;
//            model.textRange = resultModel.highlightedRange;
//            model.matchType = resultModel.matchType;
//            model.name = person.name;
//            [resultDataSource addObject:model];
//        }
//
//    }
//    NSLog(@"shuju ===== %lu", (unsigned long)[WPFPinYinDataManager getInitializedDataSource].count);
//    NSLog(@"pipei =====  %lu", (unsigned long)resultDataSource.count);
    self.dataArray = resultDataSource;
    
    [self.dataArray sortUsingDescriptors:[WPFPinYinTools sortingRules]];
    
    NSDate *endTime = [NSDate date];
    NSTimeInterval costTime = [endTime timeIntervalSinceDate:beginTime];
    NSLog(@"匹配结束，结束时间：%@，耗时：%.4f", endTime, costTime);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.contentView reloadData];
    });
    
}

#pragma mark - UITableViewDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellIdentifier";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
//    }
//    WPFPerson *person = self.dataArray[indexPath.row];
//    // 设置关键字高亮
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:person.name];
//    UIColor *highlightedColor = [UIColor colorWithRed:0 green:131/255.0 blue:0 alpha:1.0];
//    [attributedString addAttribute:NSForegroundColorAttributeName value:highlightedColor range:person.textRange];
//    cell.textLabel.attributedText = attributedString;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    NSArray *eqArray = self.dataArray;
    
    EquipmentResultModel *model = [eqArray objectAtIndex:indexPath.row];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    
//    cell.resuletModel = model;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:model.phone_icon_url];
    cell.textLabel.font = PingFangSCRegular(16);
    cell.textLabel.textColor = ColorString(@"#242B33");
    cell.textLabel.text = model.name;
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryView = [UIButton z_setImageName:@"back" frame:CGRectMake(0, 0, 6, 11)];

    return cell;
}


#pragma mark - UITableViewDelegate -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80 * HeightScale;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchBlock) {
        EquipmentModel *model = [[EquipmentModel alloc]init];
        NSArray *eqArray = self.dataArray;
        
        EquipmentResultModel *eqModel = [eqArray objectAtIndex:indexPath.row];
        model.name = eqModel.name;
        model.descriptions = eqModel.descriptions;
        model.web_icon_url = eqModel.web_icon_url;
        model.phone_icon_url = eqModel.phone_icon_url;
        model.iId = eqModel.iId;
        self.searchBlock(indexPath.row,model);
    }
}


- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
