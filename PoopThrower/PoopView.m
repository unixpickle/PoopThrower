//
//  PoopView.m
//  PoopThrower
//
//  Created by Alex Nichol on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PoopView.h"

@implementation PoopView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        poopImage = [[UIImage imageNamed:@"poop.png"] retain];
        // Initialization code
    }
    return self;
}

- (void)dealloc {
    [poopImage release];
    [super dealloc];
}

- (void)drawRect:(CGRect)rect {
    [poopImage drawInRect:self.bounds];
}


@end
