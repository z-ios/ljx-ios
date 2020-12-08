//
//  LDateView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/16.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "LDateView.h"
#import "CGCalendar.h"
#import "CGDateHeaderView.h"
#import "CGRangeDatePresenter.h"

@interface LDateView ()
//选择的开始日期
@property (nonatomic, strong) NSString * startDay;
//选择的结束日期
@property (nonatomic, strong) NSString * endDay;
@property (nonatomic, strong) CGCalendarView        *calendarView;
@property (nonatomic, strong) CGRangeDatePresenter  *rangePresenter;
@property (nonatomic, strong) NSDate *rangeModeSelectedStartDate;
@property (nonatomic, strong) NSDate *rangeModeSelectedEndDate;
@end

@implementation LDateView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self borderRoundCornerRadius:8];
        [self addSubview:self.calendarView];
        [self createUI];
        
    }
    return self;
}
- (void)createUI
{
    
    
    
    CGFloat  buttonHeight = 52 * HeightScale;
    UIView *downLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 0.5 -  buttonHeight , self.width, 0.5)];
    downLine.backgroundColor = [UIColor colorWithWhite:0 alpha:0.17];
    
    [self addSubview:downLine];
    UIButton *_cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(20 * WidthScale, downLine.bottom, (self.width - 40 * WidthScale) /2, buttonHeight)];
    _cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:ColorString(@"#868686") forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelAction ) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelButton];
    UIView *ceLine = [[UIView alloc]initWithFrame:CGRectMake(_cancelButton.right, downLine.bottom, 0.5, 63 * HeightScale)];
    ceLine.backgroundColor = [UIColor colorWithWhite:0 alpha:0.17];
    [self addSubview:ceLine];
    UIButton *_confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ceLine.right, downLine.bottom,(self.width - 40 * WidthScale) /2, buttonHeight)];
    _confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [_confirmButton setTitleColor:DefaColor forState:UIControlStateNormal];
    [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmButton addTarget:self action:@selector(queBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_confirmButton];
    
}
#pragma mark -- 取消
- (void)cancelAction
{
    self.cancleBack();
}
#pragma mark -- 确定
- (void)queBtnAction
{

    self.setTimeBack([self.rangePresenter.startDate WT_YYYYMMdd__], [self.rangePresenter.endDate WT_YYYYMMdd__]);
}
- (CGCalendarView *)calendarView {
    if (!_calendarView) {
        _calendarView = [[CGCalendarView alloc] initWithFrame:CGRectMake(0, 20, KScreenWidth - 30 * WidthScale, (450 - 52 - 60) * HeightScale)];
        [_calendarView registerSectionHeader:[CGDateHeaderView class] withReuseIdentifier:@"sectionHeader"];
        _calendarView.contentInsets = UIEdgeInsetsMake(0, 14, 0, 14);
        _calendarView.sectionHeaderHeight = 50 * HeightScale;
        _calendarView.weekViewHeight = 40  * HeightScale;
        [self registerCalanederViewCells];
        [self updateSelectionModeUI];
        [self setUpData];
        
    }
    return _calendarView;
}
- (void) setUpData
{
    self.calendarView.defaultEffectScrollDate = nil;
    
    self.rangePresenter.startDate = self.rangeModeSelectedStartDate;
    self.rangePresenter.endDate = self.rangeModeSelectedEndDate;
    [self.rangePresenter updateSelectRangeDateStatus];
    self.calendarView.defaultEffectScrollDate = self.rangeModeSelectedStartDate ? self.rangeModeSelectedStartDate : self.rangeModeSelectedEndDate;
    NSDate *zeroDate = [NSDate zeroDateFormDate:[self defaultStartDate]];
    self.calendarView.firstDate = zeroDate;
    NSDate *zeroDate1 = [NSDate zeroDateFormDate:[self defaultEndDate]];
    self.calendarView.lastDate = zeroDate1;

    [self updateDateTitleWithSelectDate];
    [self.calendarView reloadData];
    [self.calendarView scrollToSlectedMonthOrCurrentMonthSectionWithAnimated:NO];
    
}

- (void)updateSelectionModeUI
{
    
    self.calendarView.frame = CGRectMake(0, 10 * HeightScale, KScreenWidth - 30 * WidthScale,CGRectGetHeight(self.frame) - 52 * HeightScale - 20 * HeightScale);
    
}

- (void)registerCalanederViewCells {
    __weak typeof(self) weakSelf = self;
    
    self.rangePresenter.calendarView = self.calendarView;
    self.rangePresenter.selectDateHandle = ^(NSDate *statDate, NSDate *endDate) {
        [weakSelf updateDateTitleWithSelectDate];
    };
    
}
- (void)updateDateTitleWithSelectDate
{
    

}


- (CGRangeDatePresenter *)rangePresenter {
    if (!_rangePresenter) {
        _rangePresenter = [[CGRangeDatePresenter alloc] init];
    }
    return _rangePresenter;
}
#pragma mark - Private

- (NSDate *)defaultStartDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter dateFromString:@"2019-01-01"];
}

- (NSDate *)defaultEndDate {
    return [NSDate date];
}
@end
