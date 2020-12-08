//
//  SignalView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/23.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "SignalView.h"

@interface SignalView ()
@property(nonatomic, copy)NSString *typeStr;
@end

@implementation SignalView
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
    self.imageBtn = [[UIButton alloc]initWithFrame:CGRectMake(13 * WidthScale, 13 * HeightScale, 30 * WidthScale, 30 * WidthScale)];
    [self addSubview:_imageBtn];
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(13 * WidthScale, _imageBtn.bottom + 10 * HeightScale, self.width - 26 * WidthScale, 25 * HeightScale)];
    _titleLab.textColor = ColorString(@"#1E2933");
    _titleLab.font = PingFangSCMedium(17);
    [self addSubview:_titleLab];
    self.detialLab = [[UILabel alloc]initWithFrame:CGRectMake(13 * WidthScale, _titleLab.bottom + 5 * HeightScale, self.width - 26 * WidthScale, 20 * HeightScale)];
    _detialLab.font = PingFangSCRegular(13);
    _detialLab.textColor = ColorString(@"#798794");
    [self addSubview:_detialLab];
    
    
    self.unitLab = [[UILabel alloc]initWithFrame:CGRectMake(self.width - 63.0f * WidthScale, 20 * HeightScale,50.0f * WidthScale, 24 * HeightScale) ];
    _unitLab.textAlignment = NSTextAlignmentRight;
    _unitLab.font = [UIFont systemFontOfSize:14];
    _unitLab.textColor = ColorString(@"#798794");
    _unitLab.centerY = _imageBtn.centerY;
    [self addSubview:self.unitLab];
    
    
    
}

@end
