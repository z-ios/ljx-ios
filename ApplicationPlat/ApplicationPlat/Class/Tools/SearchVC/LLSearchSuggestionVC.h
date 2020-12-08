//
//  LLSearchSuggestionVC.h
//  LLSearchView
//
//  Created by 王龙龙 on 2017/7/25.
//  Copyright © 2017年 王龙龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EquipmentModel.h"
typedef void(^SuggestSelectBlock)(NSInteger index,EquipmentModel *model);
@interface LLSearchSuggestionVC : UIViewController

@property (nonatomic, copy) SuggestSelectBlock searchBlock;

- (void)searchTestChangeWithTest:(NSString *)test;
@property(nonatomic, strong)NSArray *array;

@end
