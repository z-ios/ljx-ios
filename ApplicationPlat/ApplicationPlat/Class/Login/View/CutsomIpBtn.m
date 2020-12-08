//
//  CutsomIpBtn.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/8/27.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "CutsomIpBtn.h"

@implementation CutsomIpBtn

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
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(12 * WidthScale, self.height / 2 - 25 * WidthScale / 2, 25 * WidthScale, 25 * WidthScale)];
    self.imageV.userInteractionEnabled = NO;
    [self addSubview:_imageV];
    
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(_imageV.right + 12 * WidthScale, self.height / 2 - 25 * WidthScale / 2, self.width - (_imageV.right + 12 * WidthScale) * 2, 25 * WidthScale)];
    self.titleLab.font = PingFangSCRegular(16);
    _titleLab.textColor = ColorString(@"#757575");
    _titleLab.userInteractionEnabled = NO;
    _titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLab];
    
    
}

@end
