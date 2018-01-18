//
//  DownLoadData.h
//  HengShuaWallet
//
//  Created by apple on 2018/1/15.
//  Copyright © 2018年 guanrukeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCSpeedy.h"

@interface DownLoadData : NSObject

/**
 登录
 */
+ (void)postLogin:(void (^) (id obj, NSError *error))block userName:(NSString *)userName passWord:(NSString *)passWord;

@end
