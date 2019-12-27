//
//  AuthorModel.h
//  App
//
//  Created by Mark on 19/9/7.
//  Copyright © 2019年 Mark. All rights reserved.
//
// 
// 


#import <Foundation/Foundation.h>

@interface AuthorModel : NSObject

// icon
@property (nonatomic, copy) NSString *iconImage;
// 作者
@property (nonatomic, copy) NSString *authorLabel;
// 视频数量
@property (nonatomic, copy) NSString *videoCount;
// 简介
@property (nonatomic, copy) NSString *desLabel;
// ID
@property (nonatomic, copy) NSString *authorId;
// actionUrl
@property (nonatomic, copy) NSString *actionUrl;

+ (instancetype)tgWithDict:(NSDictionary *)dict;

@end
