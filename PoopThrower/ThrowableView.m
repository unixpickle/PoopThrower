//
//  ThrowableView.m
//  
//
//  Created by Alex Nichol on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ThrowableView.h"

@implementation ThrowableView

- (void)dealloc {
    [previousDate release];
    [lastDate release];
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    firstPoint = [[touches anyObject] locationInView:self.superview];
    firstRect = self.frame;
    self.velocity = CGPointZero;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [previousDate release];
    previousDate = lastDate;
    previousPoint = lastPoint;
    lastDate = [[NSDate date] retain];
    lastPoint = [[touches anyObject] locationInView:self.superview];
    
    CGRect newRect = firstRect;
    newRect.origin.x += lastPoint.x - firstPoint.x;
    newRect.origin.y += lastPoint.y - firstPoint.y;
    [self setFrame:newRect];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:previousDate];
    CGPoint movement = CGPointMake(lastPoint.x - previousPoint.x, lastPoint.y - previousPoint.y);
    if (movement.x == 0 && movement.y == 0) return;
    movement.x /= time;
    movement.y /= time;
    
    float angle = atan2f(movement.y, movement.x);
    float scale = movement.x / cosf(angle);
    if (isnan(scale)) scale = movement.y / sinf(angle);
    if (scale > 500) scale = 500;
    self.velocity = CGPointMake(cosf(angle) * scale, sinf(angle) * scale);
    [self resetMotion];
}

@end
