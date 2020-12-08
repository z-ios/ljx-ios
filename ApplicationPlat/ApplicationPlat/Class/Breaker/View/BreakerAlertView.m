//
//  BreakerAlertView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/16.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "BreakerAlertView.h"

@implementation BreakerAlertView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.layer.cornerRadius = 12;
        self.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,5);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 10;
        self.array = @[@"过压异常",@"开关状态异常",@"漏电异常",@"三相不平衡异常",@"进入维修模式（手动模式）"];
        [self createUI];
    }
    return self;
}
- (void)createUI
{
    UILabel  *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15 * WidthScale, 17 * HeightScale, 150, 35 * HeightScale)];
    titleLab.textColor = ColorString(@"#9A9CA9");
    titleLab.font = PingFangSCRegular(14);
    titleLab.text = @"告警信息";
    [self addSubview:titleLab];
    CGFloat height = 0;
    CGFloat wight = 0;
    
    for (int i = 0; i < self.array.count; i++) {
        NSString *string =  self.array[i];
        CGFloat w = [string widthWithFont:PingFangSCRegular(16) h:40 * HeightScale] + 40 * WidthScale;
        if (i != 0) {
            CGFloat weight1 = wight + w + 5 * WidthScale;
            if (weight1 > self.width - 30 * WidthScale) {
                wight = 0;
                height += 50 * HeightScale;
            }
        }
        
        UILabel *textLab  = [[UILabel alloc]initWithFrame:CGRectMake(15* WidthScale + wight,  titleLab.bottom+10 * HeightScale + height, w, 40 * HeightScale)];
        wight = textLab.right + 15 * WidthScale;
        textLab.textColor = ColorString([self checkAlertTitleWithStr:string]);
        textLab.text = string;
        textLab.font = PingFangSCRegular(16);
        textLab.backgroundColor = [UIColor colorWithHex:[self checkAlertTitleWithStr:string] alpha:0.13];
        [textLab borderRoundCornerRadius:20 * HeightScale];
        textLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:textLab];
        self.height = textLab.bottom + 20 * HeightScale;
    }
    
//    _updateAlertHeight(self.bottom);
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
