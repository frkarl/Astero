//
//  FKAsteroidNode.h
//  Asteroid
//
//  Created by Fredrik on 16/05/14.
//  Copyright (c) 2014 Fredrik K. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface FKAsteroidNode : SKSpriteNode
+ (instancetype)newAsteroid;

- (void)startMove;
@end
