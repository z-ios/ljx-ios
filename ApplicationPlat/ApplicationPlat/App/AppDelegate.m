//
//  AppDelegate.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/8/27.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "AppDelegate.h"
#import "SelectLanguageController.h"
#import "LoginController.h"
#import "AppTool.h"
#import "NewBreakerController.h"
#import "DeatilViewController.h"
#import "TabController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if (@available(iOS 13,*)) {
        
    }else{
        [self initWindow];
        
        AppTool *appTools = [[AppTool alloc]init];
        [appTools archiveTool];
        
    }
    
    return YES;
}

- (void)initWindow
{
    SelectLanguageController *loginVC = [[SelectLanguageController alloc]init];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"base_url"] && [[NSUserDefaults standardUserDefaults]objectForKey:@"domain_ip"]) {
        loginVC.selectIndex = @"1";
    }else{
        loginVC.selectIndex = @"0";
        
    }
    self.window = [[UIWindow alloc]initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = loginVC;
    [self.window makeKeyAndVisible];
    
}
#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"离开=======1=========1");
    NSLog(@"离开=======6=========%@",[self currentViewController]);
    
    
    if ([[self currentViewController] isKindOfClass:[NewBreakerController class]]) {
        NSLog(@"离开=======3=========%@",[self currentViewController]);
        NSNotification *notification = [NSNotification notificationWithName:@"notification"object:nil userInfo:@{@"key":@"background"}];
        [[NSNotificationCenter defaultCenter]postNotification:notification];
    }
    
    if ([[self currentViewController] isKindOfClass:[DeatilViewController class]]) {
        NSLog(@"离开=======4=========%@",[self currentViewController]);
        NSNotification *notification = [NSNotification notificationWithName:@"notificationChild"object:nil userInfo:@{@"key":@"background"}];
        [[NSNotificationCenter defaultCenter]postNotification:notification];
        
    }
}

- (void)applicationWillEnterForeground:(UIApplication*)application{
    
    NSLog(@"进入=======1=========1");
    NSLog(@"进入=======6=========%@",[self currentViewController]);
    if ([[self currentViewController] isKindOfClass:[NewBreakerController class]]) {
        NSLog(@"进入=======3=========%@",[self currentViewController]);
        NSNotification *notification = [NSNotification notificationWithName:@"notification"object:nil userInfo:@{@"key":@"foreground"}];
        [[NSNotificationCenter defaultCenter]postNotification:notification];
    }
    if ([[self currentViewController] isKindOfClass:[DeatilViewController class]]) {
        NSLog(@"进入=======4=========%@",[self currentViewController]);
        NSNotification *notification = [NSNotification notificationWithName:@"notificationChild"object:nil userInfo:@{@"key":@"foreground"}];
        [[NSNotificationCenter defaultCenter]postNotification:notification];
    }
    
}
-(UIViewController*) findBestViewController:(UIViewController*)vc {
    
    if (vc.presentedViewController) {
        
        // Return presented view controller
        return [self findBestViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.topViewController];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.selectedViewController];
        else
            return vc;
        
    } else {
        
        // Unknown view controller type, return last child view controller
        return vc;
        
    }
    
}

-(UIViewController*) currentViewController {
    
    // Find best view controller
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self findBestViewController:viewController];
    
}
@end
