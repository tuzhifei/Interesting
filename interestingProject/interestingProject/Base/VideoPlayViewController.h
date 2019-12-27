//
//  VideoPlayViewController.h
//  App
//
//  Created by Mark on 19/9/7.
//  Copyright © 2019年 Mark. All rights reserved.
//
// 
// 


#import <UIKit/UIKit.h>

@interface VideoPlayViewController : UIViewController

// 视频地址
@property(nonatomic,strong) NSString *UrlString;
// 视频标题
@property(nonatomic,strong) NSString *titleStr;
// 视频时长
@property(nonatomic, assign) double duration;

@end
