//
//  FKShipNode.m
//  Asteroid
//
//  Created by Fredrik on 14/05/14.
//  Copyright (c) 2014 Fredrik K. All rights reserved.
//

#import "FKShipNode.h"
#import "FKMyScene.h"

@implementation FKShipNode
- (void)initPhysics {
    CGFloat offsetX = self.frame.size.width * self.anchorPoint.x;
    CGFloat offsetY = self.frame.size.height * self.anchorPoint.y;
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 0 - offsetX, 0 - offsetY);
    CGPathAddLineToPoint(path, NULL, 40 - offsetX, 0 - offsetY);
    CGPathAddLineToPoint(path, NULL, 25 - offsetX, 40 - offsetY);
    CGPathAddLineToPoint(path, NULL, 15 - offsetX, 40 - offsetY);
    
    CGPathCloseSubpath(path);
    
    self.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
    
    self.physicsBody.mass = 2;
    self.physicsBody.linearDamping = .7;
    self.physicsBody.angularDamping = 1.0;
    
    self.physicsBody.categoryBitMask = RBCshipCategory;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = RBCasteroidCategory;
    
    CGPathRelease(path);
}

- (void)fireShot {
    CGFloat shipDirection = self.zRotation + M_PI_2;
    
    SKNode *missile = [FKBulletNode newBulletNode];
    missile.position = CGPointMake(self.position.x + 30*cosf(shipDirection),
                                   self.position.y + 30*sinf(shipDirection));
    missile.name = @"missile";
    missile.zRotation = self.zRotation;
    
    [self.scene addChild:missile];
    
    missile.physicsBody.velocity = CGVectorMake(200*cosf(shipDirection),
                                                200*sinf(shipDirection));
}

- (void)applyDamage:(NSInteger)ammount {
    if (ammount >= self.health) {
        self.health = 0;
        [self explode];
        return;
    }
    
    self.health -= ammount;
    
    //if (self.health <=250) {
    //    [self runAction:self.warningSound];
    //}
}

- (void)explode {
    [self runAction:[SKAction removeFromParent]];
    [self removeAllActions];
}

+ (instancetype)newShipNode {
    FKShipNode *ship = [FKShipNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"ship"]];
    
    [ship initPhysics];
    
    ship.name = @"Ship";
    ship.health = 1000;
    
    //    ship.playingSound = NO;
    //    ship.engineNoise = [SKAction playSoundFileNamed:@"RocketThrusters.caf" waitForCompletion:YES];
    //ship.missileSound = [SKAction playSoundFileNamed:@"boom1.caf" waitForCompletion:YES];
    //ship.warningSound = [SKAction repeatActionForever:[SKAction playSoundFileNamed:@"alarm.caf" waitForCompletion:NO]];
    
    return ship;
}
@end
