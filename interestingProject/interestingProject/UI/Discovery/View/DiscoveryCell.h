//
//  DiscoveryCell.h
//  App
//
//  Created by Mark on 19/9/7.
//  Copyright © 2019年 Mark. All rights reserved.
//
// 
// 


#import <UIKit/UIKit.h>

@interface DiscoveryCell : UICollectionViewCell

/** 图片 */
@property (nonatomic, strong) UIImageView *ImageView;

@property (nonatomic, strong) UIImageView *shadeView;

/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;

@end
