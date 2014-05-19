//
//  FKMyScene.h
//  Asteroid
//

//  Copyright (c) 2014 Fredrik K. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "FKShipNode.h"
#import "FKAsteroidNode.h"

typedef NS_OPTIONS(NSUInteger, RockBusterCollionsMask) {
    RBCmissileCategory =  1 << 0,
    RBCasteroidCategory =  1 << 1,
    RBCshipCategory =  1 << 2
};

@interface FKMyScene : SKScene <SKPhysicsContactDelegate>
{
    CGRect screenRect;
    CGFloat screenHeight;
    CGFloat screenWidth;
}

@property FKShipNode *player;
@property SKNode *playObjects;
@property NSArray *astroidsToAdd;

@end
