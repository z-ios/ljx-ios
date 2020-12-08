//
//  SenceCell.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/8.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "SenceCell.h"

@interface SenceCell ()
@property(nonatomic, strong)UILabel *versionLab;
@property(nonatomic, strong)UILabel *fileSizeLab;
@property(nonatomic, strong)UILabel *updateDateLab;
@property(nonatomic, strong)UILabel *updateLab;
@property(nonatomic, strong)UILabel *updateDatailLab;

@end


@implementation SenceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
        
    }
    return self;
}
- (void)createUI
{
    UILabel *nextLab = [[UILabel alloc]initWithFrame:CGRectMake(20 * WidthScale, 0, 50 * WidthScale, 50 * WidthScale)];
    [nextLab border:ColorString(@"#AEB8C0") width:1 CornerRadius:25 * WidthScale ];
    nextLab.text = @"↓";
    nextLab.textColor = ColorString(@"#AEB8C0");
    nextLab.font = [UIFont systemFontOfSize:25];
    nextLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:nextLab];
    CAShapeLayer *nextLine = [UIView drawLine:CGPointMake(45 * WidthScale, nextLab.bottom) to:CGPointMake(45 * WidthScale, 180 * HeightScale) color:ColorString(@"#EBEBEB") lineWidth:2];
    [self.layer addSublayer:nextLine];
    self.versionLab = [[UILabel alloc]initWithFrame:CGRectMake(nextLab.right + 10 * WidthScale, 5 * HeightScale, self.width - nextLab.right - 20 * WidthScale, 20 * WidthScale)];
    _versionLab.text = @"1.0.5 (Build 1)";
    _versionLab.font = [UIFont boldSystemFontOfSize:17];
    _versionLab.textColor = ColorString(@"#48494A");
    [self.contentView addSubview:_versionLab];
    
    self.fileSizeLab = [[UILabel alloc]initWithFrame:CGRectMake(nextLab.right + 10 * WidthScale,_versionLab.bottom + 15 * HeightScale, self.width - nextLab.right - 20 * WidthScale, 20 * WidthScale)];
    _fileSizeLab.text = @"文件大小：12.43M";
    _fileSizeLab.textColor = ColorString(@"#616161");
    _fileSizeLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_fileSizeLab];
    
    self.updateDateLab = [[UILabel alloc]initWithFrame:CGRectMake(nextLab.right + 10 * WidthScale,_fileSizeLab.bottom, self.width - nextLab.right - 20 * WidthScale, 20 * WidthScale)];
    _updateDateLab.text = @"更新于：2020-07-22 14:27:27";
    _updateDateLab.textColor = ColorString(@"#616161");
    _updateDateLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_updateDateLab];
  
    
    self.updateLab = [[UILabel alloc]initWithFrame:CGRectMake(nextLab.right + 10 * WidthScale,_updateDateLab.bottom + 10 * HeightScale, self.width - nextLab.right - 20 * WidthScale, 20 * WidthScale)];
    _updateLab.text = @"更新日志";
    _updateLab.font = [UIFont boldSystemFontOfSize:17];

    _updateLab.textColor = ColorString(@"#48494A");
    [self.contentView addSubview:_updateLab];
//    6A6A6A
    self.updateDatailLab = [[UILabel alloc]initWithFrame:CGRectMake(nextLab.right + 10 * WidthScale,_updateLab.bottom + 10 * HeightScale, self.width - nextLab.right - 20 * WidthScale, 20 * WidthScale)];
         _updateDatailLab.text = @"修改频繁跳出查询失败文字bug";
         _updateDatailLab.textColor = ColorString(@"#6A6A6A");
         _updateDatailLab.font = [UIFont systemFontOfSize:14];
         [self.contentView addSubview:_updateDatailLab];
}
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    frame.origin.x += 0;
    frame.origin.y += 0;
    frame.size.height = 180 * HeightScale;
    frame.size.width = KScreenWidth;
}
@end
