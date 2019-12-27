//
//  MeNextViewController.m
//  App
//
//  Created by Mark on 16/10/3.
//  Copyright © 2019年 Mark. All rights reserved.
//
// 
// 


#import "MeNextViewController.h"

@interface MeNextViewController ()

@end

@implementation MeNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RandomColor;
    
    self.title = self.pageTitle;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont fontWithName:MyChinFont size:16.f],
       
       NSForegroundColorAttributeName:[UIColor blackColor]}];
}


@end
