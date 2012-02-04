//
//  AppDelegate.h
//  PoopThrower
//
//  Created by Alex Nichol on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PoopView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSTimer * timer;
    PoopView * poop;
}

@property (nonatomic, retain) UIWindow * window;
@property (nonatomic, retain) UIViewController * viewController;

- (void)animationTimer;

@end
