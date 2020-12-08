//
//  OneViewController.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/8.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "OneViewController.h"
#import "CircleIndicatorView.h"
#import "SemiCircleWithTextProgressView.h"

@interface OneViewController ()
@property(nonatomic, strong)CircleIndicatorView *circleIndicatorView;;
@property(nonatomic, strong)UILabel *detialLab;
@property(nonatomic, strong)UILabel *titleLab;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *detialLab = [UILabel z_labelWithText:@"暂未开放..." fontSize:12 color:[UIColor grayColor] CornerRadius:APH(35) / 2  backgroundColor:[UIColor whiteColor]];
    detialLab.frame = CGRectMake(self.view.width /2 - 200 * WidthScale/2, SCREEN_HEIGHT / 2-  APH(35) /2, 200 * WidthScale, APH(35));
    detialLab.textAlignment = NSTextAlignmentCenter;
    detialLab.font = PingFangSCRegular(17);
    [self.view addSubview:detialLab];
    
    
    //    for (NSString* family in [UIFont familyNames])
    //    {
    //        NSLog(@"%@", family);
    //        for (NSString* name in [UIFont fontNamesForFamilyName: family])
    //        {
    //            NSLog(@"  %@", name);
    //        }
    //    }
    ////font-family: Rubik-Light, Rubik;
    ////    CGFloat h = 400 * HeightScale;
    ////    NSString *str=[NSString stringWithFormat:@"%.0f", APH(300)];
    //    self.circleIndicatorView = [[CircleIndicatorView alloc]initWithFrame:CGRectMake(20 * WidthScale, 150 * HeightScale, 300 * WidthScale,APHs(300))];
    //    _circleIndicatorView.backgroundColor = [UIColor whiteColor];
    //    _circleIndicatorView.openAngle = 180;
    //    _circleIndicatorView.userInteractionEnabled = NO;
    //    _circleIndicatorView.maxValue = 100;
    //    _circleIndicatorView.minValue = 0;
    //    _circleIndicatorView.circleCenter = CGPointMake(100 * WidthScale, 43 * HeightScale);
    //    _circleIndicatorView.radius = 100 * WidthScale;
    //    _circleIndicatorView.indicatorValue = 86;
    //    _circleIndicatorView.centerValue = 86;
    //    _circleIndicatorView.innerAnnulusValueToShowArray = @[];
    ////    _circleIndicatorView
    //    [self.view addSubview:_circleIndicatorView];
    //
    //    SemiCircleWithTextProgressView *progress = [[SemiCircleWithTextProgressView alloc] initWithFrame:CGRectMake(50, 500  * HeightScale, 300, 300)];
    //    progress.percent = 0.41;
    //    [self.view addSubview:progress];
    
    
    //    self.detialLab = [UILabel z_labelWithText:@"" fontSize:12 color:ColorString(@"#858B92") CornerRadius:APH(35) /2 backgroundColor:ColorString(@"#EBF6FF")];
    //    //    self.detialLab = [[UILabel alloc]initWithFrame:CGRectMake(self.width - 50 * WidthScale - 40 * WidthScale, 40 / 2 * HeightScale, 50 * WidthScale, 30 * HeightScale)];
    //    _detialLab.frame = CGRectMake(100 * WidthScale, 500  * HeightScale, 60 * WidthScale,APH(35) );
    //        _detialLab.textAlignment = NSTextAlignmentCenter;
    //    //    _detialLab.textColor = ColorString(@"#858B92");
    //    //    _detialLab.backgroundColor = ColorString(@"#EBF6FF");
    //    ////    _detialLab.backgroundColor = [UIColor redColor];
    //    //    _detialLab.font = [UIFont systemFontOfSize:12];
    //    ////    [_detialLab borderRoundCornerRadius:35 / 2 * HeightScale];
    //    //    _detialLab.layer.cornerRadius = 35 / 2 * HeightScale;
    //    //    _detialLab.layer.masksToBounds = YES;
    //        [self.view addSubview:_detialLab];
    //
    ////    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(100 * WidthScale, 550 * HeightScale, self.view.width - 200 * WidthScale , 40 * HeightScale )];
    ////        _titleLab.textColor = ColorString(@"#858B92");
    ////        _titleLab.font = [UIFont systemFontOfSize:18];
    ////        _titleLab.textColor = ColorString(@"#242B33");
    ////        _titleLab.backgroundColor = ColorString(@"#EBF6FF");
    ////        [self.view addSubview:_titleLab];
    
}



@end
