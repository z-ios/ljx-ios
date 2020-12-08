//
//  BoardView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/23.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "BoardView.h"

@interface BoardView ()
@property(nonatomic, copy)NSString *typeStr;

@end

@implementation BoardView

- (instancetype)initWithFrame:(CGRect)frame typeStr:(NSString *)typeStr
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self borderRoundCornerRadius:12];
        [self createUIWithTypeStr: typeStr];
        _typeStr = typeStr;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 12.5;
        self.layer.shadowColor = [UIColor colorWithRed:37/255.0 green:51/255.0 blue:75/255.0 alpha:0.1].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,5);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 10;
    }
    return self;
}
- (void)createUIWithTypeStr:(NSString *)typeStr
{
    self.imageBtn = [[UIButton alloc]initWithFrame:CGRectMake(20 * WidthScale, 100 * HeightScale / 2 - 40 * WidthScale / 2, 40 * WidthScale, 40 * WidthScale)];
    [self addSubview:_imageBtn];
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(_imageBtn.right + 10 * WidthScale,45 * HeightScale / 2, self.width - 190 * WidthScale, 30 * HeightScale)];
    _titleLab.textColor = ColorString(@"#1E2933");
    
    _titleLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:24];
    [self addSubview:_titleLab];
    self.detialLab = [[UILabel alloc]initWithFrame:CGRectMake(_imageBtn.right +  10 * WidthScale, _titleLab.bottom + 5 * HeightScale, self.width - 170 * WidthScale, 20 * HeightScale)];
    _detialLab.font = [UIFont systemFontOfSize:13];
    _detialLab.textColor = ColorString(@"#798794");
    [self addSubview:_detialLab];
    
    self.circleIndicatorView = [[CircleIndicatorView alloc]initWithFrame:CGRectMake(_detialLab.right, 10 * HeightScale, ceil(95 * WidthScale),ceil(APH(85)) )];
    _circleIndicatorView.backgroundColor = [UIColor whiteColor];
    _circleIndicatorView.openAngle = 150;
    _circleIndicatorView.userInteractionEnabled = NO;
    _circleIndicatorView.maxValue = 100;
    _circleIndicatorView.minValue = 0;
    
    _circleIndicatorView.indicatorValue = 86;
    _circleIndicatorView.centerValue = 86;
    _circleIndicatorView.innerAnnulusValueToShowArray = @[];
    
    self.progress = [[SemiCircleWithTextProgressView alloc] initWithFrame:CGRectMake(_detialLab.right +15 * WidthScale , 40 * HeightScale, 70 * WidthScale, APH(50))];
    _progress.percent = 0.41;
    if ([typeStr isEqualToString:@"power"]) {
        
        [self addSubview:_circleIndicatorView];
    }else{
        
        [self addSubview:_progress];
    }
    
    
    
}
@end
