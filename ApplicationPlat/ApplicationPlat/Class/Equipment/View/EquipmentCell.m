//
//  EquipmentCell.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/17.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "EquipmentCell.h"

@interface EquipmentCell ()

@property(nonatomic, strong)UILabel *titleLab;
@property(nonatomic, strong)UILabel *detialLab;
@property(nonatomic, strong)UIButton *imageV;
@property(nonatomic, strong)UIButton *alertImageV;

@end


@implementation EquipmentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
//        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}
- (void)createUI
{
    self.width = KScreenWidth;
    self.height = 80 * HeightScale;
    self.imageV = [[UIButton alloc]initWithFrame:CGRectMake(20 * WidthScale,0,50 * WidthScale, 50 * WidthScale)];
    _imageV.centerY = self.centerY;
    [self.contentView addSubview:_imageV];
    
    self.detialLab = [UILabel z_labelWithText:@"" fontSize:12 color:ColorString(@"#0091FF") CornerRadius:APH(35) / 2  backgroundColor:ColorString(@"#EBF6FF")];
    _detialLab.frame = CGRectMake(self.width - 50 * WidthScale - 40 * WidthScale, 0, 50 * WidthScale, APH(35));
    _detialLab.textAlignment = NSTextAlignmentCenter;
    _detialLab.font = PingFangSCRegular(12);
    _detialLab.y = self.height / 2-  APH(35) / 2;
    
//    [self.contentView addSubview:_detialLab];
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(_imageV.right + 10 * WidthScale, 20 * HeightScale, self.width - _imageV.right - 70 * WidthScale - 80 * WidthScale , 40 * HeightScale)];
    _titleLab.textColor = ColorString(@"#858B92");
    _titleLab.font = PingFangSCRegular(18);
    _titleLab.textColor = ColorString(@"#242B33");
//    _titleLab.backgroundColor = ColorString(@"#EBF6FF");
    [self.contentView addSubview:_titleLab];
    self.alertImageV = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 50 * WidthScale - 40 * WidthScale - 30 * WidthScale,0,20 * WidthScale, 20 * WidthScale)];
    _alertImageV.centerY = self.centerY;
    [_alertImageV setImage:[UIImage imageNamed:@"icon_alarm"] forState:UIControlStateNormal];
//    _alertImageV.backgroundColor = ColorString(@"#F2F2F2");
    [_alertImageV borderRoundCornerRadius:4];
//    [self.contentView addSubview:_alertImageV];
    _alertImageV.userInteractionEnabled = NO;

}
- (void)setEqModel:(EquipmentModel *)eqModel
{
    _eqModel = eqModel;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURL,eqModel.phone_icon_url];
    UIImage *image = [SVGKImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]]].UIImage;
    [_imageV setImage:image forState:UIControlStateNormal];
    _titleLab.text = eqModel.name;
    _detialLab.text = @"300";
}
- (void)setResuletModel:(EquipmentResultModel *)resuletModel
{
    _resuletModel = resuletModel;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURL,resuletModel.phone_icon_url];
    UIImage *image = [SVGKImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]]].UIImage;
    [_imageV setImage:image forState:UIControlStateNormal];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:resuletModel.name];
    UIColor *highlightedColor = [UIColor colorWithRed:0 green:131/255.0 blue:0 alpha:1.0];
    [attributedString addAttribute:NSForegroundColorAttributeName value:highlightedColor range:resuletModel.textRange];
    _titleLab.attributedText = attributedString;
    _detialLab.text = @"300";
}
@end
