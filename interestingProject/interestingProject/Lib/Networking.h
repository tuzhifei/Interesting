//
//  Networking.h
//  App
//
//  Created by Mark on 19/9/29.
//  Copyright © 2019年 Mark. All rights reserved.
//
// 
// 


#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface Networking : NSObject

// 请求成功之后回调的 Block
typedef void(^SuccessBlock) (AFHTTPRequestOperation *operation, id responseObject);

// 请求失败之后回调的 Block
typedef void(^FailBlock) (AFHTTPRequestOperation *operation, NSError *error);

typedef void(^successBlock) (NSInteger code, id responseObject);
typedef void(^failBlock) (NSError *error);


// 封装Get请求方法
+ (void)requestDataByURL:(NSString *)URL Parameters:(NSDictionary *)parameters success:(SuccessBlock)success failBlock:(FailBlock)fail;

/**
 *  获取每日精选
 *  @param urlString 链接地址
 */
+ (void)requestDailyVideoWithUrl:(NSString *)urlString
                    successBlock:(successBlock)successBlock
                       failBlock:(failBlock)failBlcok
                     isIndicator:(BOOL)isIndicator;

/**
*  获取每日新闻
*  @param urlString 链接地址
*/
+ (void)requestDailyNewsWithUrl:(NSString *)urlString
                   successBlock:(successBlock)successBlock
                      failBlock:(failBlock)failBlcok
                    isIndicator:(BOOL)isIndicator;

@end
