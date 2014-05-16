//
//  FKBulletNode.m
//  Asteroid
//
//  Created by Fredrik on 15/05/14.
//  Copyright (c) 2014 Fredrik K. All rights reserved.
//

#import "FKBulletNode.h"

@implementation FKBulletNode

- (void)initPhysics {
    CGFloat offsetX = self.frame.size.width * self.anchorPoint.x;
    CGFloat offsetY = self.frame.size.height * self.anchorPoint.y;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 0 - offsetX, 0 - offsetY);
    CGPathAddLineToPoint(path, NULL, 3 - offsetX, 20 - offsetY);
    CGPathAddLineToPoint(path, NULL, 7 - offsetX, 20 - offsetY);
    CGPathAddLineToPoint(path, NULL, 10 - offsetX, 0 - offsetY);
    
    CGPathCloseSubpath(path);
    
    self.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
    self.physicsBody.linearDamping = 0.0;
    //self.physicsBody.categoryBitMask = RBCmissileCategory;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = 0;
    
    CGPathRelease(path);
}

+ (instancetype)newBulletNode {
    FKBulletNode *bullet = [FKBulletNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"bullet"]];
    [bullet initPhysics];
    
    return bullet;
}
@end
