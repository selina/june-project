//
//  CCPhysicsTouchNode.m
//  
//
//  Created by Selina Wang on 6/8/15.
//
//

#import "CCPhysicsTouchNode.h"
#import "CCPhysics+ObjectiveChipmunk.h"


@implementation CCPhysicsTouchNode {
    ChipmunkMultiGrab *_grab;
}

-(id)init
{
    if((self = [super init])){
        self.userInteractionEnabled = YES;
        self.multipleTouchEnabled = YES;
    }
    
    return self;
}

-(void)onEnter
{
    CCPhysicsNode *physics = self.physicsNode;
    NSAssert(physics, @"Must be added to a physics node.");
    
    _grab = [[ChipmunkMultiGrab alloc] initForSpace:physics.space withSmoothing:powf(0.1f, 15.0f) withGrabForce:1e5];
    _grab.grabRadius = 20.f;
    
    [super onEnter];
}

-(void)touchBegan:(CCTouch *)touch withEvent:(UIEvent *)event
{
    [_grab beginLocation:[touch locationInNode:self]];
}

-(void)touchMoved:(CCTouch *)touch withEvent:(UIEvent *)event
{
    [_grab updateLocation:[touch locationInNode:self]];
}

-(void)touchEnded:(CCTouch *)touch withEvent:(UIEvent *)event
{
    [_grab endLocation:[touch locationInNode:self]];
}

-(void)touchCancelled:(CCTouch *)touch withEvent:(UIEvent *)event
{
    [self touchEnded:touch withEvent:event];
}

@end
