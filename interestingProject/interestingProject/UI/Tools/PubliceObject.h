//
//  PubliceObject.h
//  router
//
//  Created by mark on 2019/6/14.
//  Copyright © 2019 Wireless Department. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PubliceObject : NSObject

+ (void)beginReFreshControl:(UIScrollView *)model
                   onHeader:(MJRefreshComponentRefreshingBlock)headerBlock
                   onFooter:(MJRefreshComponentRefreshingBlock)footerBlock;

+ (void)endRefreshControl:(UIScrollView *)srollView;

@end

NS_ASSUME_NONNULL_END
