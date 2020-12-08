//
//  AddressPickerView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/16.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "AddressPickerView.h"
#import "BTAreaPickViewModel.h"
#import "BTCoverVerticalTransition.h"
@interface AddressPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, assign) NSInteger provinceIndex,citieIndex,areaIndex,streetIndex;
@property (nonatomic, strong) BTCoverVerticalTransition *aniamtion;
@end

@implementation AddressPickerView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:UIColor.whiteColor];
        [self addSubview:self.pickerView];
    }
    return self;
}
#pragma mark 滚动到对应的下标
-(void)scrollToRow:(NSInteger)firstRank  secondRand:(NSInteger)secondRand thirdRand:(NSInteger)thirdRand forRand:(NSInteger)forRand{
    
    [self.pickerView reloadComponent:1];
    [self.pickerView reloadComponent:2];
    [self.pickerView reloadComponent:3];
    [self.pickerView reloadComponent:4];

    [self.pickerView selectRow:firstRank inComponent:0 animated:YES];   //滚动到第一,二,三列的下标
    [self.pickerView selectRow:secondRand inComponent:1 animated:YES];
    [self.pickerView selectRow:thirdRand inComponent:2 animated:YES];
    [self.pickerView selectRow:forRand inComponent:3 animated:YES];

    self.provinceIndex = firstRank;
    self.citieIndex = secondRand;
    self.areaIndex = thirdRand;
    self.streetIndex = forRand;
    if ([self.delegate respondsToSelector:@selector(areaPickerView:didSelectAreaModel:)]) {
        self.model.selectedProvince = self.model.provinces[self.provinceIndex];
        self.model.selectedCitie = self.model.provinces[self.provinceIndex].children[self.citieIndex];
        self.model.selectedArea = self.model.provinces[self.provinceIndex].children[self.citieIndex].children[self.areaIndex];
        self.model.selectedStreet = self.model.provinces[self.provinceIndex].children[self.citieIndex].children[self.areaIndex].children[self.streetIndex];

        [self.delegate areaPickerView:self didSelectAreaModel:self.model];
    }
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
            NSArray<BTCities*> *arr = self.model.provinces[self.provinceIndex].children;
            NSArray *arr1 = arr[self.citieIndex].children;
            return arr1.count;
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
        pickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 * WidthScale, 0, (self.width - 40 * WidthScale) / 4, 40)];
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
        self.model.selectedProvince = self.model.provinces[self.provinceIndex];
        NSArray *citys = self.model.provinces[self.provinceIndex].children;
        if (citys.count > self.citieIndex) {
            self.model.selectedCitie = self.model.provinces[self.provinceIndex].children[self.citieIndex];
        }
        NSArray *areas = self.model.provinces[self.provinceIndex].children[self.citieIndex].children;
        if (areas.count > self.areaIndex) {
            
            self.model.selectedArea = areas[self.areaIndex];
        }
        NSArray *street = self.model.provinces[self.provinceIndex].children[self.citieIndex].children[self.areaIndex].children;
        if (street.count > self.streetIndex) {
            
            self.model.selectedStreet = street[self.streetIndex];
        }
        
        [self.delegate areaPickerView:self didSelectAreaModel:self.model];
    }
}
#pragma mark - lazy

- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];

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
@end
