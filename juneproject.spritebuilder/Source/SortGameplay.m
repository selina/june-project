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
    
    float timeSinceBall;
    float randomTimeUntilNextBall;
    int velocityThreshold;
}

-(void)didLoadFromCCB {
    self.userInteractionEnabled = true;
    
    _ballArray = [NSMutableArray arrayWithObjects:@"blueball", @"redball", nil];
    //_physicsNode.debugDraw = true;
    _physicsNode.collisionDelegate = self;
    
    _bluebin.physicsBody.collisionType = @"bluebin";
    _redbin.physicsBody.collisionType = @"redbin";
    
    timeSinceBall = 0.0;
    _score = 0;
    livesLeft = 3;
    
    [self schedule:@selector(ballsFallFaster) interval:5];
}

- (void)update:(CCTime)delta {
    [self generateNewBall:delta];
}

-(BOOL) getYesOrNo
{
    return (CCRANDOM_0_1() < 0.5f);
}

-(void)generateTrash {
    BOOL coin = [self getYesOrNo];
    CCNode *ballinstance;
    
    if (coin == true) {
        ballinstance = (CCNode*)[CCBReader load:@"redball"];
    }
    else {
        ballinstance = (CCNode*)[CCBReader load:@"blueball"];

    }
    
    srandom(time(NULL));
    
    float contentNodeWidth = _contentNode.contentSize.width;
    
    float x = clampf(CCRANDOM_0_1() * contentNodeWidth, contentNodeWidth*0.1, contentNodeWidth*0.8);
    float y = _contentNode.contentSize.height;
    CGPoint ballLocation = ccp(x, y);
    
    ballinstance.positionType = CCPositionTypeNormalized;
    ballinstance.position = ballLocation;
    
    [_physicsNode addChild:ballinstance];
    
    int randomvelocity = arc4random_uniform(40) + velocityThreshold;
    int negativevelocity = -1 * randomvelocity;
    ballinstance.physicsBody.velocity = ccp(0, negativevelocity);
    ballinstance.physicsBody.density = 10.00;
    
}

-(void)generateNewBall:(CCTime)delta {
    //after random amount of time less than three seconds: generate new cup
    
    srandom(time(NULL));
    
    timeSinceBall += delta;
    
    if (timeSinceBall > randomTimeUntilNextBall) {
        [self generateTrash];
        timeSinceBall = 0;
        randomTimeUntilNextBall = clampf((CCRANDOM_0_1() * 2),1,2);
    }
}


-(void)ballsFallFaster {
    velocityThreshold += 10;
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair redball:(CCNode *)nodeA redbin:(CCNode *)nodeB {
    nodeA.visible=NO;
    nodeA.physicsBody.collisionMask=@[];
    //TODO: addpoints
    
    return NO;
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair blueball:(CCNode *)nodeA bluebin:(CCNode *)nodeB {
    nodeA.visible=NO;
    nodeA.physicsBody.collisionMask=@[];
    //TODO: addpoints
    
    return NO;
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair redball:(CCNode *)nodeA bluebin:(CCNode *)nodeB {
    nodeA.visible=NO;
    nodeA.physicsBody.collisionMask=@[];
    //TODO: remove points
    
    return NO;
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair blueball:(CCNode *)nodeA redbin:(CCNode *)nodeB {
    nodeA.visible=NO;
    nodeA.physicsBody.collisionMask=@[];
    //TODO: remove points
    
    return NO;
}


@end
