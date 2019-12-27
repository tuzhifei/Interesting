//
//  PubliceObject.m
//  router
//
//  Created by mark on 2019/6/14.
//  Copyright © 2019 Wireless Department. All rights reserved.
//

#import "PubliceObject.h"
#define DSIsNULL(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) || ([(_ref) isKindOfClass:[NSNull class]]) )
@implementation PubliceObject

+ (void)beginReFreshControl:(UIScrollView *)model
                   onHeader:(MJRefreshComponentRefreshingBlock)headerBlock
                   onFooter:(MJRefreshComponentRefreshingBlock)footerBlock{
    if (!DSIsNULL(model) && !DSIsNULL(headerBlock)) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:headerBlock];
        header.automaticallyChangeAlpha = YES;
        header.lastUpdatedTimeLabel.hidden = YES;
        model.mj_header = header;
    }
    if (!DSIsNULL(model) && !DSIsNULL(footerBlock)) {
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:footerBlock];
        footer.automaticallyChangeAlpha = YES;
        model.mj_footer = footer;
    }
}

+ (void)endRefreshControl:(UIScrollView *)srollView {
    if (srollView.mj_header.isRefreshing) {
        [srollView.mj_header endRefreshing];
    }
    if (srollView.mj_footer.isRefreshing) {
        [srollView.mj_footer endRefreshing];
    }
}

@end
