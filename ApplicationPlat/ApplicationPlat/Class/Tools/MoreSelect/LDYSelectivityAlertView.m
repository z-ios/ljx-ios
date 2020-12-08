//
//  LDYSelectivityAlertView.m
//  LDYSelectivityAlertView
//
//  Created by 李东阳 on 2018/8/15.
//

#define kScreen_Width   [[UIScreen mainScreen] bounds].size.width
#define kScreen_Height  [[UIScreen mainScreen] bounds].size.height

#import "LDYSelectivityAlertView.h"
#import "UIColor+LDY.h"
#import "UIFont+LDY.h"
#import "LDYSelectivityTableViewCell.h"

@interface LDYSelectivityAlertView () {
    float alertViewHeight;//弹框整体高度，默认250
    float buttonHeight;//按钮高度，默认40
}

@property (nonatomic, strong) NSArray *datas;//数据源
@property (nonatomic, assign) BOOL ifSupportMultiple;//是否支持多选功能
@property (nonatomic, strong) UILabel *titleLabel;//标题label
@property (nonatomic, strong) UIView *alertView;//弹框视图
@property (nonatomic, strong) UITableView *selectTableView;//选择列表
@property (nonatomic, strong) UIButton *confirmButton;//确定按钮
@property (nonatomic, strong) UIButton *cancelButton;//取消按钮

@property (nonatomic, assign) NSIndexPath *selectIndexPath;//选择项的下标(单选)
@property (nonatomic, strong) NSMutableArray *selectArray;//选择项的下标数组(多选)

@end

@implementation LDYSelectivityAlertView

-(instancetype)initWithTitle:(NSString *)title
                       datas:(NSArray *)datas
           ifSupportMultiple:(BOOL)ifSupportMultiple{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];
        alertViewHeight = 350 * HeightScale;
        buttonHeight = 50 * HeightScale;
        self.selectArray = [NSMutableArray array];
        
        self.alertView = [[UIView alloc] initWithFrame:CGRectMake(16 * WidthScale, (kScreen_Height-alertViewHeight)/2.0, kScreen_Width-32 * WidthScale, alertViewHeight)];
        self.alertView.backgroundColor = [UIColor whiteColor];
        
        
        self.alertView.layer.cornerRadius = 8;
        self.alertView.layer.masksToBounds = YES;
        [self addSubview:self.alertView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.alertView.frame.size.width, buttonHeight)];
        self.titleLabel.text = title;
        //        self.titleLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.17];
        self.titleLabel.textColor = ColorString(@"#121212");
        self.titleLabel.font = [UIFont ldy_boldFontFor2xPixels:30];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.titleLabel.bottom , self.alertView.width, 0.5)];
        topLine.backgroundColor = [UIColor colorWithWhite:0 alpha:0.17];
        
        [self.alertView addSubview:topLine];
        
        [self.alertView addSubview:self.titleLabel];
        self.selectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topLine.frame), self.alertView.frame.size.width, self.alertView.bounds.size.height-buttonHeight*2 -2) style:UITableViewStylePlain];
        self.selectTableView.delegate = self;
        self.selectTableView.dataSource = self;
        self.datas = datas;
        self.ifSupportMultiple = ifSupportMultiple;
        [self.alertView addSubview:self.selectTableView];
        self.selectTableView.tableFooterView = [UIView new];
        self.selectTableView.backgroundColor = [UIColor whiteColor];
        
        if (self.ifSupportMultiple == YES){
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
            [self.selectTableView addGestureRecognizer:tap];
            [tap addTarget:self action:@selector(clickTableView:)];
        }
        
        UIView *downLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.selectTableView.bottom , self.alertView.width, 0.5)];
        downLine.backgroundColor = [UIColor colorWithWhite:0 alpha:0.17];
        
        [self.alertView addSubview:downLine];
        self.cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(20 * WidthScale, downLine.bottom, (self.alertView.width - 40 * WidthScale) /2, buttonHeight)];
        _cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:ColorString(@"#868686") forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelAction ) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:_cancelButton];
        UIView *ceLine = [[UIView alloc]initWithFrame:CGRectMake(_cancelButton.right, downLine.bottom, 0.5, 63 * HeightScale)];
        ceLine.backgroundColor = [UIColor colorWithWhite:0 alpha:0.17];
        [self.alertView addSubview:ceLine];
        self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ceLine.right, downLine.bottom,(self.alertView.width - 40 * WidthScale) /2, buttonHeight)];
        _confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [_confirmButton setTitleColor:DefaColor forState:UIControlStateNormal];
        [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:_confirmButton];
        
        
    }
    return self;
}

