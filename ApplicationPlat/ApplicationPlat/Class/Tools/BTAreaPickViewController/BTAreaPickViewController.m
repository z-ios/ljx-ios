//
//  BTAreaPickViewController.m
//  BTAreaPickViewController
//
//  Created by leishen on 2019/11/23.
//  Copyright © 2019 leishen. All rights reserved.
//

#import "BTAreaPickViewController.h"
#import "BTAreaPickViewModel.h"
#import "BTCoverVerticalTransition.h"
/// RGB颜色(16进制)
#define RGB_HEX(rgbValue, a) \
[UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((CGFloat)(rgbValue & 0xFF)) / 255.0 alpha:(a)]
@interface BTAreaPickViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, assign) NSInteger provinceIndex,citieIndex,areaIndex,streetIndex;
@property (nonatomic, strong) BTCoverVerticalTransition *aniamtion;

@end

@implementation BTAreaPickViewController

- (instancetype)initWithDragDismissEnabal:(BOOL)enabel{
    self = [super init];
    if (self) {
        _aniamtion = [[BTCoverVerticalTransition alloc]initPresentViewController:self withDragDismissEnabal:enabel];
        self.transitioningDelegate = _aniamtion;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.whiteColor];
    [self.view addSubview:self.pickerView];
    // 添加顶部标题栏
     [self.view addSubview:self.topView];
     // 添加左边取消按钮
     [self.topView addSubview:self.leftBtn];
     // 添加右边确定按钮
     [self.topView addSubview:self.rightBtn];
     // 添加中间标题按钮
     [self.topView addSubview:self.titleLabel];
     // 添加分割线
     [self.topView addSubview:self.lineView];
    [self updatePreferredContentSizeWithTraitCollection:self.traitCollection];
    [self.toolBar setBackgroundColor:UIColor.whiteColor];
    [self.toolBar setBarTintColor:UIColor.whiteColor];
}

- (void)setHiddenToolbar:(BOOL)hiddenToolbar{
    _hiddenToolbar = hiddenToolbar;
    self.toolBar.hidden = YES;
    [self.view layoutIfNeeded];
}

- (void)updatePreferredContentSizeWithTraitCollection:(UITraitCollection *)traitCollection {
    // 适配屏幕，横竖屏
    if (CGSizeEqualToSize(CGSizeZero, self.preferredContentSize)) {
        self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact ? 220 : 350);
    }
}

/// 屏幕旋转时调用的方法
/// @param newCollection 新的方向
/// @param coordinator 动画协调器
- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    [self updatePreferredContentSizeWithTraitCollection:newCollection];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
//    self.toolBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), self.hiddenToolbar?0:40);
//    self.lineView.y = self.toolBar.bottom;
//    self.pickerView.frame = CGRectMake(0, self.lineView.bottom, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-CGRectGetHeight(self.lineView.bounds));
    self.pickerView.frame = CGRectMake(0, self.topView.bottom, CGRectGetWidth(self.view.bounds), 250);

}

