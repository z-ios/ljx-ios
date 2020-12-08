//
//  BreakerNumberController.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/26.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "BreakerNumberController.h"
#import "BTCoverVerticalTransition.h"
#import "NumberCollection.h"
@interface BreakerNumberController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BTCoverVerticalTransition *aniamtion;
@property(nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation BreakerNumberController
- (instancetype)init{
    self = [super init];
    if (self) {
        _aniamtion = [[BTCoverVerticalTransition alloc]initPresentViewController:self withDragDismissEnabal:YES];
        self.transitioningDelegate = _aniamtion;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, SCREEN_HEIGHT - (SCREEN_HEIGHT - 320 * HeightScale));
  
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 200, 30)];
    label.text = @"485地址";
    [self.view addSubview:label];
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor colorWithRed:51/255 green:51/255 blue:51/255 alpha:1];
    self.dataSource = [NSMutableArray array];
    for (int i = 1; i < 64; i++) {
        [self.dataSource addObject:[NSString stringWithFormat:@"%d", i]];
    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 320 * HeightScale - 80) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
//    [self.collectionView registerNib:[NumberCollection class] forCellWithReuseIdentifier:@"SELECTELL"];
    [_collectionView registerClass:[NumberCollection class] forCellWithReuseIdentifier:@"SELECTELL"];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float w = (self.view.frame.size.width - 60)/6;
    float h = 36;
    return (CGSize){w,h};
}

//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NumberCollection *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SELECTELL" forIndexPath:indexPath];
    NSString *str = self.dataSource[indexPath.row];
    cell.titleLab.text = self.dataSource[indexPath.row];
    NSMutableArray *dataArr = [NSMutableArray arrayWithArray:self.selectArr];

    NSArray *sortedArray = [dataArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2]; //升序
        
    }];
    NSString *lastStr = sortedArray.lastObject;
    if ([_selectStr intValue] - 1 == [lastStr intValue]) {
        if ([lastStr intValue] == indexPath.row) {
            cell.backgroundColor = DefaColor;
            cell.titleLab.textColor = [UIColor whiteColor];
        }else{
            
            if ([self.selectArr containsObject:str]) {
                cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.19];
                cell.titleLab.textColor = [UIColor whiteColor];
            }else{
                cell.backgroundColor = [UIColor colorWithHex:@"#0091FF" alpha:0.08];
                cell.titleLab.textColor = ColorString(@"#121212");
            }
        }
    }else{
        if ([_selectStr intValue] - 1 == indexPath.row) {
            cell.backgroundColor = DefaColor;
            cell.titleLab.textColor = [UIColor whiteColor];
        }else{
            if ([self.selectArr containsObject:str]) {
                cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.19];
                cell.titleLab.textColor = [UIColor whiteColor];
            }else{
                cell.backgroundColor = [UIColor colorWithHex:@"#0091FF" alpha:0.08];
                cell.titleLab.textColor = ColorString(@"#121212");
            }
            
        }
    }
 
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NumberCollection *cell = (NumberCollection *)[collectionView cellForItemAtIndexPath:indexPath];
    NSString *str = self.dataSource[indexPath.row];
    if ([self.selectArr containsObject:str]) {
       
    }else{
        cell.backgroundColor = DefaColor;
        cell.titleLab.textColor = [UIColor whiteColor];
        NSString *str = self.dataSource[indexPath.row];
        self.backBlock(str);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
   
    
}

//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NumberCollection *cell = (NumberCollection *)[collectionView cellForItemAtIndexPath:indexPath];
////    cell.selImageIc.hidden = YES;
//    cell.backgroundColor = [UIColor colorWithWhite:1 alpha:0.28];
//    cell.titleLab.textColor = [UIColor whiteColor];
//}



@end
