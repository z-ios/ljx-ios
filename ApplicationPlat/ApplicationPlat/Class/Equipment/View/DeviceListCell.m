//
//  DeviceListCell.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/9.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "DeviceListCell.h"
#import "DataItemModel.h"
@interface DeviceListCell ()

@property(nonatomic, strong)UILabel *converted_dataLab;
@property(nonatomic, strong)UILabel *converted_data2Lab;
@property(nonatomic, strong)UILabel *csqLab;
@property(nonatomic, strong)UILabel *district_nameLab;
@property(nonatomic, strong)UIButton *online_stateBtn;
@property(nonatomic, strong)UIButton *alertImageV;


@end

@implementation DeviceListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        [self createUI];
    }
    return self;
}
- (void)createUI
{
    self.width = KScreenWidth;
    self.converted_dataLab = [[UILabel alloc]initWithFrame:CGRectMake(20 * WidthScale, 15 * HeightScale, (self.width  - 70 * WidthScale- 120 * WidthScale) , 20 * WidthScale)];
    _converted_dataLab.font = PingFangSCSemibold(16);
    _converted_dataLab.textColor = ColorString(@"#242B33");
    [self.contentView addSubview:_converted_dataLab];
    
    self.converted_data2Lab = [[UILabel alloc]initWithFrame:CGRectMake(20 * WidthScale,_converted_dataLab.bottom + 5 * HeightScale, (self.width  - 70 * WidthScale) / 2, 30 * WidthScale)];
    _converted_data2Lab.font = PingFangSCRegular(14);
    _converted_data2Lab.textColor = ColorString(@"#8A9199");
    _converted_data2Lab.adjustsFontSizeToFitWidth = YES;
    _converted_data2Lab.numberOfLines = 0;
    [self.contentView addSubview:_converted_data2Lab];
    
    self.alertImageV = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 50 * WidthScale, 15 * HeightScale, 20 * WidthScale, 20 * WidthScale)];
//    _alertImageV.backgroundColor = ColorString(@"#F2F2F2");
//    [_alertImageV setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    _alertImageV.userInteractionEnabled = NO;
    [self.contentView addSubview:_alertImageV];
    
    self.online_stateBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 70 * WidthScale, 15 * HeightScale, 20 * WidthScale, 20 * WidthScale)];
//    _online_stateBtn.backgroundColor = [UIColor redColor];
//    [_online_stateBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    _online_stateBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:_online_stateBtn];
    
    self.csqLab = [[UILabel alloc]initWithFrame:CGRectMake(_online_stateBtn.right + 10 * WidthScale, 15 * HeightScale, 60 * WidthScale, 20 * WidthScale)];
    _csqLab.text = @"0db";
    _csqLab.font = PingFangSCRegular(14);
    _csqLab.textColor = ColorString(@"#8A9199");
    _csqLab.textAlignment = NSTextAlignmentRight;
//    [self.contentView addSubview:_csqLab];
    
    self.district_nameLab = [[UILabel alloc]initWithFrame:CGRectMake(_converted_data2Lab.right + 10 * WidthScale, _online_stateBtn.bottom + 5 * HeightScale, (self.width  - 70 * WidthScale) / 2, 20 * WidthScale)];
//    _district_nameLab.text = @"天津市/西青区";
    _district_nameLab.font = PingFangSCRegular(16);
    _district_nameLab.textAlignment = NSTextAlignmentRight;
    _district_nameLab.textColor = ColorString(@"#8A9199");
    _district_nameLab.numberOfLines =0;
    _district_nameLab.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_district_nameLab];
    
}
- (void)setModel:(BreakerModel *)model
{
    _model = model;
    _converted_dataLab.text = model.gateway.node_Id;
    _converted_data2Lab.text = model.gateway.model;
    PropertyModel *dbModel = model.gateway.data_properties.signal;

    NSString *cityName = model.location.city_name ? [NSString stringWithFormat:@"%@/",model.location.city_name]:@"";
    NSString *districtName = model.location.district_name ? model.location.district_name:@"";

    _district_nameLab.text = [NSString stringWithFormat: @"%@%@",cityName,districtName ];
   

    _csqLab.text = dbModel.parsed_data? [NSString stringWithFormat:@"%@%@",dbModel.parsed_data,dbModel.unit]:@"0db";

//    [_online_stateBtn setImage:[UIImage imageNamed:[self setSignalImage:dbModel.parsed_data]] forState:UIControlStateNormal];
    NSString *onLine = model.gateway.state[@"online_state"];
    if ([onLine intValue] != 1) {
        [_online_stateBtn setImage:[UIImage imageNamed:@"icon_signal_offline"] forState:UIControlStateNormal];
     
    }else{
        [_online_stateBtn setImage:[UIImage imageNamed:@"icon_signal_4"] forState:UIControlStateNormal];

        
//        if ([dbModel.parsed_data isEqualToString:@""]||[dbModel.parsed_data isEqualToString:@"0"] ) {
//            [_online_stateBtn setImage:[UIImage imageNamed:@"icon_signal_offline"] forState:UIControlStateNormal];
//        }else{
//
//            [_online_stateBtn setImage:[UIImage imageNamed:[self setSignalImage:dbModel.parsed_data]] forState:UIControlStateNormal];
//        }
    }
    
    
    
}
- (NSString *)setSignalImage:(NSString *)signal
{
    NSString *signalStr = [NSString stringWithFormat:@"%d",abs([signal intValue]) ];
    
    if (signalStr) {
        
        if ([signalStr intValue] >= 31) {
            return @"icon_signal_4";
        }else if ([signalStr intValue] < 31 && [signalStr intValue] >= 18){
            return @"icon_signal_3";
            
        }else if ([signalStr intValue]  < 18 && [signalStr intValue] >= 11){
            return @"icon_signal_2";
            
        }else if ([signalStr intValue] < 11 && [signalStr intValue] > 1){
            return @"icon_signal_1";
            
        }else if ([signalStr intValue] == 1){
            return @"icon_signal_0";
            
        }else if ( [signalStr intValue] <= 0){
            
            return @"icon_signal_offline";
        }else{
            return @"icon_signal_4";
        }
        
    }else{
        return @"icon_signal_offline";
    }
    
    
}
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    frame.origin.x += 0;
    frame.origin.y += 0;
    frame.size.height = 80 * HeightScale;
    frame.size.width = KScreenWidth;
}
@end
