//
//  FallingBallGameplay.m
//  juneproject
//
//  Created by Selina Wang on 6/4/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "FallingBallGameplay.h"
#import "CCPhysics+ObjectiveChipmunk.h"


@implementation FallingBallGameplay {
    CCPhysicsNode *_physicsNode;
    CCNode *_player;
    CCNode *_contentNode;
    CCNode *_floor;
    
    CCButton *_button;
    CCLabelTTF *_gameOver;
    CCLabelTTF *_dead2;
    CCLabelTTF *_scoreLabel;
    
    float timeSinceBall;
    float randomTimeUntilNextBall;
    int score;
    int velocityThreshold;
}

-(void)didLoadFromCCB {
    self.userInteractionEnabled = true;
    _player.physicsBody.collisionType = @"meursault";
    _floor.physicsBody.collisionType = @"floor";
    _physicsNode.collisionDelegate = self;

    
    UISwipeGestureRecognizer *swiperight;
    UISwipeGestureRecognizer *swipeleft;
    
    swiperight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight)];
    swipeleft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
    
    [swiperight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [swipeleft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swiperight];
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeleft];
    
    [self schedule:@selector(ballsFallFaster) interval:5];
    
    score = 0;
    velocityThreshold = 20;
}

- (void)update:(CCTime)delta {
    [self generateNewTrash:delta];
    
}


-(void)generateBall {
    CCNode *whiteballinstance = (CCNode*)[CCBReader load:@"whiteball"];
    
    
    srandom(time(NULL));
    
    float contentNodeWidth = _contentNode.contentSize.width;
    
    float x = clampf(CCRANDOM_0_1() * contentNodeWidth, contentNodeWidth*0.1, contentNodeWidth*0.8);
    float y = _contentNode.contentSize.height;
    CGPoint ballLoc = ccp(x, y);
    
    whiteballinstance.positionType = CCPositionTypeNormalized;
    whiteballinstance.position = ballLoc;
    
    [_physicsNode addChild:whiteballinstance];
    
    whiteballinstance.physicsBody.collisionType = @"whiteball";
    
    int randomvelocity = arc4random_uniform(60) + velocityThreshold;
    int negativevelocity = -1 * randomvelocity;
    whiteballinstance.physicsBody.velocity = ccp(0, negativevelocity);
    whiteballinstance.physicsBody.density = 10.00;
    //[whiteballinstance.physicsBody applyImpulse:ccp(0.0,-)]

    }

-(void)generateNewTrash:(CCTime)delta {
    //after random amount of time less than three seconds: generate new cup
    
    srandom(time(NULL));
    
    timeSinceBall += delta;
    
    if (timeSinceBall > randomTimeUntilNextBall) {
        [self generateBall];
        timeSinceBall = 0;
        randomTimeUntilNextBall = clampf((CCRANDOM_0_1() * 2),1,2);
    }
}

-(void)ballsFallFaster {
    velocityThreshold += 10;
}



-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair whiteball:(CCNode *)nodeA floor:(CCNode *)nodeB {
    nodeA.visible=NO;
    nodeA.physicsBody.collisionMask=@[];
    score++;
    NSString *scoreString = [NSString stringWithFormat:@"%d", score];
    _scoreLabel.string = scoreString;

    
    return NO;
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair whiteball:(CCNode *)nodeA meursault:(CCNode *)nodeB {
    [self gameOver];
    return NO;
}

-(void)swipeRight {
    CGPoint impulse = ccp(500.f, 0.f);
    [_player.physicsBody applyImpulse:impulse];
}

-(void)swipeLeft {
    CGPoint impulse = ccp(-500.f, 0.f);
    [_player.physicsBody applyImpulse:impulse];
}

-(void)gameOver {
    _button.visible = true;
    _gameOver.visible = true;
    _dead2.visible = true;
    self.paused = true;
}

-(void)nextGame {
    CCScene *nextScene = [CCBReader loadAsScene:@"FlickOffScreen"];
    [[CCDirector sharedDirector] pushScene:nextScene];
}


@end
