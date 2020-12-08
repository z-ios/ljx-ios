//
//  CustomDateView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/11.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "CustomDateView.h"
#import "CollectionViewCell.h"
#import "CalendarViewHeader.h"
#import "FlowLayout.h"

static NSString * const reuseCell = @"reuseCell";
static NSString * const reuseHeaderCell = @"reuseCell";

static const NSCalendarUnit kCalendarUnitYMD = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
#define screenWidth [UIScreen mainScreen].bounds.size.width
@interface  CustomDateView()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic)  UICollectionView *collectionView;

@property (nonatomic, strong) NSCalendar * calendar;

@property (nonatomic) NSDate *firstDateMonth;

@property (nonatomic) NSDate *lastDateMonth;

@property (nonatomic, assign) NSUInteger daysPerWeek;

@property (nonatomic, strong) NSDateFormatter *headerDateFormatter;

@property (nonatomic, strong) NSDate *firstDate;

@property (nonatomic, strong) NSDate *lastDate;

@property (nonatomic, strong) NSIndexPath * startIndexPath;

@property (nonatomic, strong) NSIndexPath * endIndexPath;

@property (nonatomic, strong) NSDateFormatter * headerDate;
//选择的开始日期
@property (nonatomic, strong) NSString * startDay;
//选择的结束日期
@property (nonatomic, strong) NSString * endDay;
@end


