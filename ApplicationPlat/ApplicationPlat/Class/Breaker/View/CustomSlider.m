//
//  CustomSlider.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/12/8.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "CustomSlider.h"

@implementation CustomSlider

//- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
//{
//    rect.origin.x = rect.origin.x - 10 ;
//    rect.size.width = rect.size.width +20;
//    return CGRectInset ([super thumbRectForBounds:bounds trackRect:rect value:value], 10 , 10);
//}
-(CGRect)trackRectForBounds:(CGRect)bounds
{
    bounds.origin.x=15;
    bounds.origin.y=bounds.size.height/3;
    bounds.size.height=bounds.size.height/5;
    bounds.size.width=bounds.size.width-30;
    return bounds;
}
@end
