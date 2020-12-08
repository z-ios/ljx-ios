//
//  DeviceTypeCell.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/2.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "DeviceTypeCell.h"

@implementation DeviceTypeCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self creatUI];
    }
    return self;
}
- (void)creatUI
{
    self.imageV = [[UIButton alloc]initWithFrame:CGRectMake(self.width / 2 - (self.height- 30 * HeightScale) / 2, 0, self.height- 30 * HeightScale, self.height-30 * HeightScale)];
    _imageV.userInteractionEnabled = NO;
    [self.contentView addSubview:_imageV];
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageV.bottom, self.width, 30 * HeightScale)];
    _titleLab.textColor = ColorString(@"#121212");
    _titleLab.font = PingFangSCRegular(14);
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.userInteractionEnabled = NO;
    [self addSubview:_titleLab];
    
    
}
@end
