//
//  FKGrid.m
//  Asteroid
//
//  Created by Fredrik on 21/05/14.
//  Copyright (c) 2014 Fredrik K. All rights reserved.
//

#import "FKGrid.h"

@implementation FKGrid

- (void)createPoints:(NSMutableArray *)fixedPoints spacing:(CGPoint)spacing size:(CGSize)size {
    int numColumns = (int)(size.width / spacing.x) + 1;
    int numRows = (int)(size.height / spacing.y) + 1;
    int column = 0, row = 0;
    for (float y = 0; y <= size.height; y += spacing.y)
    {
        NSMutableArray *rowArray = [[NSMutableArray alloc] initWithCapacity:numColumns];
        NSMutableArray *fixedRow = [[NSMutableArray alloc] initWithCapacity:numColumns];
        
        for (float x = 0; x <= size.width; x += spacing.x)
        {
            FKPoint *point;
            if (column == 0 || row == 0|| column == numColumns - 1 || row == numRows - 1) {
                point = [[FKPoint alloc] initWithPosition:CGPointMake(y, x) mass:1 isStatic:YES];
            } else {
                point = [[FKPoint alloc] initWithPosition:CGPointMake(y, x) mass:1 isStatic:NO];
            }
            [self.scene addChild:point];
            [rowArray insertObject:point atIndex:column];
            [fixedRow insertObject:[[FKPoint alloc] initWithPosition:CGPointMake(y, x) mass:0 isStatic:YES] atIndex:column];
            column++;
        }
        [self.points insertObject:rowArray atIndex:row];
        [fixedPoints insertObject:fixedRow atIndex:row];
        row++;
        column = 0;
    }
}

- (id)initWithSize:(CGSize) size andSpacing:(CGPoint) spacing andScene:(SKScene*) scene {
    self = [super init];
    if (self) {
        self.rays = [[NSMutableArray alloc] init];
        self.springList = [[NSMutableArray alloc] init];
        
        self.scene = scene;
        
        int numColumns = (int)(size.width / spacing.x) + 1;
        int numRows = (int)(size.height / spacing.y) + 1;
        self.points = [[NSMutableArray alloc] initWithCapacity:numRows];
        
        // these fixed points will be used to anchor the grid to fixed positions on the screen
        NSMutableArray *fixedPoints = [[NSMutableArray alloc] initWithCapacity:numRows];
        
        [self createPoints:fixedPoints spacing:spacing size:size];
        
        // link the point masses with springs
        for (int y = 0; y < numRows-1; y++) {
            for (int x = 0; x < numColumns-1; x++)
            {
                NSMutableArray *rowArray = [self.points objectAtIndex:y];
                NSMutableArray *nextRowArray = [self.points objectAtIndex:y+1];
                FKPoint *point = [rowArray objectAtIndex:x];
                FKPoint *leftPoint = [rowArray objectAtIndex:x+1];
                FKPoint *topPoint = [nextRowArray objectAtIndex:x];
                
                SKPhysicsJointSpring *springA = [SKPhysicsJointSpring jointWithBodyA:point.physicsBody bodyB:leftPoint.physicsBody
                                                                            anchorA:point.position anchorB:leftPoint.position];
                SKPhysicsJointSpring *springB = [SKPhysicsJointSpring jointWithBodyA:point.physicsBody bodyB:topPoint.physicsBody
                                                                            anchorA:point.position anchorB:topPoint.position];
                springA.frequency = 1.0; //gives the spring some elasticity.
                springA.damping = 1.0;
                springB.frequency = 1.0; //gives the spring some elasticity.
                springB.damping = 1.0;
                [self.springList addObject:springA];
                [self.springList addObject:springB];
                [self.scene.physicsWorld addJoint:springA];
                [self.scene.physicsWorld addJoint:springB];
            }
        }
        
    }
    return self;
}

- (void)applyExplosiveAtPosition:(CGPoint) position andRadius:(CGFloat) radius {
    for (NSMutableArray *row in self.points) {
        for (FKPoint *point in row) {
            CGVector vector = CGVectorMake(point.position.x - position.x, point.position.y - position.y);
            CGFloat distance = pow(vector.dx, 2) + pow(vector.dy, 2);
            if (distance < radius * radius) {
                [point.physicsBody applyForce:vector];
            }
            
        }

    }
}

- (void)updateRays {
    NSMutableArray *oldRays = [NSMutableArray arrayWithArray:self.rays];
    [self.rays removeAllObjects];
    
    for (SKPhysicsJointSpring *spring in self.springList) {
        SKShapeNode *ray;
        if ([oldRays count] == 0) {
            ray = [SKShapeNode node];
            ray.strokeColor = [SKColor blueColor];
            ray.zPosition = -1;
            ray.lineWidth = 0.5;
            [self.scene addChild:ray];
        } else {
            ray = [oldRays lastObject];
            [oldRays removeLastObject];
        }
        CGMutablePathRef pathToDraw = CGPathCreateMutable();
        CGPoint posA = spring.bodyA.node.position;
        CGPathMoveToPoint(pathToDraw, NULL, posA.x, posA.y);
        //ray.path = pathToDraw;
        CGPoint posB = spring.bodyB.node.position;
        CGPathAddLineToPoint(pathToDraw, NULL, posB.x, posB.y);
        ray.path = pathToDraw;
        [self.rays addObject:ray];
    }
    
}

@end
