//
//  AppDelegate.m
//  xiaoHongShu
//
//  Created by 陈家劲 on 16/5/30.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "AppDelegate.h"
#import "MyVC.h"
#import "FindVC.h"
#import "HomeVC.h"
#import "NewVC.h"


/**
 Unknown class ViewController in Interface Builder file.
 */

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //设置视图控制器
    [self VCs];
    return YES;
}


#pragma mark- 设置视图控制器
-(void)VCs
{
//    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    
//    [self.window makeKeyAndVisible];
    
    
    HomeVC *VC1 = [[HomeVC alloc]init];
    [VC1.view setBackgroundColor:[UIColor whiteColor]];
   UITabBarItem * item = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"add_chefs"] selectedImage:[UIImage imageNamed:@"add_chefs"]];
    VC1.tabBarItem = item;
    VC1.title = @"首页";
    UINavigationController *NVC1 = [[UINavigationController alloc]initWithRootViewController:VC1];


    UINavigationController *NVC2 = [[UINavigationController alloc]init];
    FindVC *VC2 = [[FindVC alloc]initWithNavigationController:NVC2];
    [NVC2 pushViewController:VC2 animated:YES];

    item = [[UITabBarItem alloc]initWithTitle:@"发现" image:[UIImage imageNamed:@"add_chefs"] selectedImage:[UIImage imageNamed:@"add_chefs"]];
    
        VC2.tabBarItem = item;
  
//    UINavigationController *NVC2 = [[UINavigationController alloc]initWithRootViewController:VC2];
    
    NewVC *VC3 = [[NewVC alloc]init];
    item = [[UITabBarItem alloc]initWithTitle:@"消息" image:[UIImage imageNamed:@"add_chefs"] selectedImage:[UIImage imageNamed:@"add_chefs"]];
    VC3.tabBarItem = item;
    UINavigationController *NVC3 = [[UINavigationController alloc]initWithRootViewController:VC3];
    
    MyVC *VC4 = [[MyVC alloc]init];
    item = [[UITabBarItem alloc]initWithTitle:@"我" image:[UIImage imageNamed:@"add_chefs"] selectedImage:[UIImage imageNamed:@"add_chefs"]];
   VC4.tabBarItem = item;
    UINavigationController *NVC4 = [[UINavigationController alloc]initWithRootViewController:VC4];
    
    
    UIViewController *VC5 = [[NSBundle mainBundle]loadNibNamed:@"ShopVC" owner:self options:nil][0];
//    item = [[UITabBarItem alloc]initWithTitle:@"购买" image:[UIImage imageNamed:@"add_chefs"] selectedImage:[UIImage imageNamed:@"add_chefs"]];
    VC5.tabBarItem = item;
    UINavigationController *NVC5 = [[UINavigationController alloc]initWithRootViewController:VC5];
    
    
    
    self.tabBarVC = [[UITabBarController alloc]init];
    [self.tabBarVC setViewControllers:@[NVC1,NVC2,NVC5,NVC3,NVC4,] animated:YES];
    
    self.window.rootViewController = self.tabBarVC;
    


}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "cn.jiajin.xiaoHongShu" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"xiaoHongShu" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"xiaoHongShu.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
