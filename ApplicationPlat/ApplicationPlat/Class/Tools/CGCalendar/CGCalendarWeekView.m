//
//  CGCalendarWeekView.m
//  CGCalendar
//
//  Created by Caoguo on 2018/3/8.
//  Copyright © 2018年 Namegold. All rights reserved.
//

#import "CGCalendarWeekView.h"
#import "NSDate+CGAddition.h"

@interface CGCalendarWeekView ()

@property (nonatomic, strong) NSMutableArray *adjustedSymbols;

@end


@implementation CGCalendarWeekView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor =  ColorString(@"#F2F2F7");
        [self borderRoundCornerRadius:20 * HeightScale];
        NSCalendar *calendar = [NSDate gregorianCalendar];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.calendar = calendar;
        NSArray *weekdaySymbols = nil;
        
        weekdaySymbols =  @[@"S",@"M",@"T",@"W",@"T",@"F",@"S"];
        
        NSMutableArray *adjustedSymbols = [NSMutableArray arrayWithArray:weekdaySymbols];
        //        for (NSInteger index = 0; index < (1 - calendar.firstWeekday + weekdaySymbols.count + 1); index++) {
        //            NSString *lastObject = [adjustedSymbols lastObject];
        //            [adjustedSymbols removeLastObject];
        //            [adjustedSymbols insertObject:lastObject atIndex:0];
        //        }
        
        self.adjustedSymbols = adjustedSymbols;
        
        for (int i = 0 ; i < self.adjustedSymbols.count; i++) {
            CGFloat w = (KScreenWidth - 50 * WidthScale)/7;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(w * i, 0, w, CGRectGetHeight(self.frame))];
            label.tag = 100 + i;
            label.textColor = (i == 0 || i == 6) ? ColorString(@"#FE4146") :
            ColorString(@"#2F2F2E");
            if (@available(iOS 8.2, *)) {
                label.font = [UIFont systemFontOfSize:12.f weight:UIFontWeightMedium];
            }
            label.text = [self.adjustedSymbols[i] uppercaseString];
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
            
        }
//        self.backgroundColor = [UIColor redColor];
        
        // bottom line is default style, you
//        if (!self.bottomLine) {
//            self.bottomLine = [CALayer layer];
//            self.bottomLine.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5);
//            self.bottomLine.backgroundColor = [UIColor colorWithRed:(102/255.f) green:(102/255.f) blue:(102/255.f) alpha:1].CGColor;
//            [self.layer addSublayer:self.bottomLine];
//        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (int i = 0; i < 7; i++) {
        UILabel *label = [self viewWithTag:100 + i];
        CGFloat width = ((KScreenWidth - 50 * WidthScale) - _contentInsets.left - _contentInsets.right) / 7;
        label.frame = CGRectMake(_contentInsets.left + i * width, 0, width, CGRectGetHeight(self.frame));
    }
    self.bottomLine.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5);
}

- (void)reloadWeekView {
    for (int i = 0; i < self.adjustedSymbols.count; i++) {
        UILabel *label = [self viewWithTag:100 + i];
        if (label && _delegate && [_delegate respondsToSelector:@selector(calendarWeekView:configureWeekDayLabel:atWeekDay:)]) {
            [_delegate calendarWeekView:self configureWeekDayLabel:label atWeekDay:i];
        }
    }
}

- (void)setDelegate:(id<CGCalendarWeekViewDelegate>)delegate {
    _delegate = delegate;
    [self reloadWeekView];
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets {
    _contentInsets = contentInsets;
    [self layoutSubviews];
}

@end
