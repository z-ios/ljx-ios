//
//  SceneDelegate.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/8/27.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "SceneDelegate.h"
#import "SelectLanguageController.h"
#import "LoginController.h"
#import "AppTool.h"
#import "NewBreakerController.h"
#import "TabController.h"
#import "DeatilViewController.h"
@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions  API_AVAILABLE(ios(13.0)){
    [self initWindow];
    
    AppTool *appTools = [[AppTool alloc]init];
    [appTools archiveTool];
}

- (void)initWindow
{
    SelectLanguageController *loginVC = [[SelectLanguageController alloc]init];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"base_url"] && [[NSUserDefaults standardUserDefaults]objectForKey:@"domain_ip"]) {
        loginVC.selectIndex = @"1";
    }else{
        loginVC.selectIndex = @"0";
        
    }
    self.window.rootViewController = loginVC;
    [self.window makeKeyAndVisible];
    
}
- (void)sceneDidDisconnect:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
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


- (void)sceneDidEnterBackground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
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
