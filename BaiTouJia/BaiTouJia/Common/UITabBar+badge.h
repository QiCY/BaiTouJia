//
//  UITabBar+badge.h
//  BaiTouJia
//
//  Created by apple on 2017/10/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UITabBar(badge)
- (void)showBadgeOnItmIndex:(int)index text:(NSString *)text;
- (void)hideBadgeOnItemIndex:(int)index;
@end
