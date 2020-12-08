//
//  DeviceTypeView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/2.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "DeviceTypeView.h"
#import "EquipmentViewModel.h"
#import "DeviceTypeCell.h"
#import "EquipmentModel.h"
#import "EquipmentResultModel.h"
#import "WPFPinYinDataManager.h"
#import "WPFPerson.h"
@interface DeviceTypeView ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>
@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) GUSearchBar * searchBar;
@property(nonatomic, strong) EquipmentViewModel *equimentViewModel;
@property(nonatomic, strong) NSMutableArray *searchResultFonts;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, copy) NSString *searchStr;
@property (nonatomic, strong) NSMutableArray *personModels;
@property (nonatomic, strong) NSMutableArray *eqModels;

@property (nonatomic, strong) HanyuPinyinOutputFormat *outputFormat;
@end

@implementation DeviceTypeView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.searchStr = @"";
        [self borderRoundCornerRadius:18];
        [self getData];
        [self createUI];
        
    }
    return self;
}

- (void)getData
{

    
    NSArray *imageArray = @[@"icon_device_duanluqi",@"icon_device_jinggai",@"icon_device_yewei",@"icon_device_menci",@"icon_device_shuijin",@"icon_device_wengan",@"icon_device_yangan"];
    NSArray *titleArray = @[@"智能断路器",@"智能井盖",@"智能液位仪",@"门磁锁控制器",@"水浸告警仪",@"无线温感",@"智能烟感"];
    
    for (int i = 0; i < imageArray.count; i++) {
        EquipmentModel *model = [[EquipmentModel alloc]init];
        model.name = titleArray[i];
        model.phone_icon_url = imageArray[i];
        [self.dataArray addObject:model];
        [self.searchResultFonts addObject:model];
        
    }
    [self _initializeData];
    
    
}
- (void)createUI
{
    self.width = KScreenWidth - 30 * WidthScale;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20 * WidthScale, 20 * HeightScale, self.width - 80 * WidthScale, 33 * HeightScale)];
    label.text = @"选择设备类型";
    label.textColor = ColorString(@"#121212");
    label.font = PingFangSCRegular(22);
    [self addSubview:label];
    
    UIButton *cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width-54 * WidthScale,15 * HeightScale, 34 * WidthScale, 34 * WidthScale)];
    [cancleBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleAction ) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleBtn];
    
    self.searchBar.frame = CGRectMake(20 * WidthScale, label.bottom + 10 * HeightScale, self.width - 40 * WidthScale, 44 * HeightScale);
    [self addSubview:self.searchBar];
    
    
    
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置item的行间距和列间距
    layout.minimumInteritemSpacing = 16 * WidthScale;
    layout.minimumLineSpacing = 10 * HeightScale;
    
    // 设置item的大小
    CGFloat itemW = (self.width - 16 * WidthScale * 2 - 20 * WidthScale * 2) / 3;
    if (IS_IPHONE_8) {
        
        layout.itemSize = CGSizeMake(itemW, itemW  - 20 * HeightScale );
    }else{
        layout.itemSize = CGSizeMake(itemW, itemW);
    }
    
    //    // 设置每个分区的 上左下右 的内边距
    layout.sectionInset = UIEdgeInsetsMake(10 * HeightScale, 16 * WidthScale,10 * HeightScale, 16 * WidthScale);
    //
    //    // 设置区头和区尾的大小
    //    layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 65);
    //    layout.footerReferenceSize = CGSizeMake(SCREEN_WIDTH, 65);
    
    // 设置分区的头视图和尾视图 是否始终固定在屏幕上边和下边
    layout.sectionFootersPinToVisibleBounds = YES;
    
    // 设置滚动条方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _searchBar.bottom + 10 * HeightScale, self.width, self.height - _searchBar.bottom - 20 * HeightScale) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsVerticalScrollIndicator = NO;   //是否显示滚动条
    _collectionView.scrollEnabled = YES;  //滚动使能
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[DeviceTypeCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    //3、添加到控制器的view
    [self addSubview:_collectionView];
}
- (void)cancleAction
{
    self.determineBlock();
    
}
#pragma mark -collectionview 数据源方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *eqArray = [self.searchStr isEqualToString:@""]? self.dataArray: self.searchResultFonts;
    
    return eqArray.count;  //每个section的Item数
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{    
    DeviceTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    NSArray *eqArray = [self.searchStr isEqualToString:@""] ? self.dataArray: self.searchResultFonts;
    //    EquipmentModel *model = [eqArray objectAtIndex:indexPath.row];
    //    cell.titleLab.text = model.name;
    
    if ([_searchBar.text isEqualToString:@""]) {
        NSArray *eqArray = self.dataArray;
        
        EquipmentModel *model =[eqArray objectAtIndex:indexPath.row];
        cell.titleLab.text = model.name;
        cell.titleLab.textColor = ColorString(@"#242B33");
        [cell.imageV setImage:[UIImage imageNamed:model.phone_icon_url] forState:UIControlStateNormal];
        
    }else{
        NSArray *eqArray = self.searchResultFonts;
        
        EquipmentResultModel *model = [eqArray objectAtIndex:indexPath.row];
        // 设置关键字高亮
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.name];
        UIColor *highlightedColor = DefaColor;
        [attributedString addAttribute:NSForegroundColorAttributeName value:highlightedColor range:model.textRange];
        cell.titleLab.attributedText = attributedString;
        [cell.imageV setImage:[UIImage imageNamed:model.phone_icon_url] forState:UIControlStateNormal];
        
    }
    
    
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [_searchBar resignFirstResponder];
    NSArray *eqArray = [self.searchStr isEqualToString:@""] ? self.dataArray: self.searchResultFonts;
    EquipmentModel *model = [eqArray objectAtIndex:indexPath.row];
    if ([model.name isEqualToString:@"智能断路器"]) {
        self.selectTypeBlock(model.name);

    }else{
        FFToast *toast = [[FFToast alloc]initToastWithTitle:@"此功能暂未开放" message:nil iconImage:nil];
        toast.duration = 3.f;
        toast.toastType = FFToastTypeDefault;
        toast.toastPosition = FFToastPositionBottomWithFillet;
        [toast show];
    }
    
}
#pragma mark - Private Method
- (void)_initializeData {
    
    
//    NSDate *beginTime = [NSDate date];
//    NSLog(@"开始解析数据了，开始时间：%@，数据条数：%ld", beginTime, (unsigned long)self.dataArray.count);
    
    
    for (NSInteger i = 0; i < self.dataArray.count; ++i) {
        @autoreleasepool {
            EquipmentResultModel *model = [[EquipmentResultModel alloc]init];
            EquipmentModel *eqModel = [self.dataArray objectAtIndex:i];
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
    
//    NSDate *endTime = [NSDate date];
//    NSTimeInterval costTime = [endTime timeIntervalSinceDate:beginTime];
//    NSLog(@"解析结束，结束时间：%@，耗时：%.4f 秒", endTime, costTime);
    
}
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;;
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
        _searchBar.placeholder = @"设备类型";
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
- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    _searchStr = textField.text;
//    [self searchResultWithKeyStr:_searchStr];
//    self.collectionView.userInteractionEnabled = YES;
    
    
}
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    return YES;
//}
- (void)textFieldDidChange:(UITextField *)textField{
    if (textField.markedTextRange == nil) {
        _searchStr = textField.text;
//        NSLog(@"text:%@", textField.text);
        [self searchResultWithKeyStr:textField.text];

    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
- (void)searchResultWithKeyStr:(NSString *)keyStr
{
//    NSDate *beginTime = [NSDate date];
//    NSLog(@"开始匹配，开始时间：%@", beginTime);
    
    NSMutableArray *resultDataSource = [NSMutableArray array];
    for (int i =0 ; i < self.personModels.count; i++) {
        WPFPerson *person = [self.personModels objectAtIndex:i];
        EquipmentResultModel *model = [self.eqModels objectAtIndex:i];
        WPFSearchResultModel *resultModel = [WPFPinYinTools searchEffectiveResultWithSearchString:keyStr Person:person];
        
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
    
//    NSDate *endTime = [NSDate date];
//    NSTimeInterval costTime = [endTime timeIntervalSinceDate:beginTime];
//    NSLog(@"匹配结束，结束时间：%@，耗时：%.4f", endTime, costTime);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}
- (EquipmentViewModel *)equimentViewModel
{
    if (_equimentViewModel == nil) {
        _equimentViewModel = [[EquipmentViewModel alloc]init];
    }
    return _equimentViewModel;
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
