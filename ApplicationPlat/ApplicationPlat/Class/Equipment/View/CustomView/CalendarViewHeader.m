//
//  CalendarViewHeader.m
//  Calendar
//
//  Created by beyondSoft on 16/6/22.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "CalendarViewHeader.h"

@implementation CalendarViewHeader

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];

}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, KScreenWidth - 30 * HeightScale, 20)];
        _title.font = [UIFont systemFontOfSize:12];
        _title.textColor = ColorString(@"#3F3F3F");
        _title.text = @"6月 2016";
        _title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_title];
//        [_title setTranslatesAutoresizingMaskIntoConstraints:NO];
        
    }
    return self;
}

@end
