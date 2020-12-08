//
//  SearchController.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/9.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SearchModel.h"


NS_ASSUME_NONNULL_BEGIN
@protocol SearchControllerDelegate <NSObject>

- (void)searchDoneWithParmas:(SearchModel *)Model;

@end
@interface SearchController : UIViewController
@property(nonatomic, assign)id <SearchControllerDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
