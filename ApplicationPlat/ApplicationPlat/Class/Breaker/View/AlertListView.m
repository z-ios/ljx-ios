//
//  AlertListView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/25.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "AlertListView.h"

@interface AlertListView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation AlertListView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self borderRoundCornerRadius:12];
        
//        NSMutableDictionary *params = [NSMutableDictionary dictionary];
//        int y = (arc4random() % 501) + 500;
//        params[@"type"] = [NSString stringWithFormat:@"过压异常--%d",y];
//        params[@"date"] = @"2020-12-23  23:21:21";
//        params[@"color"] = [self RandomColor];
//        [self.dataArray addObject:params];
        
        [self createUI];
//        [self refishData];
    }
    return self;
}
- (void)createUI
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(12 * WidthScale, 10 * HeightScale, self.width - 24 * WidthScale, 30 * HeightScale)];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, headerView.width, 30 * HeightScale)];
    [headerView addSubview:lable];
    [self addSubview:headerView];
    
    NSString *powerString = [NSString stringWithFormat:@"%@   Top 10",NSLocalizedString(@"breakerDeitalAlarm", nil)];
    NSMutableAttributedString *powerStringM = [[NSMutableAttributedString alloc] initWithString:powerString];
    NSRange kRange = [powerString rangeOfString:@"Top 10"];
    [powerStringM addAttribute:NSFontAttributeName value:PingFangSCMedium(16) range:NSMakeRange(0, powerStringM.length - 6)]; // 设置字体字号
    [powerStringM addAttribute:NSForegroundColorAttributeName value:ColorString(@"#282930") range:NSMakeRange(0, powerStringM.length - 6)];
    
    [powerStringM addAttribute:NSFontAttributeName value:PingFangSCLight(14) range:NSMakeRange(kRange.location, 6)]; // 设置字体字号
    [powerStringM addAttribute:NSForegroundColorAttributeName value:ColorString(@"#6D7278") range:NSMakeRange(kRange.location, 6)];
    lable.attributedText = powerStringM;
    
    
    [self addSubview:self.tableView];
    
}


- (void)addData
{
    
    
    
    if (self.dataArray.count > 4) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0];
        [self.dataArray removeLastObject];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        [self.tableView endUpdates];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    int y = (arc4random() % 501) + 500;
    params[@"type"] = [NSString stringWithFormat:@"过压异常--%d",y];
    params[@"date"] = @"2020-12-23  23:21:21";
    params[@"color"] = [self RandomColor];
    [self.dataArray insertObject:params atIndex:0];
    
    
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    //
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [indexPaths addObject: indexPath];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:(UITableViewScrollPositionTop) animated:YES];
    
//    [self.dataArray addObject:params];
//    [self.tableView reloadData];
////    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_dataArray.count -1 inSection:0];
////    [indexPaths addObject: indexPath];
////    [self.tableView beginUpdates];
////    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
////    [self.tableView endUpdates];
////    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_dataArray.count - 1 inSection:0] atScrollPosition:(UITableViewScrollPositionBottom) animated:YES];
    
    
    if (self.dataArray.count > 1) {
        self.tableView.height = (self.dataArray.count + 1) * 50 * HeightScale ;
        self.height = self.tableView.height + 10 * HeightScale;
        self.updateAlertHeight(self.height);
    }
    
}

-(UIColor*)RandomColor {
    NSInteger aRedValue =arc4random() %255;
    NSInteger aGreenValue =arc4random() %255;
    NSInteger aBlueValue =arc4random() %255;
    UIColor*randColor = [UIColor colorWithRed:aRedValue /255.0f green:aGreenValue /255.0f blue:aBlueValue /255.0f alpha:1.0f];
    return randColor;
    
}


- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40 * HeightScale, self.width - 24 * WidthScale, 50 * HeightScale) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 50 * HeightScale;
        //        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.separatorStyle = UITableViewScrollPositionNone;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage coloreImage:dic[@"color"] size:CGSizeMake(10, 10)];
    [cell.imageView roundV];
    cell.textLabel.text = dic[@"type"];
    cell.textLabel.font = PingFangSCRegular(15);
    cell.textLabel.textColor = ColorString(@"#595B67");
    cell.detailTextLabel.text = dic[@"date"];
    cell.detailTextLabel.font = PingFangSCRegular(14);
    cell.detailTextLabel.textColor = ColorString(@"#282930");
    cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;;
}



@end
