//
//  MainScene.m
//  
//
//  Created by Selina Wang on 6/7/15.
//
//

#import "MainScene.h"

@implementation MainScene

-(void)play {
    CCScene *mainScene = [CCBReader loadAsScene:@"TapTheButton"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}


@end
