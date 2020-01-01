//
//  Networking.m
//  App
//
//  Created by Mark on 19/9/29.
//  Copyright © 2019年 Mark. All rights reserved.
//
// 
// 


#import "Networking.h"
static NSString *baseUrl = @"https://baobab.kaiyanapp.com";
@implementation Networking

+ (AFHTTPRequestOperationManager *)initAFHttpManager {
    static AFHTTPRequestOperationManager *manager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[AFHTTPRequestOperationManager alloc] init];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        manager.operationQueue.maxConcurrentOperationCount = 1;
    });
    
    return manager;
}

+(void)requestDataByURL:(NSString *)URL Parameters:(NSDictionary *)parameters success:(SuccessBlock)success failBlock:(FailBlock)fail{
    
    AFHTTPRequestOperationManager *manager = [Networking initAFHttpManager];
    [manager GET:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        fail(operation,error);
    }];
}

+ (AFHTTPSessionManager *)sunmiStoreHttpManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//Json
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    return manager;
}

+ (void)netServiceWithUrlString:(NSString * _Nonnull)urlString
                         params:(NSDictionary *)param
                   successBlock:(successBlock)successBlock
                      failBlock:(failBlock)failBlock
                  withIndicator:(BOOL)indicator {
    if (indicator) {
        [SMProgressHUD showIndicator];
    }
    AFHTTPSessionManager *manager = [self sunmiStoreHttpManager];
    [manager GET:urlString
      parameters:param
         success:^(NSURLSessionDataTask *task, id responseObject) {
        if (successBlock) {
            if (indicator) {
                [SMProgressHUD hideIndicator];
            }
            if (successBlock) {
                successBlock(1, responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failBlock) {
            failBlock(error);
        }
    }];
}

+ (void)requestDailyVideoWithDate:(NSInteger)date
                     successBlock:(successBlock)successBlock
                        failBlock:(failBlock)failBlcok
                      isIndicator:(BOOL)isIndicator {
    NSString *url =  @"/api/v5/index/tab/feed";
    NSDictionary *dict = @{@"num": @(2),
                           @"date": @(1577326882000)};
    [self netServiceWithUrlString:url params:dict successBlock:^(NSInteger code, id responseObject) {
        if (successBlock) {
            successBlock(1, responseObject);
        }
    } failBlock:^(NSError *error) {
        if (failBlcok) {
            failBlcok(error);
        }
    } withIndicator:isIndicator];
}

+ (void)requestDailyVideoWithUrl:(NSString *)urlString
                    successBlock:(successBlock)successBlock
                       failBlock:(failBlock)failBlcok
                     isIndicator:(BOOL)isIndicator {
    if (urlString.length == 0) {
        urlString = [NSString stringWithFormat:@"%@/api/v5/index/tab/feed", baseUrl];
    }
    [self netServiceWithUrlString:urlString
                           params:@{}
                     successBlock:^(NSInteger code, id responseObject) {
        if (successBlock) {
            successBlock(1, responseObject);
        }
    } failBlock:^(NSError *error) {
        if (failBlcok) {
            failBlcok(error);
        }
    } withIndicator:isIndicator];
    
}

+ (void)requestDailyNewsWithUrl:(NSString *)urlString
                   successBlock:(successBlock)successBlock
                      failBlock:(failBlock)failBlcok
                    isIndicator:(BOOL)isIndicator {
    if (urlString.length == 0) {
        urlString = [NSString stringWithFormat:@"%@/api/v7/information/list?vc=6704", baseUrl];
    }
    [self netServiceWithUrlString:urlString
                           params:@{}
                     successBlock:^(NSInteger code, id responseObject) {
        if (successBlock) {
            successBlock(1, responseObject);
        }
    } failBlock:^(NSError *error) {
        if (failBlcok) {
            failBlcok(error);
        }
    } withIndicator:isIndicator];
}

+ (void)requestAuthorWithUrl:(NSString *)urlString
                successBlock:(successBlock)successBlock
                   failBlock:(failBlock)failBlcok
                 isIndicator:(BOOL)isIndicator {
    if (urlString.length == 0) {
        urlString = [NSString stringWithFormat:@"%@/api/v3/tabs/pgcs/more?start=0&num=10", baseUrl];
    }
    [self netServiceWithUrlString:urlString
                           params:@{}
                     successBlock:^(NSInteger code, id responseObject) {
        if (successBlock) {
            successBlock(1, responseObject);
        }
    } failBlock:^(NSError *error) {
        if (failBlcok) {
            failBlcok(error);
        }
    } withIndicator:isIndicator];
}

+ (void)requestUrlWithReponseBlock:(void(^)(NSInteger code, id response))reponseBlock {
    NSString *url = @"http://47.244.241.125:9010/app/check/update";
    NSDictionary *param = @{@"version": @(7),
                            @"app_id": @(1493329304),
                            @"sign": @"2965f6deada667b9ba8b89441638e252"
    };
    [self netServiceWithUrlString:url params:param successBlock:^(NSInteger code, id responseObject) {
        if (reponseBlock) {
            reponseBlock(1, responseObject);
        }
    } failBlock:^(NSError *error) {
        if (reponseBlock) {
            reponseBlock(0, error);
        }
    } withIndicator:NO];
}

@end
