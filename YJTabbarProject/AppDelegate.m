//
//  AppDelegate.m
//  YJTabbarProject
//
//  Created by hnzc on 16/6/15.
//  Copyright © 2016年 YuJay. All rights reserved.
//

#import "AppDelegate.h"
#import "mainTabViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    mainTabViewController *tab=[[mainTabViewController alloc] init];
    UIViewController *v1=[[UIViewController alloc] init];
    v1.view.backgroundColor=[UIColor colorWithRed:0.832 green:1.000 blue:0.250 alpha:1.000];
    v1.title=@"第一个";
    
    UIViewController *v2=[[UIViewController alloc] init];
    v2.view.backgroundColor=[UIColor colorWithRed:0.301 green:0.661 blue:1.000 alpha:1.000];
    v2.title=@"第二个";
    
    UIViewController *v3=[[UIViewController alloc] init];
    v3.view.backgroundColor=[UIColor colorWithRed:1.000 green:0.572 blue:0.600 alpha:1.000];
    v3.title=@"第三个";
    
    
    UIViewController *v4=[[UIViewController alloc] init];
    v4.view.backgroundColor=[UIColor colorWithRed:0.574 green:0.314 blue:1.000 alpha:1.000];
    v4.title=@"第四个 导航栏";
    
    //支持超过4个vc的导航
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:v4];
    
    tab.viewControllers=[[NSMutableArray alloc] initWithObjects:v1,v2,v3,nav,nil];
    for (int i=0; i<4; i++) {
        UIViewController *vv=[[UIViewController alloc] init];
        vv.view.backgroundColor=[UIColor colorWithRed:1.000 green:0.029 blue:0.988 alpha:1.000];
        vv.title=[NSString stringWithFormat:@"第%d个",i+5];
        [tab.viewControllers addObject:vv];
    }
    tab.enableTapAnimation=YES;
    tab.bumpHeigh=20;
    tab.CenterImage=[UIImage imageNamed:@"扫一扫"];
    NSMutableArray *normalImage=[[NSMutableArray alloc] init];
    for (int i=0; i<8; i++) {
        [normalImage addObject:[UIImage imageNamed:@"qr"]];
    }
    tab.normalImages=normalImage;
    tab.selectedImages=normalImage;
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController=tab;
    [self.window makeKeyAndVisible];
    
    return YES;
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
