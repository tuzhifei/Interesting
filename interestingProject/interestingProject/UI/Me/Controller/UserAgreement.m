//
//  UserAgreement.m
//  App
//
//  Created by Mark on 16/10/3.
//  Copyright © 2019年 Mark. All rights reserved.
//

#import "UserAgreement.h"
#import <WebKit/WebKit.h>
@interface UserAgreement ()<WKNavigationDelegate,WKUIDelegate>

@end

@implementation UserAgreement

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getData];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 30, 30)];
    [btn setBackgroundImage:[UIImage imageNamed:@"audio_AD_close"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)getData{
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, kAppNavHeight, ScreenWidth, ScreenHeight - kAppNavHeight)];
    webView.backgroundColor = [UIColor whiteColor];
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    webView.scrollView.bounces = NO;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"service_terms_chs.html" ofType:nil];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
    [self.view addSubview:webView];
}

- (void)btnClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
