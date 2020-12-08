//
//  DottedLineView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/5.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "DottedLineView.h"

@implementation DottedLineView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef cont = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cont, [UIColor colorWithWhite:0 alpha:0.19].CGColor);
    CGContextSetLineWidth(cont, 1);
    CGFloat lengths[] = {2,2};
    CGContextSetLineDash(cont, 0, lengths, 2);  //画虚线
    CGContextBeginPath(cont);
    CGContextMoveToPoint(cont, 0.0, rect.size.height - 1);    //开始画线
    CGContextAddLineToPoint(cont, 320.0, rect.size.height - 1);
    CGContextStrokePath(cont);
}


@end
