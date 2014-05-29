//
//  FKGrid.h
//  Asteroid
//
//  Created by Fredrik on 21/05/14.
//  Copyright (c) 2014 Fredrik K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FKPoint.h"
#import "FKSpring.h"

@interface FKGrid : NSObject

@property NSMutableArray *points;
@property NSMutableArray *springList;
@property NSMutableArray *rays;
@property SKScene *scene;

- (id)initWithSize:(CGSize) size andSpacing:(CGPoint) spacing andScene:(SKScene*) scene;
- (void)applyExplosiveAtPosition:(CGPoint) position andRadius:(CGFloat) radius;
- (void)updateRays;

@end
