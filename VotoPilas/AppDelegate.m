//
//  AppDelegate.m
//  VotoPilas
//
//  Created by Jose on 6/22/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "TheSidebarController/TheSidebarController.h"
#import "LeftSidebarViewController.h"
#import "RightSidebarViewController.h"
#import "globalVars.h"
#import <Parse/Parse.h>
#import "logInViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>

#import "ValoracionesViewController.h"

#import "politicianManager.h"







@interface AppDelegate ()

@end

@implementation AppDelegate{
    
    TheSidebarController *sidebarController;
    
    UINavigationController * loginnavigationController;
}


extern CGFloat navHeight;

extern bool didFinishLoading;




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    
    // Initialize the Chartboost library
    [Chartboost startWithAppId:@"55b66659c909a66b49cde050"
                  appSignature:@"deb37c31a280b7f0fc44db0bcf0f3d681a5384ab"
                      delegate:self];
    
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    //-----------------------------------DELEGATE
    
    // Override point for customization after application launch.
    [FBSDKLoginButton class];
    
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    //you will need to create your own parse repostiory
    
    [Parse setApplicationId:@"parseId"
                  clientKey:@"parseClient"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    
    //------------------------------------DELEGATE
    
      
    
    
    
    NSLog(@"Did finished launch");
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    

    ViewController * master = [[ViewController alloc]init];// creating the main viewcontroller
    
    
   /*
    logInViewController * login = [[logInViewController alloc]init];
    
    
    loginnavigationController = [[UINavigationController alloc]initWithRootViewController:login];// creating a navigation controller and attaching the first view controller to it*/
    
    UINavigationController * navigationController = [[UINavigationController alloc]initWithRootViewController:master];// creating a navigation controller and attaching the first view controller to it
    
    
    //-----------
    
    navHeight = navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height; ;
    
    
    LeftSidebarViewController *leftSidebarViewController = [[LeftSidebarViewController alloc] init];
    RightSidebarViewController *rightSidebarViewController = [[RightSidebarViewController alloc] init];
    
    sidebarController = [[TheSidebarController alloc] initWithContentViewController:navigationController
                                                                                leftSidebarViewController:leftSidebarViewController
                                                                               rightSidebarViewController:rightSidebarViewController];
    
    
    //-----------
    
    
    
    if (![PFUser currentUser]) {
        
               // show log in screen
        self.window.rootViewController = sidebarController;

    } else {
        // go straight to the app!
        self.window.rootViewController = sidebarController;// setting the navigation controller as the rootviewcontroller

       
    }
    
    //DEBUG
    
    ValoracionesViewController * valoraciones = [[ValoracionesViewController alloc]init];
   // self.window.rootViewController = valoraciones;
    
    
    
    //--------------------NOTIFICATION
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeRootNotificaion" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(omitirBoton)
     name:@"changeRootNotificaion"
     object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"logInNotification" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(loginAgain)
     name:@"logInNotification"
     object:nil];

    

    
    //-----------
    
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    
    
    [self.window makeKeyAndVisible];
    

    [PFFacebookUtils initializeFacebookWithApplicationLaunchOptions:launchOptions];

    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
    
    
}


-(void)omitirBoton{
    
    self.window.rootViewController = sidebarController;
    
    
}

-(void)loginAgain{
    
    //-------es necesario resetear bien la memoria para borrar las variables
    
    ViewController * master = [[ViewController alloc]init];// creating the main viewcontroller
    
    
    UINavigationController * navigationController = [[UINavigationController alloc]initWithRootViewController:master];// creating a navigation controller and attaching the first view controller to it
    
    navHeight = navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height; ;
    
    
    LeftSidebarViewController *leftSidebarViewController = [[LeftSidebarViewController alloc] init];
    RightSidebarViewController *rightSidebarViewController = [[RightSidebarViewController alloc] init];
    
    sidebarController = [[TheSidebarController alloc] initWithContentViewController:navigationController
                                                          leftSidebarViewController:leftSidebarViewController
                                                         rightSidebarViewController:rightSidebarViewController];
    
    

    
    NSLog(@"LOGGIN IN");
    
    
    logInViewController * login = [[logInViewController alloc]init];
    
    loginnavigationController = [[UINavigationController alloc]initWithRootViewController:login];// creating a navigation controller and attaching the first view controller to it

    

    
    self.window.rootViewController = loginnavigationController;
    
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
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
 
    [FBSDKAppEvents activateApp];
    
    //[politicianManager downloadPoliticiansAllParts:<#(NSMutableArray *)#>];
    
    NSLog(@"APP ACTIVATE");
    

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
