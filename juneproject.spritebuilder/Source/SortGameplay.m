//
//  SortGameplay.m
//  juneproject
//
//  Created by Selina Wang on 6/7/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "SortGameplay.h"
#import "CCPhysics+ObjectiveChipmunk.h"


@implementation SortGameplay {
    CCPhysicsNode *_physicsNode;
    CCNode *_contentNode;
    NSMutableArray *_ballArray;
    CCNode *_bluebin;
    CCNode *_redbin;
    int _score;
    int livesLeft;
    
    int velocityThreshold;
}

-(void)didLoadFromCCB {
    self.userInteractionEnabled = true;
    
    _ballArray = [NSMutableArray arrayWithObjects:@"blueball", @"redball", nil];
    _physicsNode.debugDraw = true;
    _physicsNode.collisionDelegate = self;
    
    _bluebin.physicsBody.collisionType = @"bluebin";
    _redbin.physicsBody.collisionType = @"redbin";
    
    _score = 0;
    livesLeft = 3;
    
    [self schedule:@selector(ballsFallFaster) interval:10];
}

-(void)ballsFallFaster {
    velocityThreshold += 10;
}



@end
