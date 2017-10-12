//
//  HTTPManage.h
//  BaiTouJia
//
//  Created by apple on 2017/10/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPManage : NSObject
+(id)shareInstance;
-(void)sendDataRequest:(NSString *)URLString
            parameters:(id)parameters data:(void (^)(id data))response;

@end
