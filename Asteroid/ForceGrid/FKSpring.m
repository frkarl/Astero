//
//  FKSpring.m
//  Asteroid
//
//  Created by Fredrik on 21/05/14.
//  Copyright (c) 2014 Fredrik K. All rights reserved.
//

#import "FKSpring.h"


@implementation FKSpring

- (id)initWithPoint1:(FKPoint*) point1 andPoint2:(FKPoint*) point2 andStiffness:(CGFloat) stiffness andDampnig:(CGFloat) damping {
    self = [super init];
    if (self) {
        self.point1 = point1;
        self.point2 = point2;
        self.stiffness = stiffness;
        self.damping = damping;
        //self.targetLength = CGVectorDistance(point1.position,point2.position) * 0.95;
    }
    return self;
}

- (void)update {
    
}

@end
