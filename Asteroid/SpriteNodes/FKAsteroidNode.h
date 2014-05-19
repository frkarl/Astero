//
//  FKAsteroidNode.h
//  Asteroid
//
//  Created by Fredrik on 16/05/14.
//  Copyright (c) 2014 Fredrik K. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSInteger, RockType) {
    Big,
    Large
};

@interface FKAsteroidNode : SKSpriteNode

@property BOOL gone;

+ newAsteroidWithMass:(CGFloat)mass;

- (void)startMove;
- (BOOL)isGone;
@end
