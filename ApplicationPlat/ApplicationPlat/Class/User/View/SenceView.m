//
//  SenceView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/8.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "SenceView.h"
#import "SenceCell.h"
#import "SenceViewModel.h"
@interface SenceView ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)SenceViewModel *senceModel;
@end


@implementation SenceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.tableView];
        [self getData];
    }
    return self;
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 5 * HeightScale, KScreenWidth, KScreenHeight - Height_NavBar - 20 * HeightScale- Height_TabBar) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 180 * HeightScale;
        [_tableView registerClass:[SenceCell class] forCellReuseIdentifier:@"cell"];
        _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    }
    return _tableView;;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.dataArray.count;
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SenceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;;
}
- (SenceViewModel *)senceModel
{
    if (_senceModel == nil) {
        _senceModel = [[SenceViewModel alloc]init];
    }
    return _senceModel;
}
- (void)getData
{
    [self.senceModel setUpdateListCallBack:^(NSUInteger statuCode, BOOL isSuccess, NSError * _Nonnull error) {
        
    }];
    
}
@end