- (void)setSelectedModelWithProvinceIndex:(NSInteger)provinceIndex
                           withCitieIndex:(NSInteger)citieIndex
                            withAreaIndex:(NSInteger)areaIndex
                             withStreetIndex:(NSInteger)streetIndex{
    self.model.selectedProvince = self.model.provinces[provinceIndex];
    if (citieIndex>self.model.selectedProvince.children.count) {
        citieIndex = [self.pickerView selectedRowInComponent:1];
    }
    self.model.selectedCitie = self.model.selectedProvince.children[citieIndex];
    if (areaIndex>self.model.selectedCitie.children.count) {
        areaIndex = [self.pickerView selectedRowInComponent:2];
    }
    self.model.selectedArea = self.model.selectedCitie.children[areaIndex];
    
    if (streetIndex>self.model.selectedArea.children.count) {
        streetIndex = [self.pickerView selectedRowInComponent:3];
    }
    self.model.selectedStreet = self.model.selectedArea.children[streetIndex];
    
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 4;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0: {
            return self.model.provinces.count;
        };
        case 1: {
            return self.model.provinces[self.provinceIndex].children.count;
        }
        case 2: {
            return self.model.provinces[self.provinceIndex].children[self.citieIndex].children.count;
        };
        case 3: {
            return self.model.provinces[self.provinceIndex].children[self.citieIndex].children[self.areaIndex].children.count;
        };
        default: {
            return 0;
        }
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0: {
            self.model.selectedProvince = self.model.provinces[row];
            return self.model.selectedProvince.name;
        }
        case 1: {
            self.model.selectedCitie = self.model.provinces[self.provinceIndex].children[row];
            return self.model.selectedCitie.name;
        }
        case 2: {
            self.model.selectedArea = self.model.provinces[self.provinceIndex].children[self.citieIndex].children[row];
            return self.model.selectedArea.name;
        }
        case 3: {
            self.model.selectedStreet = self.model.provinces[self.provinceIndex].children[self.citieIndex].children[self.areaIndex].children[row];
            return self.model.selectedStreet.name;
        }
        default: {
            return nil;
        }
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
        }
    }
    //可以通过自定义label达到自定义pickerview展示数据的方式
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (KScreenWidth - 30) / 4, 40)];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor whiteColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:15]];
        [pickerLabel setTextColor:[UIColor blackColor]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];//调用上一个委托方法，获得要展示的title
    return pickerLabel;
}
#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
        case 0:{
            self.provinceIndex = row;
            self.citieIndex = 0;
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            [pickerView reloadComponent:3];

            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            [pickerView selectRow:0 inComponent:3 animated:YES];

            break;
        }
        case 1:{
            self.citieIndex = row;
            self.areaIndex = 0;
            [pickerView reloadComponent:2];
            [pickerView reloadComponent:3];

            [pickerView selectRow:0 inComponent:2 animated:YES];
            [pickerView selectRow:0 inComponent:3 animated:YES];

            break;
        }
        case 2:{
            self.areaIndex = row;
            self.streetIndex = 0;
            [pickerView reloadComponent:3];
            [pickerView selectRow:0 inComponent:3 animated:YES];
            break;
        }
        case 3:{
            self.streetIndex = row;
            break;
        }
        default:
            break;
    }
    if ([self.delegate respondsToSelector:@selector(areaPickerView:didSelectAreaModel:)]) {
        [self.delegate areaPickerView:self didSelectAreaModel:self.model];
    }
}

- (void)cancelAction:(UIBarButtonItem*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneAction:(UIBarButtonItem*)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(areaPickerView:doneAreaModel:)]) {
            self.model.selectedProvince = self.model.provinces[self.provinceIndex];
            self.model.selectedCitie = self.model.provinces[self.provinceIndex].children[self.citieIndex];
            self.model.selectedArea = self.model.provinces[self.provinceIndex].children[self.citieIndex].children[self.areaIndex];
            self.model.selectedStreet = self.model.provinces[self.provinceIndex].children[self.citieIndex].children[self.areaIndex].children[self.streetIndex];

            [self.delegate areaPickerView:self doneAreaModel:self.model];
        }
    }];
}

#pragma mark - lazy

- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    return _pickerView;
}

- (BTAreaPickViewModel *)model{
    if (!_model) {
        _model = [[BTAreaPickViewModel alloc]init];
    }
    return _model;
}

- (UIToolbar *)toolBar{
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc]init];
        _toolBar.barTintColor = [UIColor yellowColor];
        UIButton *_leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(5, 7, 60, 50);
        
        [_leftBtn setTitleColor:DefaColor forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithCustomView:_leftBtn];
        
        
        UIButton *_rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(5, 7, 60, 50);
        [_rightBtn setTitleColor:DefaColor forState:UIControlStateNormal];
        
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]initWithCustomView:_rightBtn];;
        UIBarButtonItem *fixItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixItem.width = 20;
//        fixItem.customView = self.titleLabel;

        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        flexItem.customView = self.titleLabel;;
        _toolBar.items = @[cancelItem,flexItem,doneItem];
    }
    return _toolBar;
}
#pragma mark - 顶部标题栏视图
- (UIView *)topView {
    if (!_topView) {
        _topView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40 + 0.5)];
        _topView.backgroundColor = RGB_HEX(0xFDFDFD, 1.0f);
    }
    return _topView;
}

#pragma mark - 左边取消按钮
- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(5, 7, 60, 40-14);
        [_leftBtn setTitleColor:DefaColor forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

#pragma mark - 右边确定按钮
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(KScreenWidth - 65, 7, 60, 40-14);
        [_rightBtn setTitleColor:DefaColor forState:UIControlStateNormal];

        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
#pragma mark - 中间标题按钮
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(65, 0, KScreenWidth - 130, 40)];
//        _titleLabel.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:96 / 255.0 blue:134 / 255.0 alpha:1] ;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = DefaColor;
        _titleLabel.text = @"请选择安装地址";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

#pragma mark - 分割线
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, KScreenWidth, 0.5)];
        _lineView.backgroundColor  = [UIColor colorWithRed:225 / 255.0 green:225 / 255.0 blue:225 / 255.0 alpha:1] ;
    }
    return _lineView;
}
@end
