//
//  DownLoadData.m
//  HengShuaWallet
//
//  Created by apple on 2018/1/15.
//  Copyright © 2018年 guanrukeji. All rights reserved.
//

#import "DownLoadData.h"

@implementation DownLoadData
/**
 登录
 */
+ (void)postLogin:(void (^) (id obj, NSError *error))block userName:(NSString *)userName passWord:(NSString *)passWord{
    NSString *url = @"Login";
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:userName forKey:@"userName"];
    [dic setValue:passWord forKey:@"passWord"];
    [DCSpeedy hmacSha1Text:dic url:url dataTaskBlock:^(NSURLSession *session, NSMutableURLRequest *request) {
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"登录  %@   %@", dic, dic[@"message"]);
            block(dic, nil);
        }];
        
        [task resume];
    }];
}
@end
