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
        /* Setup your scene here */
        screenRect = [[UIScreen mainScreen] bounds];
        screenHeight = screenRect.size.height;
        screenWidth = screenRect.size.width;
        
        self.backgroundColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        
        //self.player = [SKSpriteNode spriteNodeWithImageNamed:@"ship"];
        //self.player.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        //[self addChild:self.player];
        [self addShip];
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
    
    // Missiles only hit rocks
    
    //if ((firstBody.categoryBitMask & RBCmissileCategory) != 0) {
        //[self hitRock:secondBody.node withMissile:firstBody.node];
    //}
    
    //  Hit the ship with a rock
    //if ((secondBody.categoryBitMask & RBCshipCategory) != 0) {
        //[self.ship applyDamage:contact.collisionImpulse / 2];
        //[self.HUD shrinkHealthBar:(CGFloat)self.ship.health / 10];
    //}
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
            [self addChild:self.player];//.playObjects addChild:self.player];
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

- (SKNode*) addMissile {
    //  Load the texture
    SKSpriteNode *missile = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"bullet"]];
    
    //  Offset for rotation
    CGFloat offsetX = missile.frame.size.width * missile.anchorPoint.x;
    CGFloat offsetY = missile.frame.size.height * missile.anchorPoint.y;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    //  Make the path for the physicsbody to use
    CGPathMoveToPoint(path, NULL, 3 - offsetX, 14 - offsetY);
    CGPathAddLineToPoint(path, NULL, 1 - offsetX, 9 - offsetY);
    CGPathAddLineToPoint(path, NULL, 1 - offsetX, 0 - offsetY);
    CGPathAddLineToPoint(path, NULL, 4 - offsetX, 0 - offsetY);
    CGPathAddLineToPoint(path, NULL, 4 - offsetX, 10 - offsetY);
    
    CGPathCloseSubpath(path);
    
    //  Add the physics body no linearDamping so they just go at the same speed
    missile.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
    missile.physicsBody.linearDamping = 0.0;
    
    //  Collision maps. There are a lot of missiles, so push the job of collision detection to
    //  the objects that we want to hit.
    //missile.physicsBody.categoryBitMask = RBCmissileCategory;
    missile.physicsBody.collisionBitMask = 0;
    missile.physicsBody.contactTestBitMask = 0;
    
    //  Release the path so we don't leak
    CGPathRelease(path);
    return missile;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouches:touches];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouches:touches];}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end


