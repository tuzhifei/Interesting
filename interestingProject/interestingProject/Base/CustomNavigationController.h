//
//  CustomNavigationController.h
//  CustomTransitions
//
//  Created by Mark on 19/9/29.
//  Copyright © 2019年 Mark. All rights reserved.
//
// 
// 


#import <UIKit/UIKit.h>

@interface CustomWrapViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

+ (CustomWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;

@end

@interface CustomNavigationController : UINavigationController

@property (nonatomic, strong) UIImage *backButtonImage;

@property (nonatomic, assign) BOOL fullScreenPopGestureEnabled;

@property (nonatomic, copy, readonly) NSArray *Custom_viewControllers;

@end
