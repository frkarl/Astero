//
//  FKAsteroidNode.m
//  Asteroid
//
//  Created by Fredrik on 16/05/14.
//  Copyright (c) 2014 Fredrik K. All rights reserved.
//

#import "FKAsteroidNode.h"
#import "FKMyScene.h"

@implementation FKAsteroidNode
- (void)startMove {
    [self.physicsBody applyTorque:(CGFloat)arc4random_uniform(5)-5];
    [self.physicsBody applyImpulse:CGVectorMake(arc4random_uniform(500), 100)];
}

- (BOOL)isGone {
    return self.gone;
}

- (void)initPhysicsWithMass:(CGFloat)mass {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.categoryBitMask = RBCasteroidCategory;
    self.physicsBody.collisionBitMask = (RBCasteroidCategory | RBCshipCategory);
    self.physicsBody.contactTestBitMask = (RBCasteroidCategory | RBCmissileCategory | RBCshipCategory);
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.mass = mass;
    self.physicsBody.angularDamping = 0.0;
}

+ (instancetype)newAsteroidWithMass:(CGFloat)mass {
    FKAsteroidNode *asteroid = [FKAsteroidNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:[NSString stringWithFormat:@"asteroid%ld", (long)mass]]];
    [asteroid initPhysicsWithMass:mass];
    asteroid.name = @"asteroid";//[@(rockType) stringValue];
    SKAction *action = [SKAction rotateByAngle:M_PI duration:3];
    
    [asteroid runAction:[SKAction repeatActionForever:action]];
    return asteroid;
}
@end
