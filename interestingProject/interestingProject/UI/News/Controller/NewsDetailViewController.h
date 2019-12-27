//
//  NewsDetailViewController.h
//  interestingProject
//
//  Created by mark on 2019/12/27.
//  Copyright © 2019 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class NewsModel;
@interface NewsDetailViewController : UIViewController

@property(nonatomic, strong)NewsModel *selectModel;

@end

NS_ASSUME_NONNULL_END
