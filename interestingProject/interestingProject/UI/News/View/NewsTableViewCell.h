//
//  NewsTableViewCell.h
//  interestingProject
//
//  Created by mark on 2019/12/27.
//  Copyright © 2019 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class NewsModel;
@interface NewsTableViewCell : UITableViewCell

- (void)configWithModel:(NewsModel *)model;

@end

NS_ASSUME_NONNULL_END
