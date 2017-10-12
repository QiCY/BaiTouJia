//
//  HTTPManage.m
//  BaiTouJia
//
//  Created by apple on 2017/10/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HTTPManage.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
@implementation HTTPManage
+(id)shareInstance{
    static HTTPManage *manage = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        manage = [[self alloc]init];
    });
    
    return manage;
}

-(void)sendDataRequest:(NSString *)URLString
            parameters:(nullable id)parameters data:(void (^)(id data))response
{
    NSURLSessionConfiguration * configuration = [ NSURLSessionConfiguration  defaultSessionConfiguration ];

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (response) {
            response(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (response) {
            response(error);
        }
        
    }];
    
}
-(void)sendUploadRequest{
    
}
@end
