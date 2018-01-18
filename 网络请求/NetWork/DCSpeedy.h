//
//  DCSpeedy.h
//  CDDStoreDemo
//
//  Created by apple on 2017/3/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^dataTaskBlock)(NSURLSession *session,  NSMutableURLRequest *request);

@interface DCSpeedy : NSObject

/**
 该方法主要是进行哈希加密 和 完成原生网络请求
 
 @param dic 字典
 @param url 请求地址
 @param block dataTaskBlock返回会话对象和网络请求
 */
+ (void)hmacSha1Text:(NSDictionary *)dic url:(NSString *)url dataTaskBlock:(dataTaskBlock)block;

@end
