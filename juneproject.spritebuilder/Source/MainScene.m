//
//  MainScene.m
//  
//
//  Created by Selina Wang on 6/8/15.
//
//

#import "MainScene.h"

@implementation MainScene

-(void)play {
    CCScene *mainScene = [CCBReader loadAsScene:@"SortGameplay"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}


@end
