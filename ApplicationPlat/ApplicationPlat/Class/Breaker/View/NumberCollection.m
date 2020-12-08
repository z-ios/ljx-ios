//
//  NumberCollection.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/26.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "NumberCollection.h"

@implementation NumberCollection
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self borderRoundCornerRadius:4];
        [self createUI];
    }
    return self;;
}
- (void)createUI
{
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height)];
    _titleLab.textColor = ColorString(@"#121212");
    _titleLab.font = PingFangSCRegular(17);
    _titleLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLab];
}

@end
