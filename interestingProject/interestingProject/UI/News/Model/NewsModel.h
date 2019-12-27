//
//  NewsModel.h
//  interestingProject
//
//  Created by mark on 2019/12/27.
//  Copyright © 2019 mark. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsModel : NSObject

@property(nonatomic, strong)NSString *dataType;
@property(nonatomic, strong)NSString *id;
@property(nonatomic, strong)NSArray <NSString *> *titleList;
@property(nonatomic, strong)NSString *backgroundImage;
@property(nonatomic, strong)NSString *actionUrl;

@end

NS_ASSUME_NONNULL_END
