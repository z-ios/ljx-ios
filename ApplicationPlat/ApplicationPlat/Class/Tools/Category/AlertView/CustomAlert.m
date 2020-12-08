//
//  CustomAlert.m
//  light
//
//  Created by ljxMac on 2019/11/28.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "CustomAlert.h"
#import "AlertDetailView.h"
@interface CustomAlert ()
@property(nonatomic, strong)AlertDetailView *alertView;
@end

@implementation CustomAlert
- (instancetype)initAlert:(NSString *)title
{
    self = [super init];
    if (self) {
        
        self.alertView = [[AlertDetailView alloc]initWithFrame:CGRectMake(17 * WidthScale, KScreenHeight /2 -227/2 * HeightScale, KScreenWidth -34* WidthScale, 227 * HeightScale) type:@"konw"];
        [self.alertView borderRoundCornerRadius:16];
        self.alertView.textStr = title;
        self.alertView.btnStr = @"确定";
        self.alertView.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
    
}
- (instancetype)initAlert:(NSString *)title btnTitle:(NSString *)btnTitle cancleTitle:(NSString *)cancleBtnTitle
{
    self = [super init];
    if (self) {
        
        self.alertView = [[AlertDetailView alloc]initWithFrame:CGRectMake(45 * WidthScale, KScreenHeight /2 -200/2 * HeightScale, KScreenWidth -90* WidthScale, 220 * HeightScale) type:@"cancle"];
        [self.alertView borderRoundCornerRadius:16];
        self.alertView.textStr = title;
        self.alertView.btnStr = btnTitle;
        self.alertView.cancleBtnTitle = cancleBtnTitle;
        self.alertView.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}
- (void)show
{

    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    [bgView addSubview:_alertView];
    bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    CZHWeakSelf(self)
    _alertView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    
    _alertView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        weakself.alertView.transform = CGAffineTransformMakeScale(1, 1);
        weakself.alertView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
    _alertView.determineBlock = ^{
       
        weakself.alertView.transform = CGAffineTransformMakeScale(1, 1);
        weakself.alertView.alpha = 1;
        
        [UIView animateWithDuration:0.2 animations:^{
            weakself.alertView.transform = CGAffineTransformMakeTranslation(0.1, 0.1);
            weakself.alertView.alpha = 0;
            bgView.alpha = 0;
        } completion:^(BOOL finished) {
            for (UIView *view in weakself.alertView.subviews) {
                [view removeFromSuperview];
            }
            [weakself.alertView removeFromSuperview];
            [bgView removeFromSuperview];
            
        }];
    };
//    CZHWeakSelf(self)
    _alertView.comBtnActionBlock = ^{
        
        weakself.alertView.transform = CGAffineTransformMakeScale(1, 1);
        weakself.alertView.alpha = 1;
        weakself.determineBlock();
        [UIView animateWithDuration:0.2 animations:^{
            weakself.alertView.transform = CGAffineTransformMakeTranslation(0.1, 0.1);
            weakself.alertView.alpha = 0;
            bgView.alpha = 0;
        } completion:^(BOOL finished) {
            for (UIView *view in weakself.alertView.subviews) {
                [view removeFromSuperview];
            }
            [weakself.alertView removeFromSuperview];
            [bgView removeFromSuperview];
          
            
        }];
    };
    

}
+ (void)alertVcWithMessage:(NSString *)msg Vc:(UIViewController *)vc
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *comAc = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addAction:comAc];
    [vc presentViewController:alertVc animated:YES completion:^{
        
    }];
}
@end
