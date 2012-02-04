//
//  AcceleratingView.h
//  PoopThrower
//
//  Created by Alex Nichol on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

CGFloat Motion(NSTimeInterval time,
               CGFloat friction,
               CGFloat * velInOut);

CGFloat EdgeBounce(CGFloat wallDistance, 
                   CGFloat velocity,
                   CGFloat friction,
                   NSTimeInterval time,
                   CGFloat * velocityOut,
                   NSTimeInterval * hitTimeOut);

@interface AcceleratingView : UIView {
    CGFloat friction;
    CGPoint velocity;
    NSDate * lastTime;
}

@property (readwrite) CGPoint velocity;
@property (readwrite) CGFloat friction;

- (void)resetMotion;
- (CGPoint)pointSinceLastDate:(CGPoint)viewPoint bounds:(CGRect)container;
- (BOOL)isMoving;

@end
