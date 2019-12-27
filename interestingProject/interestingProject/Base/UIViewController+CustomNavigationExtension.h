//
//  UIViewController+CustomNavigationExtension.h
//  CustomTransitions
//
//  Created by Mark on 19/9/29.
//  Copyright © 2019年 Mark. All rights reserved.
//
// 
// 


#import <UIKit/UIKit.h>
#import "CustomNavigationController.h"

@interface UIViewController (CustomNavigationExtension)

@property (nonatomic, assign) BOOL Custom_fullScreenPopGestureEnabled;

@property (nonatomic, weak) CustomNavigationController *Custom_navigationController;

@end
