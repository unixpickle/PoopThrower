//
//  AcceleratingView.m
//  PoopThrower
//
//  Created by Alex Nichol on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AcceleratingView.h"

@implementation AcceleratingView

@synthesize velocity;
@synthesize friction;

- (void)resetMotion {
    [lastTime release];
    lastTime = nil;
}

- (CGPoint)pointSinceLastDate:(CGPoint)viewPoint bounds:(CGRect)container {
    if (!lastTime) {
        [lastTime release];
        lastTime = [[NSDate date] retain];
        return viewPoint;
    }
    
    NSDate * now = [NSDate date];
    NSTimeInterval elapsed = [now timeIntervalSinceDate:lastTime];
    [lastTime release];
    lastTime = [now retain];
        
    CGPoint motion = CGPointZero;
    
    CGFloat maxX = CGRectGetMaxX(container);
    CGFloat minX = CGRectGetMinX(container);
    CGFloat maxY = CGRectGetMaxY(container);
    CGFloat minY = CGRectGetMinY(container);
    
    float angle = atan2f(velocity.y, velocity.x);
    float fricX = ABS(friction * cosf(angle));
    float fricY = ABS(friction * sinf(angle));
    
    motion.x = Motion(elapsed, fricX, &velocity.x);
    motion.y = Motion(elapsed, fricY, &velocity.y);
    
    if (viewPoint.x < minX) viewPoint.x = minX;
    if (viewPoint.x > maxX) viewPoint.x = maxX;
    if (viewPoint.y < minY) viewPoint.y = minY;
    if (viewPoint.y > maxY) viewPoint.y = maxY;

    // logic for bouncing off walls
    
    while (viewPoint.x + motion.x > maxX || viewPoint.x + motion.x < minX) {
        if (motion.x > 0) {
            if (viewPoint.x + motion.x > maxX) {
                CGFloat newVel = 0;
                motion.x = -EdgeBounce(maxX - viewPoint.x, ABS(velocity.x), fricX, elapsed, &newVel, NULL);
                velocity.x = -newVel;
            }
        } else if (motion.x < 0) {
            if (viewPoint.x + motion.x < minX) {
                CGFloat newVel = 0;
                motion.x = EdgeBounce(viewPoint.x - minX, ABS(velocity.x), fricX, elapsed, &newVel, NULL);
                velocity.x = newVel;
            }
        }
    }
    
    while (viewPoint.y + motion.y > maxY || viewPoint.y + motion.y < minY) {
        if (motion.y > 0) {
            if (viewPoint.y + motion.y > maxY) {
                CGFloat newVel = 0;
                motion.y = -EdgeBounce(maxY - viewPoint.y, ABS(velocity.y), fricY, elapsed, &newVel, NULL);
                velocity.y = -newVel;
            }
        } else if (motion.y < 0) {
            if (viewPoint.y + motion.y < minY) {
                CGFloat newVel = 0;
                motion.y = EdgeBounce(viewPoint.y - minY, ABS(velocity.y), fricY, elapsed, &newVel, NULL);
                velocity.y = newVel;
            }
        }
    }
    
    return CGPointMake(viewPoint.x + motion.x, viewPoint.y + motion.y);
}

- (BOOL)isMoving {
    if (ABS(velocity.x) != 0 || ABS(velocity.y) != 0) {
        return YES;
    }
    return NO;
}

- (void)dealloc {
    [lastTime release];
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

CGFloat Motion(NSTimeInterval time,
               CGFloat friction,
               CGFloat * velInOut) {
    CGFloat fricDist = (friction * pow(time, 2)) / 2.0;
    CGFloat velDist = *velInOut * time;
    CGFloat motion = 0;
    
    if (ABS(velDist) >= ABS(fricDist)) {
        if (velDist > 0) {
            motion = velDist + fricDist;
        } else {
            motion = velDist - fricDist;
        }
        if (*velInOut > 0) *velInOut -= friction * time;
        else *velInOut += friction * time;
    } else {
        NSTimeInterval timeToDone = *velInOut / friction;
        CGFloat fricDist = (friction * pow(timeToDone, 2)) / 2.0;
        CGFloat velDist = *velInOut * timeToDone;
        if (velDist < 0) {
            motion = velDist + fricDist;
        } else {
            motion = velDist - fricDist;
        }
        *velInOut = 0;
    }
    
    return motion;
}

CGFloat EdgeBounce(CGFloat wallDistance, 
                   CGFloat velocity,
                   CGFloat friction,
                   NSTimeInterval time,
                   CGFloat * velocityOut,
                   NSTimeInterval * hitTimeOut) {
    NSTimeInterval hitTime = (-velocity + sqrt(pow(velocity, 2) - 2.0 * (friction * wallDistance))) / -friction;
    if (hitTimeOut) *hitTimeOut = hitTime;
    
    CGFloat totalFricDist = (friction * pow(time, 2)) / 2.0;
    CGFloat totalVelDist = velocity * time;
    CGFloat totalDist = totalVelDist - totalFricDist;
    
    if (velocityOut) *velocityOut = velocity - (friction * time);
    
    return totalDist - wallDistance;
}
