//
//  LocLabView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/4.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "LocLabView.h"

@implementation LocLabView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI
{
   
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0,0, self.width, 24 * HeightScale)];
    _titleLab.textColor = ColorString(@"#808080");
    _titleLab.font = PingFangSCRegular(14);
    [self addSubview:_titleLab];
    
    self.detailLab = [[UILabel alloc]initWithFrame:CGRectMake(0,_titleLab.bottom +6 * HeightScale, self.width , 33 * HeightScale)];
    _detailLab.textColor = ColorString(@"#121212");
    _detailLab.font = PingFangSCRegular(16);
    [self addSubview:_detailLab];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _detailLab.bottom +6 * HeightScale, self.width, 1)];
    lineView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.19];
    [self addSubview:lineView];
    
   
}

@end
