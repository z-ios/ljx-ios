//
//  RAMPaperSwitch.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/23.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "RAMPaperSwitch.h"

  struct Constants {

     NSString *scale;

    NSString *up  ;

    NSString *down;

}  ;

@interface RAMPaperSwitch ()<CAAnimationDelegate>
{
    double duration;
    CAShapeLayer *shape;
    CGFloat radius;
    BOOL oldState;
    UIColor *defaultTintColor;
    struct Constants constants;
}

@end

@implementation RAMPaperSwitch

- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView color:(UIColor *)color bgColor:(UIColor *)bgColor{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.onTintColor = color;
        duration = 0.35;
        shape = [[CAShapeLayer alloc]init];
        radius = 0.0;
        oldState = NO;
        constants.scale = @"transform.scale";
        constants.up = @"scaleUp";
        constants.down = @"scaleDown";
        defaultTintColor = bgColor;
        [self commonInit:superView];
    }
    return self;
    
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.parentView) {
        CGFloat x = MAX(self.centerX, self.parentView.width - CGRectGetMidX(self.frame));
        CGFloat y = MAX(self.centerY, self.parentView.height - CGRectGetMidY(self.frame));
        radius = sqrt(x*x + y*y);
    }
    
    CGPoint additional = self.parentView == self.superview ? CGPointZero: self.superview.frame.origin;
    shape.frame = CGRectMake(self.centerX - radius + additional.x - 2, self.center.y - radius + additional.y, radius * 2, radius * 2);
    shape.anchorPoint = CGPointMake(0.5, 0.5);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius * 2, radius * 2)].CGPath;
    
    
}
- (void)setOn:(BOOL)on animated:(BOOL)animated
{
    BOOL changed = on != self.isOn;
    [super setOn:on animated:animated];
    if (changed) {
        [self switchChangeWithAnimation:animated];
    }
}
- (void)commonInit:(UIView *)parentView
{
    self.parentView = parentView;
//    defaultTintColor = parentView.backgroundColor;
    [self border:[UIColor whiteColor] width:0.5 CornerRadius:self.frame.size.height / 2];
    shape.fillColor = defaultTintColor.CGColor;
    shape.masksToBounds = YES;
    [parentView.layer insertSublayer:shape atIndex:0];
    parentView.layer.masksToBounds = true;
    [self showShapeIfNeed];
    [self addTarget:self action:@selector(switchChanged) forControlEvents:UIControlEventValueChanged];
    
}
- (void)showShapeIfNeed
{
    shape.transform = self.isOn ? CATransform3DMakeScale(1.0, 1.0, 1.0) : CATransform3DMakeScale(0.000001, 0.0000001, 0.000001);
}
- (void)switchChanged
{
    [self switchChangeWithAnimation:true];
    self.swithTagBlock(true);
}
- (CABasicAnimation *)animateKeyPathWithKeyPath:(NSString *)keyPath fromValue:(CGFloat)from toValue:(CGFloat)to timing:(CAMediaTimingFunctionName)timingFunction{
    
    CABasicAnimation * animation = [[CABasicAnimation alloc]init];
    animation.keyPath = keyPath;
    animation.fromValue = [NSNumber numberWithFloat:from];
    animation.toValue = [NSNumber numberWithFloat:to];
    animation.repeatCount = 1;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = duration;
    animation.delegate = self;
    
    
    return animation;
    
    
}
- (void)switchChangeWithAnimation:(BOOL)animation
{
    shape.fillColor = defaultTintColor.CGColor;
    if (self.isOn) {
        CABasicAnimation * scaleAnimation = [self animateKeyPathWithKeyPath:constants.scale fromValue:0.01 toValue:1.0 timing:kCAMediaTimingFunctionEaseIn];
        if (animation == false) {
            scaleAnimation.duration = 0.0001;
        }
        [shape addAnimation:scaleAnimation forKey:constants.up];
    }else{
        CABasicAnimation * scaleAnimation = [self animateKeyPathWithKeyPath:constants.scale fromValue:1.0 toValue:0.01 timing:kCAMediaTimingFunctionEaseOut];
        if (animation == false) {
            scaleAnimation.duration = 0.0001;
        }
        [shape addAnimation:scaleAnimation forKey:constants.up];
    }
}
        
- (void)animationDidStart:(CAAnimation *)anim
{
    self.parentView.backgroundColor = [UIColor whiteColor];
    self.animationDidStartClosure(self.isOn);
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        self.parentView.backgroundColor = self.isOn ? defaultTintColor : [UIColor whiteColor];
        shape.fillColor = self.isOn ? defaultTintColor.CGColor : [UIColor whiteColor].CGColor;
    }
    self.animationDidStopClosure(self.isOn, flag);
}
//- (CAMediaTimingFunctionName *)convertToCAMediaTimingFunctionNameWithInput:(NSString *)input{
//    return  input;
//}

                                
@end
