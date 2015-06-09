//
//  FlickOffScreen.m
//  juneproject
//
//  Created by Selina Wang on 6/7/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "FlickOffScreen.h"
#import "CCPhysics+ObjectiveChipmunk.h"


@implementation FlickOffScreen {
    CCPhysicsNode *_physicsNode;
    CCNode *_contentNode;
    float timeSinceBall;
    float randomTimeUntilNextBall;
    int maxBalls;
    int currentBalls;
}

-(void)didLoadFromCCB {
    self.userInteractionEnabled = true;
    randomTimeUntilNextBall = 0.2;
    maxBalls = 60;
    currentBalls = 0;
    _physicsNode.collisionDelegate = self;
}

- (void)update:(CCTime)delta {
    [self generateNewBalls:delta];
    
}

-(BOOL) getYesOrNo
{
    return (CCRANDOM_0_1() < 0.5f);
}

-(void)generateBall {
    
    if (currentBalls > maxBalls) {
        [self gameOver];
    }
    srandom(time(NULL));
    
    float contentNodeWidth = _contentNode.contentSize.width;
    
    float xpos = clampf(CCRANDOM_0_1() * contentNodeWidth, contentNodeWidth*0.1, contentNodeWidth*0.8);
    float contentNodeHeight = _contentNode.contentSize.height;
    float ypos = clampf(CCRANDOM_0_1() * contentNodeHeight, contentNodeHeight*0.1, contentNodeHeight*0.8);

    BOOL length_or_height = [self getYesOrNo];
    BOOL which_side = [self getYesOrNo];
    
    float x = 0;
    float y = 0;
    
    //choose which of the four borders to generate from
    if (length_or_height == YES ) {
    //if one of the lengths
        if (which_side == YES) {
            //if left side
            x = 0;
            y=ypos;
            
        }
        else {
            //if right side
            x = contentNodeWidth;
            y = ypos;
        }
    }
    //if one of the heights
    else {
        if (which_side == YES) {
            //if top side
            x = xpos;
            y = contentNodeHeight;
        }
        else {
            //if bottom side
            x = xpos;
            y = 0;
        }
    }
    CGPoint ballLocation = ccp(x,y);

    CCNode *ballinstance = (CCNode*)[CCBReader load:@"redball"];
    ballinstance.positionType = CCPositionTypeNormalized;
    ballinstance.position = ballLocation;
    
    [_physicsNode addChild:ballinstance];
    
    CGFloat xImp = -1*(x-50.0)*5;
    CGFloat yImp = -1*(y-50.0)*5;
    
    [ballinstance.physicsBody applyImpulse:ccp(xImp, yImp)];
    ballinstance.physicsBody.density = 10.00;
    
    currentBalls += 1;
    
}


-(void)generateNewBalls:(CCTime)delta {
    //after random amount of time less than one second: generate new ball
    
    srandom(time(NULL));
    
    timeSinceBall += delta;
    
    if (timeSinceBall > randomTimeUntilNextBall) {
        [self generateBall];
        timeSinceBall = 0;
        randomTimeUntilNextBall = clampf((CCRANDOM_0_1() * 2),1,2);
    }
}

-(void)gameOver {
    
}





@end
