//
//  UITabBar+badge.m
//  BaiTouJia
//
//  Created by apple on 2017/10/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UITabBar+badge.h"
#define TabbarItemNums 3
@implementation UITabBar(badge)
//显示红点
- (void)showBadgeOnItmIndex:(int)index text:(NSString *)text{
    [self removeBadgeOnItemIndex:index];
    //新建小红点
    UILabel *bview = [[UILabel alloc]init];
    bview.tag = 888+index;
    bview.layer.cornerRadius = 7.5;
    bview.clipsToBounds = YES;
    bview.backgroundColor = [UIColor redColor];
    CGRect tabFram = self.frame;
    
    float percentX = (index+0.6)/TabbarItemNums;
    CGFloat x = ceilf(percentX*tabFram.size.width);
    CGFloat y = ceilf(0.1*tabFram.size.height);
    bview.frame = CGRectMake(x, y, 15, 15);
    bview.text = text;
    bview.textColor = [UIColor whiteColor];
    bview.font = [UIFont systemFontOfSize:8];
    bview.textAlignment = 1;
    [self addSubview:bview];
    [self bringSubviewToFront:bview];
}
//隐藏红点
-(void)hideBadgeOnItemIndex:(int)index{
    [self removeBadgeOnItemIndex:index];
}
//移除控件
- (void)removeBadgeOnItemIndex:(int)index{
    for (UIView*subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}


@end
