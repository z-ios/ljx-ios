//
//  NewBreakerListCell.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/12.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"
#import "MainbreakerModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol NewBreakerListCellDelagte <NSObject>

- (void)presentWithAlert:(UIAlertController *)alert isDismiss:(BOOL)isDiss;
- (void)selecCellWithModel:(MainbreakerModel *)mainModel;


@end


@interface NewBreakerListCell : MGSwipeTableCell
@property(nonatomic, strong)MainbreakerModel *mainModel;
@property(nonatomic, copy)NSString *node_Id;
@property(nonatomic, copy)NSString *iId;
@property(nonatomic, strong)id <NewBreakerListCellDelagte>delea;
@end

NS_ASSUME_NONNULL_END
