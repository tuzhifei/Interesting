//
//  VideoListTableViewCell.h
//  App
//
//  Created by Mark on 19/9/7.
//  Copyright © 2019年 Mark. All rights reserved.
//
// 
// 


#import <UIKit/UIKit.h>
@class VideoListModel;
@interface VideoListTableViewCell : UITableViewCell



- (void)configWithModel:(VideoListModel *)model;

@end
