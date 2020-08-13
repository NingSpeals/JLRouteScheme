//
//  AppDelegate.m
//  JLRouteScheme
//
//  Created by Ning on 2019/10/17.
//  Copyright © 2019 Ning. All rights reserved.
//

#import "AppDelegate.h"
#import <JLRoutes.h>
#import <objc/runtime.h>
//#import "AppDelegate+RegisterRoute.h"
#import <JLRoutes.h>
#import <objc/runtime.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
     [self registerRoute];
    return YES;
}

- (void)registerRoute{
    
    [self registerRouteWithScheme:@"RouteOne"];
    
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    
    return [[JLRoutes routesForScheme:@"RouteOne"]routeURL:url];
}
- (void)registerRouteWithScheme:(NSString *)scheme{
    //RouteOne://push/FirstNextViewController
    [[JLRoutes routesForScheme:scheme] addRoute:@"/push/:controller"handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        Class class = NSClassFromString(parameters[@"controller"]);
        
        UIViewController *nextVC = [[class alloc] init];
        
        [self paramToVc:nextVC param:parameters];
        UIViewController *currentVc = [self currentViewController];
        [currentVc.navigationController pushViewController:nextVC animated:YES];
        return YES;
    }];
}
//确定是哪个viewcontroller
-(UIViewController *)currentViewController{
    
    UIViewController * currVC = nil;
    UIViewController * Rootvc = self.window.rootViewController ;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (Rootvc!=nil);
    
    return currVC;
}
//传参数
-(void)paramToVc:(UIViewController *) v param:(NSDictionary<NSString *,NSString *> *)parameters{
    //        runtime将参数传递至需要跳转的控制器
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(v.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *param = parameters[key];
        if (param != nil) {
            [v setValue:param forKey:key];
        }
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
