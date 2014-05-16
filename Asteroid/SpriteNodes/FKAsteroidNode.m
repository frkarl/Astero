//
//  FKAsteroidNode.m
//  Asteroid
//
//  Created by Fredrik on 16/05/14.
//  Copyright (c) 2014 Fredrik K. All rights reserved.
//

#import "FKAsteroidNode.h"

@implementation FKAsteroidNode
- (void)startMove {
    [self.physicsBody applyTorque:(CGFloat)arc4random_uniform(5)-5];
    [self.physicsBody applyImpulse:CGVectorMake(arc4random_uniform(500), 100)];
}

- (void)initPhysics {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    //self.physicsBody.categoryBitMask = RBCasteroidCategory;
    //self.physicsBody.collisionBitMask = (RBCasteroidCategory | RBCshipCategory);
    //self.physicsBody.contactTestBitMask = (RBCasteroidCategory | RBCmissileCategory | RBCshipCategory);
    self.physicsBody.usesPreciseCollisionDetection = YES;
    //switch ([rock.name integerValue]) {
    //    case RBbigRock:
            self.physicsBody.mass = 5;
    //        break;
    //    case RBlargeRock:
    //        rock.physicsBody.mass = 4;
    //        break;
     //   case RBmediumRock:
     //       rock.physicsBody.mass = 3;
     //       break;;
     //   case RBsmallRock:
     //       rock.physicsBody.mass = 2;
     //       break;
     //   case RBtinyRock:
      //      rock.physicsBody.mass = 1;
     //7       break;
    //}
    self.physicsBody.angularDamping = 0.0;
}

+ (instancetype)newAsteroid {
    FKAsteroidNode *asteroid = [FKAsteroidNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"asteroid5"]];
    [asteroid initPhysics];
    asteroid.name = @"asteroid";//[@(rockType) stringValue];
    SKAction *action = [SKAction rotateByAngle:M_PI duration:3];
    
    [asteroid runAction:[SKAction repeatActionForever:action]];
    return asteroid;
}
@end
