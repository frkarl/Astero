//
//  FKMyScene.h
//  Asteroid
//

//  Copyright (c) 2014 Fredrik K. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface FKMyScene : SKScene <SKPhysicsContactDelegate>
{
    CGRect screenRect;
    CGFloat screenHeight;
    CGFloat screenWidth;
}
@property (nonatomic) SKSpriteNode *player;

@end
