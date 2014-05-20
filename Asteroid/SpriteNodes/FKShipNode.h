//
//  FKShipNode.h
//  Asteroid
//
//  Created by Fredrik on 14/05/14.
//  Copyright (c) 2014 Fredrik K. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "FKBulletNode.h"

@interface FKShipNode : SKSpriteNode
@property NSInteger health;

+ (instancetype)newShipNode;

- (void)applyDamage:(NSInteger)ammount;
- (void)fireShot;
@end


