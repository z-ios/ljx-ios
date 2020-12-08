//
//  PageItem1.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/30.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "PageItem1.h"

@implementation PageItem1

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
//        UILabel *detialLab = [UILabel z_labelWithText:@"暂未开放..." fontSize:12 color:DefaColor CornerRadius:APH(35) / 2  backgroundColor:[UIColor clearColor]];
//        detialLab.frame = CGRectMake(100, (KScreenHeight - Height_NavBar -40) / 2-  APH(35), 200 * WidthScale, APH(35));
//        detialLab.textAlignment = NSTextAlignmentCenter;
//        detialLab.centerX = self.centerX;
//        detialLab.font = PingFangSCRegular(17);
//        [self addSubview:detialLab];
    }
    return self;
}

@end
