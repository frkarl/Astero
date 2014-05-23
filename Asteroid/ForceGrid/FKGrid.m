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
            //fixedPoints[column][row] = [[FKPoint alloc] initWithPosition:CGVectorMake(x, y) andMass:0];
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
        self.springList = [[NSMutableArray alloc] init];
        self.scene = scene;
        
        int numColumns = (int)(size.width / spacing.x) + 1;
        int numRows = (int)(size.height / spacing.y) + 1;
        self.points = [[NSMutableArray alloc] initWithCapacity:numRows];
        // these fixed points will be used to anchor the grid to fixed positions on the screen
        NSMutableArray *fixedPoints = [[NSMutableArray alloc] initWithCapacity:numRows];
        
        [self createPoints:fixedPoints spacing:spacing size:size];
        
        // link the point masses with springs
        for (int y = 0; y < numRows-1; y++)
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
                springA.damping = 0.0;
                springB.frequency = 1.0; //gives the spring some elasticity.
                springB.damping = 0.0;
                [self.scene.physicsWorld addJoint:springA];
                [self.scene.physicsWorld addJoint:springB];
                
                /*
                if (x == 0 || y == 0 || x == numColumns - 1 || y == numRows - 1) {    // anchor the border of the grid
                    NSMutableArray *rowArray = [[NSMutableArray alloc] initWithCapacity:numColumns];
                    NSMutableArray *fixedRow = [[NSMutableArray alloc] initWithCapacity:numColumns];
                    
                    SKPhysicsJointSpring *spring = [SKPhysicsJointSpring jointWithBodyA:ceiling.physicsBody
                                                                                  bodyB:block.physicsBody
                                                                                anchorA:ceiling.position
                                                                                anchorB:block.position];
                    [self.scene.physicsWorld addJoint:spring];
                    [self.springList addObject:[SKPhysicsJointSpring init]];
                }
                    //springList.Add(new Spring(fixedPoints[x, y], points[x, y], 0.1f, 0.1f));
                else if (x % 3 == 0 && y % 3 == 0)                                  // loosely anchor 1/9th of the point masses
                    [self.springList addObject:[SKPhysicsJointSpring init]];
                    //springList.Add(new Spring(fixedPoints[x, y], points[x, y], 0.002f, 0.02f));
                
                const float stiffness = 0.28f;
                const float damping = 0.06f;
                if (x > 0)
                    [self.springList addObject:[SKPhysicsJointSpring init]];
                    //springList.Add(new Spring(points[x - 1, y], points[x, y], stiffness, damping));
                if (y > 0)
                    [self.springList addObject:[SKPhysicsJointSpring init]];
                    //springList.Add(new Spring(points[x, y - 1], points[x, y], stiffness, damping));
                 */
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

@end
