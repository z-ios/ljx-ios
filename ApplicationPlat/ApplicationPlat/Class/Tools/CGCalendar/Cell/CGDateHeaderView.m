//
//  CGSingleDateHeaderView.m
//  CGCalendar
//
//  Created by Caoguo on 2018/3/8.
//  Copyright © 2018年 Namegold. All rights reserved.
//

#import "CGDateHeaderView.h"
#import "CGCalendar.h"

@interface CGDateHeaderView ()

@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, assign) NSInteger weekday;

@end

@implementation CGDateHeaderView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.monthLabel];
    }
    return self;
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    self.monthLabel.frame = CGRectMake(0,18.5 , CGRectGetWidth(self.monthLabel.frame), 28);
//}

#pragma mark - setters
- (void)setFirstDateOfMonth:(NSDate *)firstDateOfMonth {
    _firstDateOfMonth = firstDateOfMonth;
    NSCalendar *calendar = [NSDate gregorianCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday fromDate:firstDateOfMonth];
    self.weekday = components.weekday;
    self.monthLabel.text = [NSString stringWithFormat:@"%ld月 %ld",(long)components.month ,(long)components.year];
//    [self.monthLabel sizeToFit];
//    [self layoutSubviews];
}


#pragma mark - Getter
- (UILabel *)monthLabel {
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc] initWithFrame:CGRectMake((KScreenWidth - 30 * WidthScale )/ 2 - 80 * WidthScale, 5 * HeightScale, 160 * WidthScale, 40 * HeightScale)];
        if (@available(iOS 8.2, *)) {
            _monthLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        }
        _monthLabel.textColor = ColorString(@"#3F3F3F");
        _monthLabel.textAlignment = NSTextAlignmentCenter;

    }
    return _monthLabel;
}

@end
