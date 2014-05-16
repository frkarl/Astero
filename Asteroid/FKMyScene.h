//
//  FKMyScene.h
//  Asteroid
//

//  Copyright (c) 2014 Fredrik K. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "FKShipNode.h"
#import "FKAsteroidNode.h"

@interface FKMyScene : SKScene <SKPhysicsContactDelegate>
{
    CGRect screenRect;
    CGFloat screenHeight;
    CGFloat screenWidth;
}

@property FKShipNode *player;
@property SKNode *playObjects;

@end
