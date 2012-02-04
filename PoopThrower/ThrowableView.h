//
//  ThrowableView.h
//  
//
//  Created by Alex Nichol on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AcceleratingView.h"

@interface ThrowableView : AcceleratingView {
    CGPoint firstPoint;
    CGRect firstRect;
    
    CGPoint previousPoint;
    NSDate * previousDate;
    CGPoint lastPoint;
    NSDate * lastDate;
}

@end
