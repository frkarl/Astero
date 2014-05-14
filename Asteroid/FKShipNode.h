//
//  FKShipNode.h
//  Asteroid
//
//  Created by Fredrik on 14/05/14.
//  Copyright (c) 2014 Fredrik K. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface FKShipNode : SKSpriteNode
+ (instancetype)newShipNode;

- (void)fireShot;
@end


