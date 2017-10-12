//
//  HTTPManage.m
//  BaiTouJia
//
//  Created by apple on 2017/10/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HTTPManage.h"
#import "AFNetworking.h"
@implementation HTTPManage
+(id)shareInstance{
    static HTTPManage *manage = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        manage = [[self alloc]init];
    });
    
    return manage;
}


@end
