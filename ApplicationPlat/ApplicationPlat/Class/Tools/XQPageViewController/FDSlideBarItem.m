//
//  FDSlideBarItem.m
//  FDSlideBarDemo
//
//  Created by Ticsmatic on 2017/7/20.
//  Copyright © 2017年 Ticsmatic. All rights reserved.
//

#import "FDSlideBarItem.h"

#define DEFAULT_TITLE_FONTSIZE 15
#define DEFAULT_TITLE_SELECTED_FONTSIZE 17
#define DEFAULT_TITLE_COLOR [UIColor blackColor]
#define DEFAULT_TITLE_SELECTED_COLOR [UIColor blueColor]

#define HORIZONTAL_MARGIN 10

@interface FDSlideBarItem ()

@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) CGFloat fontSize;
@property (assign, nonatomic) CGFloat selectedFontSize;
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) UIColor *selectedColor;
@property (strong, nonatomic) UIColor *bgColor;
@property (strong, nonatomic) UIColor *selectedBgColor;
@end

@implementation FDSlideBarItem

#pragma mark - Lifecircle

- (instancetype) init {
    if (self = [super init]) {
        _fontSize = DEFAULT_TITLE_FONTSIZE;
        _selectedFontSize = DEFAULT_TITLE_SELECTED_FONTSIZE;
        _color = DEFAULT_TITLE_COLOR;
        _selectedColor = DEFAULT_TITLE_SELECTED_COLOR;
        _bgColor = [UIColor whiteColor];
        _selectedColor = ColorString(@"#0091FF");
        self.backgroundColor = ColorString(@"#F4F6FC");;

    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGFloat titleX = (CGRectGetWidth(self.frame) - [self titleSize].width) * 0.5;
    CGFloat titleY = (CGRectGetHeight(self.frame) - [self titleSize].height) * 0.5;
    
    CGRect titleRect = CGRectMake(titleX, titleY, [self titleSize].width , [self titleSize].height );
    NSDictionary *attributes = @{NSFontAttributeName : [self titleFont], NSForegroundColorAttributeName : [self titleColor],NSBackgroundColorAttributeName: [self bgColor]};
    [_title drawInRect:titleRect withAttributes:attributes];
    if (_selected) {
        self.backgroundColor = _bgColor;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowColor = [UIColor whiteColor].CGColor;
        self.layer.shadowRadius = self.height / 2;
        
    }else{
        self.layer.shadowOffset = CGSizeMake(0, 4);
        self.layer.shadowColor = [UIColor colorWithHex:@"#2A3747" alpha:0.15].CGColor;
        self.layer.shadowRadius = self.height / 2;
        self.backgroundColor = _selectedBgColor;
    }

}

#pragma mark - Custom Accessors

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    [self setNeedsDisplay];
}

#pragma mark - Public

- (void)setItemTitle:(NSString *)title {
    _title = title;
    [self setNeedsDisplay];
}

- (void)setItemTitleFont:(CGFloat)fontSize {
    _fontSize = fontSize;
    [self setNeedsDisplay];
}

- (void)setItemSelectedTileFont:(CGFloat)fontSize {
    _selectedFontSize = fontSize;
    [self setNeedsDisplay];
}

- (void)setItemTitleColor:(UIColor *)color {
    _color = color;
    [self setNeedsDisplay];
}

- (void)setItemSelectedTitleColor:(UIColor *)color {
    _selectedColor = color;
    [self setNeedsDisplay];
}
- (void)setItemBgColor:(UIColor *)color
{
    _bgColor = color;
    [self setNeedsDisplay];
}
- (void)setItemSelectBgColor:(UIColor *)color
{
    _selectedBgColor = color;
    [self setNeedsDisplay];
}

#pragma mark - Private

- (CGSize)titleSize {
    NSDictionary *attributes = @{NSFontAttributeName : [self titleFont]};
    CGSize size = [_title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    
    return size;
}

- (UIFont *)titleFont {
    return _selected ? PingFangSCSemibold(_selectedFontSize) : PingFangSCSemibold(_fontSize);
}

- (UIColor *)titleColor {
    return _selected ? _selectedColor : _color;
}
- (UIColor *)bgColor
{
    return _selected ? _selectedBgColor : _bgColor;

}
#pragma mark - Public Class Method

+ (CGFloat)widthForTitle:(NSString *)title {
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:DEFAULT_TITLE_FONTSIZE]};
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    size.width = ceil(size.width) + HORIZONTAL_MARGIN * 2;
    
    return size.width;
}

#pragma mark - Responder

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.selected = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(slideBarItemSelected:)]) {
        [self.delegate slideBarItemSelected:self];
    }
}
@end
