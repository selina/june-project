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
}

-(void)didLoadFromCCB {
    self.userInteractionEnabled = true;
    
}




@end
