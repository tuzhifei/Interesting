//
//  NewsDetailViewController.m
//  interestingProject
//
//  Created by mark on 2019/12/27.
//  Copyright © 2019 mark. All rights reserved.
//

#import "NewsDetailViewController.h"
#import <WebKit/WebKit.h>
#import "NewsModel.h"
@interface NewsDetailViewController ()<UINavigationControllerDelegate,WKNavigationDelegate,WKUIDelegate>

@property(nonatomic, strong)WKWebView *webView;

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];
    [self.navigationItem setTitle:@"资讯"];
    [self.view addSubview:self.webView];
    NSURL *url = [NSURL URLWithString:self.selectModel.actionUrl];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (WKWebView *)webView {
    if (_webView == nil) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, kAppNavHeight, kScreenWidth, kScreenHeight - kAppNavHeight - kSafeAreaBottom)];
        _webView.scrollView.bounces = NO;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    return _webView;
}


@end