@implementation CustomDateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self borderRoundCornerRadius:8];
        [self createUI];
        
    }
    return self;
}
- (void)createUI
{
    
    
    _daysPerWeek = 7;
    _endIndexPath = nil;
    _startIndexPath = nil;
    FlowLayout * flowLayout = [FlowLayout new];
    NSArray *weekArray = @[@"S",@"M",@"T",@"W",@"T",@"F",@"S"];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10 * WidthScale, 10 * HeightScale, KScreenWidth - 50 * WidthScale, 40  * HeightScale)];
    [bgView borderRoundCornerRadius:20 * HeightScale];
    bgView.backgroundColor = ColorString(@"#F2F2F7");
    [self addSubview:bgView];
    for (int i = 0; i < 7; i++) {
        
        UILabel *macLab = [UILabel labelWithframe:CGRectMake(i * (KScreenWidth - 50 * WidthScale) / 7, 0 , (KScreenWidth - 30 * WidthScale) / 7, 40 * WidthScale) title:weekArray[i] font:[UIFont italicSystemFontOfSize:38] color:ColorString(@"#2F2F2E") line:0];
        macLab.font = [UIFont systemFontOfSize:12];
        macLab.textAlignment = NSTextAlignmentCenter;
        if (i == 0 || i == 6) {
            
            macLab.textColor = ColorString(@"#FE4146");
        }
        
        [bgView addSubview:macLab];
    }
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 50 * HeightScale, KScreenWidth- 30 * WidthScale, (450 - 52 - 60) * HeightScale) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //先注册cell和headerView再注册collectionView否则collectionView的内容无显示
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseCell];
    [self.collectionView registerClass:[CalendarViewHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderCell];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseCell];
    [self addSubview:_collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //    [NSDate date]
    
    NSDate *today = [NSDate date]; //Get a date object for today's date
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSCalendarUnitDay
                           inUnit:NSCalendarUnitMonth
                          forDate:today];
    NSInteger a =  ([NSDate date].year - 2019) * 12 +([NSDate date].month - 7);
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:days.length inSection:a] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
 
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
    self.setTimeBack(_startDay, _endDay);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.calendar components:NSCalendarUnitMonth fromDate:self.firstDateMonth toDate:self.lastDateMonth options:0].month + 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSDate *firstOfMonth = [self firstOfMonthForSection:section];
    NSCalendarUnit weekCalendarUnit = [self weekCalendarUnitDependingOniOSVersion];
    NSRange rangeOfWeeks = [self.calendar rangeOfUnit:weekCalendarUnit inUnit:NSCalendarUnitMonth forDate:firstOfMonth];
    //We need the number of calendar weeks for the full months (it will maybe include previous month and next months cells)
    return (rangeOfWeeks.length * self.daysPerWeek);
}
#pragma mark - UICollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BOOL isToday = NO;
    //    collectionView.contentOffset
    
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCell forIndexPath:indexPath];
    
    NSDate *firstOfMonth = [self firstOfMonthForSection:indexPath.section];
    NSDate *cellDate = [self dateForCellAtIndexPath:indexPath];
    
    NSDateComponents *cellDateComponents = [self.calendar components:kCalendarUnitYMD fromDate:cellDate];
    NSDateComponents *firstOfMonthsComponents = [self.calendar components:kCalendarUnitYMD fromDate:firstOfMonth];
    
   
    
    if (cellDateComponents.month == firstOfMonthsComponents.month){
        
        [cell setDate:cellDate calendar:self.calendar];
        
    }else{
        [cell setDate:nil calendar:nil];
    }
    
    //解决cell的复用显示问题需要初始化普通的cell
    cell.userInteractionEnabled = YES;
    cell.backgroundColor = [UIColor whiteColor];
    isToday = [self isTodayDate:cellDate];
      if (isToday) {
          [cell setBackgroundColor:[UIColor redColor]];
      }
    //无日期的cell不让点击
    if ([cell.dateLabel.text isEqualToString:@""]) {
        cell.userInteractionEnabled = NO;
    }
    
    if (self.startIndexPath != indexPath && self.endIndexPath != indexPath) {
        cell.dayLabel.text = @"";
    }
    if ([indexPath compare:self.startIndexPath] == NSOrderedDescending && [indexPath compare:self.endIndexPath] == NSOrderedAscending) {
        if (!cell.dateLabel.text.length) {
            
            cell.backgroundColor = [UIColor whiteColor];
        }else{
            
            cell.backgroundColor = ColorString(@"#D6E5FF");
        }
    }
    if ([indexPath compare:self.startIndexPath] == NSOrderedSame) {
        cell.backgroundColor = ColorString(@"#D6E5FF");
        cell.dayLabel.text = @"开始时间";
    }
    if ([indexPath compare:self.endIndexPath] == NSOrderedSame) {
        cell.backgroundColor = ColorString(@"#D6E5FF");
        cell.dayLabel.text = @"结束时间";
    }
  
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell * cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (self.startIndexPath && self.endIndexPath) {
        self.startIndexPath = nil;
        self.endIndexPath = nil;
        _startDay = nil;
        _endDay = nil;
    }
    
    if (self.startIndexPath) {
        
        //点击的日期大于开始日期
        if ([indexPath compare:self.startIndexPath] == NSOrderedDescending) {
            
            _endDay = cell.dateLabel.text;
            self.endIndexPath = indexPath;
            cell.dayLabel.text = @"结束时间";
            cell.backgroundColor = ColorString(@"#D6E5FF");
            [self.collectionView reloadData];
        }
        if ([indexPath compare:self.startIndexPath] == NSOrderedAscending) {
            
            _startDay = cell.dateLabel.text;
            cell.dateLabel.text = @"开始时间";
            cell.backgroundColor = ColorString(@"#D6E5FF");
            self.startIndexPath = indexPath;
            [self.collectionView reloadData];
        }
        
    }else{
        
        _startDay = cell.dateLabel.text;
        cell.dayLabel.text = @"开始时间";
        cell.backgroundColor = ColorString(@"#D6E5FF");
        self.startIndexPath = indexPath;
        [self.collectionView reloadData];
    }
    
    [self initSelectDay];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        CalendarViewHeader * headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderCell forIndexPath:indexPath];
        headerView.layer.shouldRasterize = YES;
        headerView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        headerView.title.text = [self.headerDateFormatter stringFromDate:[self firstOfMonthForSection:indexPath.section]].uppercaseString;
        return headerView;
    }
    return nil;
}


#pragma mark - 赋值起止日期
- (void)initSelectDay{
    
    if (self.startIndexPath && self.endIndexPath) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
        [dateFormatter setDateFormat:@"YYYY/MM"];
        //        NSString * startStr = [self.headerDateFormatter stringFromDate:[self firstOfMonthForSection:_startIndexPath.section]].uppercaseString;
        NSString *startStr = [dateFormatter stringFromDate:[self firstOfMonthForSection:_startIndexPath.section]];
        
        _startDay = [NSString stringWithFormat:@"%@/%@", startStr,_startDay];
        
        //        NSString * endStr = [self.headerDateFormatter stringFromDate:[self firstOfMonthForSection:_endIndexPath.section]].uppercaseString;
        
        NSString *endDate = [dateFormatter stringFromDate:[self firstOfMonthForSection:_endIndexPath.section]];
        NSLog(@"end--------------%@/%@", [dateFormatter stringFromDate:[self firstOfMonthForSection:_endIndexPath.section]],_endDay);
        _endDay = [NSString stringWithFormat:@"%@/%@", endDate, _endDay];
        
        
        
    }
    
    NSLog(@"startDay==%@, endDay==%@", _startDay, _endDay);
}

#pragma mark - CollectionViewFlowLayoutDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(screenWidth - 30 * WidthScale, 40);
}
#pragma mark -Calendar calculations
- (BOOL)isTodayDate:(NSDate *)date
{
    return [self clampAndCompareDate:date withReferenceDate:[NSDate date]];
}

- (BOOL)clampAndCompareDate:(NSDate *)date withReferenceDate:(NSDate *)referenceDate
{
    NSDate *refDate = [self clampDate:referenceDate toComponents:kCalendarUnitYMD];
    NSDate *clampedDate = [self clampDate:date toComponents:kCalendarUnitYMD];
    
    return [refDate isEqualToDate:clampedDate];
}

- (NSDate *)clampDate:(NSDate *)date toComponents:(NSUInteger)unitFlags
{
    NSDateComponents *components = [self.calendar components:unitFlags fromDate:date];
    return [self.calendar dateFromComponents:components];
}

#pragma mark - Collection View / Calendar Methods

- (NSDate *)firstOfMonthForSection:(NSInteger)section
{
    NSDateComponents *offset = [NSDateComponents new];
    offset.month = section;
    
    return [self.calendar dateByAddingComponents:offset toDate:self.firstDateMonth options:0];
}

- (NSCalendarUnit)weekCalendarUnitDependingOniOSVersion {
    //isDateInToday is a new (awesome) method available on iOS8 only.
    if ([self.calendar respondsToSelector:@selector(isDateInToday:)]) {
        return NSCalendarUnitWeekOfMonth;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return NSWeekCalendarUnit;
#pragma clang diagnostic pop
    }
}

- (NSDate *)dateForCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate *firstOfMonth = [self firstOfMonthForSection:indexPath.section];
    
    NSUInteger weekday = [[self.calendar components: NSCalendarUnitWeekday fromDate: firstOfMonth] weekday];
    NSInteger startOffset = weekday - self.calendar.firstWeekday;
    startOffset += startOffset >= 0 ? 0 : self.daysPerWeek;
    
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.day = indexPath.item - startOffset;
    
    return [self.calendar dateByAddingComponents:dateComponents toDate:firstOfMonth options:0];
}

#pragma mark -懒加载
- (NSDateFormatter *)headerDateFormatter;
{
    if (!_headerDateFormatter) {
        _headerDateFormatter = [[NSDateFormatter alloc] init];
        _headerDateFormatter.calendar = self.calendar;
        //设置时间格式为中文
        _headerDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _headerDateFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"yyyy LLLL" options:0 locale:self.calendar.locale];
    }
    return _headerDateFormatter;
}

- (NSCalendar *)calendar{
    if (!_calendar) {
        [self setCalendar:[NSCalendar currentCalendar]];
    }
    return _calendar;
}

- (NSDate *)firstDateMonth
{
    if (_firstDateMonth) { return _firstDateMonth; }
    
    NSDateComponents *components = [self.calendar components:kCalendarUnitYMD fromDate:self.firstDate];
    components.day = 1;
    _firstDateMonth = [self.calendar dateFromComponents:components];
    
    return _firstDateMonth;
}

- (NSDate *)firstDate
{
    if (!_firstDate) {
        NSDate * myDate = [NSDate date];
        
        NSDateComponents *components = [self.calendar components:kCalendarUnitYMD fromDate:myDate];
        
        [components setYear:2019 - myDate.year];
        [components setMonth:7 - myDate.month];
        
        _firstDate = [self.calendar dateByAddingComponents:components toDate:myDate options:0];
        
        NSLog(@"开始时间 === %@",[_firstDate WT_YYYYMMdd__]);
    }
    
    return _firstDate;
}

- (NSDate *)lastDate
{
    if (!_lastDate) {
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        offsetComponents.year = 3;
        offsetComponents.day = -1;
        [self setLastDate:[self.calendar dateByAddingComponents:offsetComponents toDate:self.firstDateMonth options:0]];
    }
    
    return _lastDate;
}

- (NSDate *)lastDateMonth
{
    if (_lastDateMonth) { return _lastDateMonth; }
    
    NSDateComponents *components = [self.calendar components:kCalendarUnitYMD fromDate:self.lastDate];
    components.month++;
    components.day = 0;
    
    _lastDateMonth = [self.calendar dateFromComponents:components];
    
    return _lastDateMonth;
}
@end
