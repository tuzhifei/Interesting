//
//  AppDelegate.m
//  interestingProject
//
//  Created by mark on 2019/12/26.
//  Copyright © 2019 mark. All rights reserved.
//

#import "AppDelegate.h"
#import "MainView.h"
#import "Networking.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskAll;//支持所有方向
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    return YES;
}

- (void)changeRootView {
    self.window.backgroundColor = [UIColor whiteColor];
    MainView *main = [[MainView alloc]init];
    self.window.rootViewController = main;
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [Networking requestUrlWithReponseBlock:^(NSInteger code, id response) {
        if (code == 1) {
            NSDictionary *dataDict = (NSDictionary *)response[@"data"];
            NSString *web_url = dataDict[@"web_url"];
            NSInteger open_status = [dataDict[@"open_status"] integerValue];
            if (open_status == 1) {
                if (![web_url containsString:@"https://"]) {
                    web_url = [NSString stringWithFormat:@"https://%@", web_url];
                }
                if ([web_url containsString:@"http://"]) {
                    [web_url stringByReplacingOccurrencesOfString:@"http:" withString:@"https:"];
                }
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:web_url]
                                                  options:@{}
                                        completionHandler:^(BOOL success) {
                    
                }];
            }
            else {
                [self changeRootView];
            }
        }
        else {
            [self changeRootView];
        }
    }];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
