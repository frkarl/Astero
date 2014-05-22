//
//  FKSpring.h
//  Asteroid
//
//  Created by Fredrik on 21/05/14.
//  Copyright (c) 2014 Fredrik K. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "FKPoint.h"
//#import "CGVectorAdditions.h"

@interface FKSpring : NSObject

@property FKPoint *point1;
@property FKPoint *point2;
@property CGFloat targetLength;
@property CGFloat stiffness;
@property CGFloat damping;

- (id)initWithPoint1:(FKPoint*) point1 andPoint2:(FKPoint*) point2 andStiffness:(CGFloat) stiffness andDampnig:(CGFloat) damping;
- (void)update;

@end
