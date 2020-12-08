//
//  GUSearchBar.m
//  Dark
//
//  Created by apple on 17/7/10.
//  Copyright © 2019 elco. All rights reserved.
//

#import "GUSearchBar.h"

@implementation GUSearchBar

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.font = [UIFont systemFontOfSize:12];
        self.layer.cornerRadius = 8;
        self.backgroundColor = ColorString(@"#F6F8FA");
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        UIView *rangeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 37 * WidthScale, 32 * HeightScale)];

        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(5 * WidthScale, 0 , 32 * WidthScale, 32 * HeightScale)];
        leftView.image = [UIImage imageNamed:@"icon_search"];
        
//        leftView.width = leftView.image.size.width + 30;
//        leftView.height = leftView.image.size.height;
        leftView.contentMode = UIViewContentModeCenter;
        [rangeView addSubview:leftView];
        self.leftView = rangeView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode = UITextFieldViewModeAlways;
        self.placeholder = @"搜索";
    }
    return self;
}

+(instancetype) searchBar
{
    return [[self alloc] init];
}


@end
