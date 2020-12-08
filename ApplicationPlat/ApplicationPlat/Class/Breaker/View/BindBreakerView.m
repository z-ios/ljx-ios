//
//  BindBreakerView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/13.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "BindBreakerView.h"
#import "CustomTextField.h"
#import "CGXStringPickerView.h"
#import "BranchbreakViewModel.h"
#import "UIView+TYAlertView.h"
#import "BreakerNumberController.h"
@interface BindBreakerView ()<UITextFieldDelegate>

@property(nonatomic, strong) BranchbreakViewModel *branchViewModel;

@end

@implementation BindBreakerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self borderRoundCornerRadius:18];
        [self createUI1];
        
        
        
    }
    return self;
}
- (void)createUI1
{
    
    
    
    UILabel  *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(25 * WidthScale, 25 * HeightScale, self.width - 80 * WidthScale, 35 * HeightScale)];
    titleLab.textColor = ColorString(@"#121212");
    titleLab.font = PingFangSCRegular(19);
    titleLab.text = @"输入mac地址绑定子开关";
    [self addSubview:titleLab];
    
    
    UIButton *cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width-54 * WidthScale,25 * HeightScale, 34 * WidthScale, 34 * WidthScale)];
    [cancleBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleAction ) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleBtn];
    
    
    UILabel *textLab  = [[UILabel alloc]initWithFrame:CGRectMake(25 * WidthScale,  titleLab.bottom+5 * HeightScale, 170, 25 * HeightScale)];
    textLab.textColor = ColorString(@"#8F9FB3");
    textLab.text = @"请选择设备工作模式";
    textLab.font = PingFangSCRegular(14);
    [self addSubview:textLab];
    UILabel *subtitleLab = [[UILabel alloc]initWithFrame:CGRectMake(25 * WidthScale,textLab.bottom + 20 * HeightScale, 170, 33 * HeightScale)];
    subtitleLab.text = @"子开关MAC地址";
    subtitleLab.textColor = ColorString(@"#808080");
    subtitleLab.font = PingFangSCRegular(14);
    [self addSubview:subtitleLab];
    
    self.customText = [[CustomTextField alloc]initWithFrame:CGRectMake(25 * WidthScale,subtitleLab.bottom + 3 * HeightScale, self.width - 50 * WidthScale, 48 * HeightScale) isLine:YES];
    _customText.textField.font = PingFangSCRegular(16);
    _customText.textField.delegate = self;
    _customText.textField.textColor = ColorString(@"#121212");
    [_customText.functionBtn setImage:[UIImage imageNamed:@"icon_code"] forState:UIControlStateNormal];
    [_customText.functionBtn addTarget:self action:@selector(scanAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_customText];
//    _customText.textField.text = @"6045239085";
    
    
    UILabel *subtitleLab1 = [[UILabel alloc]initWithFrame:CGRectMake(25 * WidthScale,_customText.bottom + 20 * HeightScale, 80, 33 * HeightScale)];
    subtitleLab1.text = @"485地址";
    subtitleLab1.textColor = ColorString(@"#808080");
    subtitleLab1.font = PingFangSCRegular(14);
    [self addSubview:subtitleLab1];
    
    self.numText = [[CustomTextField alloc]initWithFrame:CGRectMake(25 * WidthScale,subtitleLab1.bottom + 3 * HeightScale, self.width - 50 * WidthScale, 48 * HeightScale) isLine:NO];
    _numText.textField.font = PingFangSCRegular(16);
    _numText.textField.textColor = ColorString(@"#121212");
    [_numText.functionBtn setImage:[UIImage imageNamed:@"icon_arrow_more"] forState:UIControlStateNormal];
    [_numText.functionBtn addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    _numText.textField.delegate = self;
    [self addSubview:_numText];
    
    UIButton *queBtn = [[UIButton alloc]initWithFrame:CGRectMake(24 * WidthScale, self.height - 70* HeightScale,self.width - 50 * WidthScale, 52 * HeightScale)];
    queBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [queBtn setTitle:@"绑定" forState:UIControlStateNormal];
    queBtn.backgroundColor = DefaColor;
    [queBtn borderRoundCornerRadius:6];
    [queBtn addTarget:self action:@selector(comBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:queBtn];
    
    
}
- (void)scanAction
{
    self.scanCodeVc();
    
}
- (void)moreAction
{
//    CZHWeakSelf(self)
    
//    [CGXStringPickerView showStringPickerWithTitle:@"485地址" DataSource:@[@"1",@"2",@"3",@"4",@"5",@"6"] DefaultSelValue:@"1" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
//        weakself.numText.textField.text = [NSString stringWithFormat:@"%@", selectValue];
//    }];
    

    self.dropCodeVc(_numText.textField.text);

}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _customText.textField) {
        return YES;
    }
    if (textField == _numText.textField) {
        
        [self moreAction];
        return NO;
    }
    return NO;

}
- (void)cancleAction
{
    self.determineBlock();
    
}
- (void)setIId:(NSString *)iId
{
    _iId = iId;
    
}
- (void)comBtnAction
{
    if ([_customText.textField.text isEqualToString:@""]) {
        self.comBtnActionBlock(@"子开关MAC地址没有填写",NO);
        return;
    }
    if ([_numText.textField.text isEqualToString:@""]) {
        self.comBtnActionBlock(@"485地址没有填写",NO);
        return;
    }
    NSString *strUrl = [_customText.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSDictionary *device = @{@"id":_iId?_iId:@""};
    NSDictionary *operator = @{@"id":Center.shared.userID};
    NSDictionary *payload = @{@"branchBreaker_mac":strUrl,@"branchBreaker_485":_numText.textField.text};
    params[@"device"] = device;
    params[@"operator"] = operator;
    params[@"payload"] = payload;
    [self.branchViewModel bindBreakerWithParams:params Completion:^(BOOL success, NSString * _Nonnull errorMsg) {
        
        if (success) {
            self.comBtnActionBlock(@"",success);
        }else{
            self.comBtnActionBlock(errorMsg,success);

        }
    }];
}
- (BranchbreakViewModel *)branchViewModel
{
    if (_branchViewModel == nil) {
        _branchViewModel = [[BranchbreakViewModel alloc]init];
    }
    return _branchViewModel;
}
@end
