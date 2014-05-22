//
//  FKPoint.h
//  Asteroid
//
//  Created by Fredrik on 21/05/14.
//  Copyright (c) 2014 Fredrik K. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface FKPoint : SKSpriteNode

@property CGFloat mass;

- (id)initWithPosition:(CGPoint) position andMass:(CGFloat) mass;
- (void)applyForce:(CGVector) force;
- (void)increaseDampingByFactor:(CGFloat) factor;
- (void)update;

@end
