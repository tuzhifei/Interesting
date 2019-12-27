//
//  AuthorModel.m
//  App
//
//  Created by Mark on 19/9/7.
//  Copyright © 2019年 Mark. All rights reserved.
//
// 
// 


#import "AuthorModel.h"

@implementation AuthorModel

+ (instancetype)tgWithDict:(NSDictionary *)dict
{
    AuthorModel *author = [[self alloc] init];
    [author setValuesForKeysWithDictionary:dict];
    return author;
}

@end
