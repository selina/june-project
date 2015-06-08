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
}

-(void)didLoadFromCCB {
    UISwipeGestureRecognizer *swiperight;
    UISwipeGestureRecognizer *swipeleft;
    
    swiperight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight)];
    swipeleft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
    
    [swiperight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [swipeleft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swiperight];
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeleft];

}


-(void)swipeRight {
    CGPoint impulse = ccp(400.f, 0.f);
    [_player.physicsBody applyImpulse:impulse];
}

-(void)swipeLeft {
    CGPoint impulse = ccp(-400.f, 0.f);
    [_player.physicsBody applyImpulse:impulse];
}






@end
