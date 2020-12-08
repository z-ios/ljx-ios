//
//  MainController.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/4.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "MainController.h"

@interface MainController ()<MAMapViewDelegate>
@property(nonatomic, strong)MAMapView *mapView;
@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
//    self.mapView.delegate = self;
//    [self.view addSubview:self.mapView];
    
    UILabel *detialLab = [UILabel z_labelWithText:@"暂未开放..." fontSize:12 color:[UIColor grayColor] CornerRadius:APH(35) / 2  backgroundColor:[UIColor whiteColor]];
    detialLab.frame = CGRectMake(self.view.width /2 - 200 * WidthScale/2, SCREEN_HEIGHT / 2-  APH(35) /2, 200 * WidthScale, APH(35));
    detialLab.textAlignment = NSTextAlignmentCenter;
    detialLab.font = PingFangSCRegular(17);
    [self.view addSubview:detialLab];
}



@end
