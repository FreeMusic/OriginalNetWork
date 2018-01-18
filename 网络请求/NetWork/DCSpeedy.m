//
//  DCSpeedy.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCSpeedy.h"
#import "CocoaSecurity.h"
#import "Base64.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>

//HmacSHA1散列/哈希key : onlinehmacsha1
#define HmacSHA1Key @"onlinehmacsha1"
#define Localhost @"http://101.69.231.91:10010/onlineInterface/"

@implementation DCSpeedy
/**
 该方法主要是进行哈希加密 和 完成原生网络请求  仅支持POST请求

 @param dic 字典
 @param url 请求地址
 @param block dataTaskBlock返回会话对象和网络请求
 */
+ (void)hmacSha1Text:(NSDictionary *)dic url:(NSString *)url dataTaskBlock:(dataTaskBlock)block{
    NSArray *allKeys = [dic allKeys];
    NSString *jsonString = @"";
    for (int i = 0; i < allKeys.count; i++) {
        if (i == 0) {
            jsonString = [NSString stringWithFormat:@"{\"%@\":\"%@\",", allKeys[i], [dic objectForKey:allKeys[i]]];
        }else{
            if (allKeys.count == 2) {
                jsonString = [NSString stringWithFormat:@"%@\"%@\":\"%@\"}", jsonString, allKeys[i], [dic objectForKey:allKeys[i]]];
            }else if (allKeys.count == 1){
                jsonString = [NSString stringWithFormat:@"%@}", jsonString];
            }else{
                if (i < allKeys.count - 1) {
                    jsonString = [NSString stringWithFormat:@"%@\"%@\":\"%@\",", jsonString, allKeys[i], [dic objectForKey:allKeys[i]]];
                }else if (i == allKeys.count-1){
                    jsonString = [NSString stringWithFormat:@"%@\"%@\":\"%@\"}", jsonString, allKeys[i], [dic objectForKey:allKeys[i]]];
                }
            }
        }
    }
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    const char *cKey  = [HmacSHA1Key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [jsonString cStringUsingEncoding:NSUTF8StringEncoding];
    uint8_t cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    //NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    NSString *hash;
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", cHMAC[i]];
    hash = output;
    
    NSString *httpBody = [DCSpeedy removeStringLastCharactorWithOriginalString:jsonString];
    httpBody = [NSString stringWithFormat:@"%@,\"%@\":\"%@\"}", httpBody, @"mac", hash];
    //创建一个网络路径
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", Localhost, url]];
    //创建一个网络请求 分别设置请求方法、请求参数
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [httpBody dataUsingEncoding:NSUTF8StringEncoding];
    //获取会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    block(session, request);
}

/**
 删掉字符串最后一位
 
 @param Original 原有的字符串
 */
+ (NSString *)removeStringLastCharactorWithOriginalString:(NSString *)Original{
    NSString* cutted;
    if([Original length] > 0){
        cutted = [Original substringToIndex:([Original length]-1)];// 去掉最后一个","
    }else{
        cutted = Original;
    }
    return cutted;
}

@end
