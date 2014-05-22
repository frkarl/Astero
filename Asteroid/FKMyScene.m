//
//  FKMyScene.m
//  Asteroid
//
//  Created by Fredrik on 10/05/14.
//  Copyright (c) 2014 Fredrik K. All rights reserved.
//

#import "FKMyScene.h"

const float Margin = 20.0f;

@implementation FKMyScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        self.astroidCount = 0;
        /* Setup your scene here */
        screenRect = [[UIScreen mainScreen] bounds];
        screenHeight = screenRect.size.height;
        screenWidth = screenRect.size.width;
        
        self.backgroundColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        
        self.playObjects = [[SKNode alloc] init];
        self.playObjects.name = @"playObjects";
        [self addChild:self.playObjects];
        [self addShip];
        [self addAstroids];
        self.grid = [[FKGrid alloc] initWithSize:screenRect.size andSpacing:CGPointMake(20, 20) andScene:self];
    }
    return self;
}

-(void)didMoveToView:(SKView *)view
{
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    
    //  SKPhysicsBody objects to hold the passed in objects
    SKPhysicsBody *firstBody;
    SKPhysicsBody *secondBody;
    
    // The contacts can appear in either order, and so normally you'd need to check
    // each against the other. In this example, the category types are well ordered, so
    // the code swaps the two bodies if they are out of order. This allows the code
    // to only test collisions once.
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if ((firstBody.categoryBitMask & RBCmissileCategory) != 0) {
        if([secondBody.node isKindOfClass:[FKAsteroidNode class]])
        {
            [self hitAsteroid:(FKAsteroidNode *)secondBody.node withBullet:firstBody.node];
        }
        
    }
    
    if ((secondBody.categoryBitMask & RBCshipCategory) != 0) {
        [self.player applyDamage:contact.collisionImpulse / 2];
        //[self.HUD shrinkHealthBar:(CGFloat)self.ship.health / 10];
    }
}

- (void)hitAsteroid:(FKAsteroidNode *)asteroid withBullet:(SKNode*)bullet {
    bullet.physicsBody = nil;
    //SKEmitterNode *explosion = [self newExplosionNode: 0.1];
    //explosion.position = bullet.position;
    //[self addChild:explosion];
    [bullet removeFromParent];
    
    asteroid.gone = true;
    
    // Generic rock boom
    //[self runAction:self.rockExplodeSound];
}

- (void)handleTouches:(NSSet *)touches
{
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        
        double angle = atan2(location.y-self.player.position.y,location.x-self.player.position.x);
        SKAction *action = [SKAction rotateToAngle:angle-M_PI_2 duration:.1];
        
        [self.player runAction:action];
        [self.player fireShot];
    }
}

- (void)addShip {
    if (self.player) {
        return;
    }
    
    self.player = [FKShipNode newShipNode];
    self.player.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        //  With no transsition just add the ship
        //if (!useTransition) {
            [self.playObjects addChild:self.player];//.playObjects addChild:self.player];
        //} else {
            //  Transition to drop in a new ship
         //   [self.player setScale:3.0];
         //   self.player.alpha = 0;
         //   SKAction *zoom = [SKAction  scaleTo:1.0 duration:1.0];
         //   SKAction *fadeIn = [SKAction fadeInWithDuration:1.0];
         //   SKAction *dropIn = [SKAction group:@[zoom, fadeIn]];
         //   [self.playObjects addChild:self.ship];
         //   [self.ship runAction:dropIn];
        //}
    //}
}

- (void)addAstroids {
    while (self.astroidCount < 5) { //self.HUD.level * 2) {
        FKAsteroidNode *asteroid = [FKAsteroidNode newAsteroidWithMass:5];
        asteroid.position = CGPointMake(arc4random_uniform(self.size.width), arc4random_uniform(self.size.height));
        
        [self.playObjects addChild:asteroid];
        [asteroid startMove];
        self.astroidCount++;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouches:touches];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouches:touches];}

-(void)update:(CFTimeInterval)currentTime {
    [self updateSpritePositions];
    //  Update the score label
    //[(SKLabelNode *)[self childNodeWithName:@"HUD/score"] setText: [NSString stringWithFormat:@"Score: %ld", (long)self.HUD.score]];
    
    //  If we are out of rocks it's time for the next level.
    //if (self.rockCount == 0) {
    //    [self advanceLevel];
    //};
}

-(void) splitAsteriod:(FKAsteroidNode *) asteroid {
    if (!asteroid.gone) {
        return;
    }
    
    CGPoint position = asteroid.position;
    CGVector linearVelocity = asteroid.physicsBody.velocity;
    CGFloat angularVelocity = asteroid.physicsBody.angularVelocity;
    CGFloat mass = asteroid.physicsBody.mass;
        
    //self.rockCount-- ;
    [asteroid removeFromParent];
    //self.HUD.score = self.HUD.score + 100;
    if (mass > 1 && mass <= 5) {
        for (NSInteger i = 0; i < 2; i++) {
            FKAsteroidNode *newAsteroid = [FKAsteroidNode newAsteroidWithMass:mass-1];
            //self.rockCount++;
                
            newAsteroid.position = position;
            [self.playObjects addChild:newAsteroid];
            newAsteroid.physicsBody.velocity =  CGVectorMake(linearVelocity.dx * 1.2, linearVelocity.dy * 1.2);
            newAsteroid.physicsBody.angularVelocity = (angularVelocity + 3.0);
        }
    }
}

- (void)updateSpritePositions {
    
    [self enumerateChildNodesWithName:@"/playObjects/*" usingBlock:^(SKNode *node, BOOL *stop) {
        
        //  Get the current possition
        CGPoint nodePosition = CGPointMake(node.position.x, node.position.y);
        
        
        //  If we've gone beyond the edge warp to the other side.
        if (nodePosition.x > (CGRectGetMaxX(self.frame) + 20)) {
            node.position = CGPointMake((CGRectGetMinX(self.frame) - 10), nodePosition.y);
        }
        
        if (nodePosition.x < (CGRectGetMinX(self.frame) - 20)) {
            node.position = CGPointMake((CGRectGetMaxX(self.frame) + 10), nodePosition.y);
        }
        
        if (nodePosition.y > (CGRectGetMaxY(self.frame) + 20)) {
            node.position = CGPointMake(nodePosition.x, (CGRectGetMinY(self.frame) - 10));
        }
        
        if (nodePosition.y < (CGRectGetMinY(self.frame) - 20)) {
            node.position = CGPointMake(nodePosition.x, (CGRectGetMaxY(self.frame) + 10));
        }
        
    }];
    
    [self enumerateChildNodesWithName:@"/playObjects/asteroid" usingBlock:^(SKNode *node, BOOL *stop) {
        if([node isKindOfClass:[FKAsteroidNode class]])
        {
            [self splitAsteriod:(FKAsteroidNode *)node];
        }
    }];
    
    [self enumerateChildNodesWithName:@"/missile" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y > (CGRectGetMaxY(self.frame)) || node.position.y < (CGRectGetMinY(self.frame)) ||
            node.position.x > (CGRectGetMaxX(self.frame)) || node.position.x < (CGRectGetMinX(self.frame))) {
            node.physicsBody = nil;
            [node removeFromParent];
        } else {
            [self.grid applyExplosiveAtPosition:node.position andRadius:100];
        }
    }];
    
}

@end


