//
//  VideoListModel.h
//  App
//
//  Created by Mark on 19/9/29.
//  Copyright © 2019年 Mark. All rights reserved.
//
// 
// 


#import <Foundation/Foundation.h>

@interface VideoListModel : NSObject

/** 图片 */
@property (nonatomic, copy) NSString *ImageView;

@property (nonatomic, copy) NSString *shadeView;

/** 标题 */
@property (nonatomic, copy) NSString *titleLabel;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *duration;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSDictionary *consumption;

@property (nonatomic, copy) NSString *playUrl;

@property (nonatomic, copy) NSString *actionUrl;

@property (nonatomic, copy) NSString *idStr;

@property(nonatomic, strong) NSString *authorIcon;
@property(nonatomic, strong) NSString *authorName;


@end
