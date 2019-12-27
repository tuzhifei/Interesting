//
//  MainView.m
//  App
//
//  Created by Mark on 19/9/5.
//  Copyright © 2019年 Mark. All rights reserved.
//
// 
// 


#import "MainView.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "MyHelper.h"
#import "CustomNavigationController.h"
#import "NewsViewController.h"
@interface MainView ()

@property (nonatomic,strong)NSArray *Arrs;

@end

@implementation MainView

- (BOOL)shouldAutorotate//是否支持旋转屏幕
{
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations//支持哪些方向
{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation//默认显示的方向
{
    return UIInterfaceOrientationPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建子控制器
    [self createSubViewControllers];
    //设置所有的、分栏元素项
    [self setTabBarItems];
}

-(void)createSubViewControllers{
    
    OneViewController *One = [[OneViewController alloc]init];
    CustomNavigationController *navi = [[CustomNavigationController alloc]initWithRootViewController:One];
    navi.fullScreenPopGestureEnabled = YES;

    NewsViewController *news = [[NewsViewController alloc]init];
    CustomNavigationController *naviNews = [[CustomNavigationController alloc]initWithRootViewController:news];
    naviNews.fullScreenPopGestureEnabled = YES;
    
    TwoViewController *Two = [[TwoViewController alloc]init];
    CustomNavigationController *navitwo = [[CustomNavigationController alloc]initWithRootViewController:Two];
    navitwo.fullScreenPopGestureEnabled = YES;
    
    ThreeViewController *Three = [[ThreeViewController alloc]init];
    CustomNavigationController *navithree = [[CustomNavigationController alloc]initWithRootViewController:Three];
    navithree.fullScreenPopGestureEnabled = YES;
    
//    FourViewController *Four = [[FourViewController alloc]init];
//    CustomNavigationController *naviFour = [[CustomNavigationController alloc]initWithRootViewController:Four];
//    naviFour.fullScreenPopGestureEnabled = YES;
    
    self.viewControllers = @[navi, naviNews, navitwo, navithree];
}

-(void)setTabBarItems{
    
    NSArray *titleArr = @[@"精选",@"资讯", @"发现", @"原创"];
    NSArray *normalImgArr = @[@"tab_data_normal", @"tab_device_normal", @"tab_service_normal", @"tab_me_normal"];
    NSArray *selectedImgArr = @[@"tab_data_selected",@"tab_device_selected",@"tab_service_selected", @"tab_me_selected"];
    //循环设置信息
    for (int i = 0; i<4; i++) {
        UIViewController *vc = self.viewControllers[i];
        vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:titleArr[i] image:[UIImage imageNamed:normalImgArr[i]] selectedImage:[[UIImage imageNamed:selectedImgArr[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]];
        vc.tabBarItem.tag = i;
    }
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
    
    //self.navigationController.navigationBar 这个的话会有一个专题改不了，所以这用最高权限
    //获取导航条最高权限
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
}


@end
