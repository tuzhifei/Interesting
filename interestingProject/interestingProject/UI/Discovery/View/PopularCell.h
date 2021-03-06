//
//  PopularCell.h
//  App
//
//  Created by Mark on 19/9/30.
//  Copyright © 2019年 Mark. All rights reserved.
//
// 
// 


#import <UIKit/UIKit.h>

@interface PopularCell : UITableViewCell

/** 图片 */
@property (nonatomic, weak) UIImageView *ImageView;

@property (nonatomic, weak) UIImageView *shadeView;

/** 标题 */
@property (nonatomic, weak) UILabel *titleLabel;

/** Message */
@property (nonatomic, weak) UILabel *messageLabel;

@property (nonatomic, weak) UILabel *indexLabel;

@property (nonatomic, weak) UIButton *topLine;

@property (nonatomic, weak) UIButton *bottomLine;

@end