-(void)show{
    
    
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [UIView animateWithDuration:0.55f delay:0.0f usingSpringWithDamping:0.85f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (@available(iOS 12, *)) {
            
            [[[UIApplication sharedApplication].windows lastObject] addSubview:self];
        }else
        {
            [[UIApplication sharedApplication].keyWindow addSubview:self];
        }
        self.alertView.alpha = 0.0;
        self.alpha = 0;
        self.alpha = 1;
        self.alertView.alpha = 1;
    } completion:nil];
    
}

//手势事件
- (void)clickTableView:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self.selectTableView];
    NSIndexPath *indexPath = [self.selectTableView indexPathForRowAtPoint:point];
    if (indexPath == nil) {
        return;
    }
    
    if ([self.selectArray containsObject:@(indexPath.row)]) {
        [self.selectArray removeObject:@(indexPath.row)];
    }else {
        [self.selectArray addObject:@(indexPath.row)];
    }
    
    //按照数据源下标顺序排列
    [self.selectArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    [self.selectTableView reloadData];
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LDYSelectivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDYSelectivityTableViewCell"];
    if (!cell) {
        cell = [[LDYSelectivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LDYSelectivityTableViewCell"];
    }
    if (self.ifSupportMultiple == NO) {
        if (self.selectIndexPath == indexPath) {
            cell.selectIV.image = [UIImage imageNamed:@"agreement_selected"];
        }else{
            cell.selectIV.image = [UIImage imageNamed:@"agreement_normal"];
        }
    }else{
        if ([self.selectArray containsObject:@(indexPath.row)]) {
            cell.selectIV.image = [UIImage imageNamed:@"agreement_selected"];
        }else {
            cell.selectIV.image = [UIImage imageNamed:@"agreement_normal"];
        }
    }
    cell.titleLabel.text = _datas[indexPath.row];
    //    cell.sakura.backgroundColor(@"Fac.facAreaBtnBackgroundColor");
    cell.backgroundColor = [UIColor whiteColor];
    //    cell.titleLabel.sakura.textColor(@"Gis.areaViewTextColor");
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LDYSelectivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDYSelectivityTableViewCell"];
    if (self.ifSupportMultiple == NO) {
        self.selectIndexPath = indexPath;
        [tableView reloadData];
    }else{
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

//点击空白处
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    if (!CGRectContainsPoint([self.alertView frame], pt)) {
        [self cancelAction];
    }
}

//点击确定
- (void)confirmAction{
    
    if (self.selectIndexPath) {
        if (self.ifSupportMultiple == NO) {
            NSString *data = self.datas[self.selectIndexPath.row];
            if (_delegate && [_delegate respondsToSelector:@selector(singleChoiceBlockData:index:)])
            {
                [_delegate singleChoiceBlockData:data index: self.selectIndexPath.row];
            }
        }else{
            NSMutableArray *dataAr = [NSMutableArray array];
            [self.selectArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSNumber *data = obj;
                int row = [data intValue];
                [dataAr addObject:self.datas[row]];
            }];
            
            NSArray *datas = [NSArray arrayWithArray:dataAr];
            if (_delegate && [_delegate respondsToSelector:@selector(multipleChoiceBlockDatas:)])
            {
                [_delegate multipleChoiceBlockDatas:datas];
            }
        }
    }
    
    
    [self cancelAction];
}

//点击取消
- (void)cancelAction {
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
