//
//  AlertTypeView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/13.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "AlertTypeView.h"

@interface AlertTypeView ()
@property(nonatomic, strong)UIScrollView *scrollView;

@end

@implementation AlertTypeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self borderRoundCornerRadius:18];
        self.array = @[@"过压异常",@"开关状态异常",@"漏电异常",@"三相不平衡异常",@"进入维修模式（手动模式）"];
        [self createUI];
        
        
        
    }
    return self;
}
- (void)createUI
{
    UILabel  *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(25 * WidthScale, 25 * HeightScale, 150, 35 * HeightScale)];
    titleLab.textColor = ColorString(@"#121212");
    titleLab.font = PingFangSCRegular(19);
    titleLab.text = @"当前告警状态";
    titleLab.width = [titleLab.text widthWithFont:PingFangSCRegular(19) h:35 * HeightScale];
    [self addSubview:titleLab];
   
    
    
    UILabel *textLab  = [[UILabel alloc]initWithFrame:CGRectMake(titleLab.right +15 * WidthScale,  30 * HeightScale, 170, 25 * HeightScale)];
    textLab.textColor = ColorString(@"#1D68F2");
    textLab.text = [NSString stringWithFormat:@"%ld", self.array.count];
    textLab.font = PingFangSCMedium(14);
    textLab.backgroundColor = [UIColor colorWithHex:@"#1D68F2" alpha:0.13];
    textLab.textAlignment = NSTextAlignmentCenter;
    [textLab borderRoundCornerRadius:25 * HeightScale/2];
    textLab.width = [textLab.text widthWithFont:PingFangSCMedium(14) h:25 * HeightScale] + 20 * WidthScale;

    [self addSubview:textLab];
    
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(25 * WidthScale, textLab.bottom + 10 * HeightScale, self.width - 50 * WidthScale, self.height - 61 * HeightScale - textLab.bottom - 20 * HeightScale)];
    [self addSubview:_scrollView];
    
    CGFloat height = 0;
    CGFloat wight = 0;

    for (int i = 0; i < self.array.count; i++) {
        NSString *string =  self.array[i];
        CGFloat w = [string widthWithFont:PingFangSCRegular(16) h:40 * HeightScale] + 40 * WidthScale;
        if (i != 0) {
//            NSString *string1 =  self.array[i - 1];
//            CGFloat w1 = [string1 widthWithFont:PingFangSCRegular(16) h:40 * HeightScale] + 40 * WidthScale;
            CGFloat weight1 = wight + w + 15 * WidthScale;
            if (weight1 > self.width - 50 * WidthScale) {
                wight = 0;
                height += 50 * HeightScale;
            }
        }
        
        UILabel *textLab  = [[UILabel alloc]initWithFrame:CGRectMake(wight,  10 * HeightScale + height, w, 40 * HeightScale)];
        wight = textLab.right + 15 * WidthScale;
        textLab.textColor = ColorString([self checkAlertTitleWithStr:string]);
        textLab.text = string;
        textLab.font = PingFangSCRegular(16);
        textLab.backgroundColor = [UIColor colorWithHex:[self checkAlertTitleWithStr:string] alpha:0.13];
        [textLab borderRoundCornerRadius:20 * HeightScale];
        textLab.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:textLab];
        _scrollView.contentSize = CGSizeMake(self.width - 50 * WidthScale, textLab.bottom);
    }
   
    
    
    
    UIView *downLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 61* HeightScale, self.width, 1)];
    downLine.backgroundColor = ColorString(@"#E7E7E7");
    [self addSubview:downLine];
    
    UIButton *queBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width / 2 -(self.width - 40 * WidthScale) /4 , self.height - 60* HeightScale,(self.width - 40 * WidthScale) /2, 60 * HeightScale)];
    queBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [queBtn setTitle:@"知道了" forState:UIControlStateNormal];
    [queBtn setTitleColor:DefaColor forState:UIControlStateNormal];
    [queBtn addTarget:self action:@selector(comBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:queBtn];
}
- (void)comBtnAction
{
    self.determineBlock();
    
}
- (NSString *)checkAlertTitleWithStr:(NSString *)str
{
    
    NSArray *array = @[@"过压异常",@"欠压异常",@"过流异常",@"开关状态异常",@"漏电异常",@"短路异常",@"温度异常",@"线路电弧异常",@"过载异常",@"最小功率异常",@"漏电功能已坏",@"进入维修模式（手动模式）",@"断零异常",@"三相不平衡异常",@"缺相异常"];

    NSArray *clorArray = @[@"#FA6400",@"#F63B79",@"#FBA44C",@"#0091FF",@"#FE4F4C",@"#7C8186",@"#6ED667",@"#45CAEA",@"#E14EEB",@"#3F64E9",@"#358D33",@"#3BC4A6",@"#E94327",@"#A35CF3",@"#1C76E9"];
    
    for (int i = 0; i < array.count; i ++) {
        NSString *title = array[i];
        if ([title isEqualToString:str]) {
            return clorArray[i];
        }
    }
    
    return @"";
    
}
@end
