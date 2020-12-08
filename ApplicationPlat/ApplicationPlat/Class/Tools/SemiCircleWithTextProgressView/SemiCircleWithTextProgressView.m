//
//  SemiCircleWithTextProgressView.m
//  SHProgressView
//
//  Created by zxy on 16/3/16.
//  Copyright © 2016年 Chenshaohua. All rights reserved.
//

#import "SemiCircleWithTextProgressView.h"
@interface SemiCircleWithTextProgressView()
{
    CAShapeLayer *_bottomShapeLayer;
    CAShapeLayer *_upperShapeLayer;
    CGFloat _percent;
    UILabel *_percentLabel;
    
}
@end

@implementation SemiCircleWithTextProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self drawBottomLayer];
        [self drawUpperLayer];
        [self.layer addSublayer:_bottomShapeLayer ];
        [_bottomShapeLayer addSublayer:_upperShapeLayer];
        
        // 文本框
        [self drawTextLabel];
        [self addSubview:_percentLabel];
    }
    return self;
}

- (UILabel *)drawTextLabel
{
    _percentLabel = [[UILabel alloc] init];
    CGFloat centerX = (CGRectGetMaxX(self.frame) - CGRectGetMinX(self.frame)) / 2;
    CGFloat centerY = (CGRectGetMaxY(self.frame) - CGRectGetMinY(self.frame)) / 2;
    CGFloat width = self.frame.size.width / 2;
    CGFloat height = self.frame.size.height / 2;
    _percentLabel.center = CGPointMake(centerX, centerY);
    _percentLabel.bounds = CGRectMake(0, 0, width, height);
    
    _percentLabel.font = [UIFont boldSystemFontOfSize:18];
    _percentLabel.textAlignment = NSTextAlignmentCenter;
    _percentLabel.textColor = ColorString(@"#042C5C");
    
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(percentChange) userInfo:nil repeats:YES];
    }
    return _percentLabel;
}

- (void)percentChange
{
    NSString *valueString = [NSString stringWithFormat:@"%.0f%%",_percent * 100];
    NSMutableAttributedString *stringM = [[NSMutableAttributedString alloc] initWithString:valueString];
    NSRange range = [valueString rangeOfString:@"%"];
    [stringM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Avenir-Medium" size:17] range:NSMakeRange(0, stringM.length - 1)]; // 设置字体字号
    [stringM addAttribute:NSForegroundColorAttributeName value:ColorString(@"#042C5C") range:NSMakeRange(0, stringM.length - 1)];

    [stringM addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:8] range:NSMakeRange(range.location, 1)]; // 设置字体字号
    [stringM addAttribute:NSForegroundColorAttributeName value:ColorString(@"#8798AD") range:NSMakeRange(range.location, 1)];
//    self.centerValueLabel.attributedText = stringM;
//    _percentLabel.text = [NSString stringWithFormat:@"%.0f%%",_percent * 100];
    _percentLabel.attributedText = stringM;
}

- (CAShapeLayer *)drawBottomLayer
{
    _bottomShapeLayer                 = [[CAShapeLayer alloc] init];
    _bottomShapeLayer.frame           = self.bounds;
    CGFloat width                     = self.bounds.size.width;
    
    UIBezierPath *path                = [UIBezierPath bezierPathWithArcCenter:CGPointMake((CGRectGetMaxX(self.frame) - CGRectGetMinX(self.frame)) / 2, (CGRectGetMaxY(self.frame) - CGRectGetMinY(self.frame)) / 2)  radius:width / 2 startAngle:2.85 endAngle:0.3 clockwise:YES];
    _bottomShapeLayer.path            = path.CGPath;
    
#pragma mark - 如果想显示为齿轮状态，则打开这段代码
//    _bottomShapeLayer.lineCap = kCALineCapButt;
//    _bottomShapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:5],[NSNumber numberWithInt:5], nil];
    
#pragma mark - 线段的开头为圆角
    _bottomShapeLayer.lineCap = kCALineCapRound;
    
    _bottomShapeLayer.lineWidth = 3.5;
    _bottomShapeLayer.strokeColor     = ColorString(@"#DFE7F5").CGColor;
    _bottomShapeLayer.fillColor       = [UIColor clearColor].CGColor;
    return _bottomShapeLayer;
}


- (CAShapeLayer *)drawUpperLayer
{
    _upperShapeLayer                 = [[CAShapeLayer alloc] init];
    _upperShapeLayer.frame           = self.bounds;
    CGFloat width                     = self.bounds.size.width;
    
    UIBezierPath *path                = [UIBezierPath bezierPathWithArcCenter:CGPointMake((CGRectGetMaxX(self.frame) - CGRectGetMinX(self.frame)) / 2, (CGRectGetMaxY(self.frame) - CGRectGetMinY(self.frame)) / 2)  radius:width / 2 startAngle:2.85 endAngle:0.3 clockwise:YES];
    _upperShapeLayer.path            = path.CGPath;
    _upperShapeLayer.strokeStart = 0;
    _upperShapeLayer.strokeEnd =   0;
    [self performSelector:@selector(shapeChange) withObject:nil afterDelay:0.3];
    _upperShapeLayer.lineWidth = 3.5;
    
    
#pragma mark - 如果想显示为齿轮状态，则打开这段代码
//    _upperShapeLayer.lineCap = kCALineCapButt;
//    _upperShapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:5],[NSNumber numberWithInt:5], nil];
    
#pragma mark - 线段的开头为圆角
     _upperShapeLayer.lineCap = kCALineCapRound;
    
    _upperShapeLayer.strokeColor     = ColorString(@"#00C99C").CGColor;
    _upperShapeLayer.fillColor       = [UIColor clearColor].CGColor;
    return _upperShapeLayer;
}

@synthesize percent = _percent;
- (CGFloat )percent
{
    return _percent;
}
- (void)setPercent:(CGFloat)percent
{
    _percent = percent;
    
    if (percent > 1) {
        percent = 1;
    }else if (percent < 0){
        percent = 0;
    }
    
}

- (void)shapeChange
{
    _upperShapeLayer.strokeEnd = _percent;
}


@end
