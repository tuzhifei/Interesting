//
//  AuthorTableViewCell.h
//  App
//
//  Created by Mark on 19/9/7.
//  Copyright © 2019年 Mark. All rights reserved.
//
// 
// 


#import <UIKit/UIKit.h>

@interface AuthorTableViewCell : UITableViewCell

// icon
@property (nonatomic, strong) UIImageView *iconImage;
// 作者
@property (nonatomic, strong) UILabel *authorLabel;
// 视频数量
@property (nonatomic, strong) UILabel *videoCount;
// 简介
@property (nonatomic, strong) UILabel *desLabel;


@end
