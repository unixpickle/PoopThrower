//
//  AppDelegate.m
//  PoopThrower
//
//  Created by Alex Nichol on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = viewController;

- (void)dealloc {
    [_window release];
    [viewController release];
    [poop release];
    [timer invalidate];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    self.viewController = [[UIViewController alloc] init];
    poop = [[PoopView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    [poop setVelocity:CGPointMake(200, 200)];
    [poop setFriction:100];
    timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 60.0) target:self
                                           selector:@selector(animationTimer)
                                           userInfo:nil repeats:YES];
    
    [self.viewController.view addSubview:poop];
    [self.window addSubview:self.viewController.view];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)animationTimer {
    CGPoint center = [poop center];
    CGRect viewBounds = CGRectMake(25, 25, 320 - 50, 460 - 50);
    CGPoint center2 = [poop pointSinceLastDate:center bounds:viewBounds];
    [poop setCenter:center2];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
