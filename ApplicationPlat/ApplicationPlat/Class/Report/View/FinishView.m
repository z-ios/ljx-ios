//
//  FinishView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/5.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "FinishView.h"

@implementation FinishView

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
    self.imageBtn = [[UIButton alloc]initWithFrame:CGRectMake(20 * WidthScale,40 * HeightScale / 2 - 24 * WidthScale / 2, 24 * WidthScale, 24 * WidthScale)];
    _imageBtn.userInteractionEnabled = NO;
    [self addSubview:_imageBtn];
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(_imageBtn.right +15 * WidthScale,0, self.width - _imageBtn.right - 15 * WidthScale, self.height)];
    _titleLab.textColor = ColorString(@"#121212");
    _titleLab.font = PingFangSCRegular(16);
    _titleLab.numberOfLines = 0;
    [self addSubview:_titleLab];
   
}

@end
