//
//  TestViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "TitleViewController.h"
#import "JXCategoryTitleView.h"

@interface TitleViewController ()

@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@end

@implementation TitleViewController

- (void)viewDidLoad {
    if (self.titles == nil) {
        _titles = @[NSLocalizedString(@"breakerDeitalStateTitle", nil),NSLocalizedString(@"breakerDeitalTimerTitle", nil),NSLocalizedString(@"breakerDeitalAttributeTitle", nil),NSLocalizedString(@"breakerDeitalAlarmsTitle", nil),NSLocalizedString(@"breakerDeitalOperationTitle", nil)];
    }

    [super viewDidLoad];
   

    self.myCategoryView.titles = self.titles;
}

- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (NSUInteger)preferredListViewCount {
    return self.titles.count;
}

- (Class)preferredCategoryViewClass {
    return [JXCategoryTitleView class];
}

@end
