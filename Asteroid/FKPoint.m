//
//  FKPoint.m
//  Asteroid
//
//  Created by Fredrik on 21/05/14.
//  Copyright (c) 2014 Fredrik K. All rights reserved.
//

#import "FKPoint.h"

@implementation FKPoint

- (id)initWithPosition:(CGPoint) position mass:(CGFloat) mass isStatic:(BOOL) isStatic {
    self = [super init];
    if (self) {
        self.mass = mass;
        //self.color = [UIColor blueColor];
        self.position = position;
        //self.size=CGSizeMake(4, 4);
        //self.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 4, 4)].CGPath;
        //self.fillColor = [UIColor blueColor];
        //self.strokeColor = [UIColor blueColor];
        self.zPosition = -1;
        
        if (isStatic) {
            self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        } else {
            self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(4, 4)];
        }
        
        self.physicsBody.categoryBitMask = 0;
        self.physicsBody.collisionBitMask = 0;
        self.physicsBody.contactTestBitMask = 0;
        self.physicsBody.usesPreciseCollisionDetection = NO;
        self.physicsBody.mass = mass;
        self.physicsBody.linearDamping = 0.6;
        self.physicsBody.angularDamping = 0.6;
        //circle.glowWidth = 5;
    }
    return self;
}

@end
