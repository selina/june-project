//
//  GameOver.m
//  juneproject
//
//  Created by Selina Wang on 6/8/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameOver.h"

@implementation GameOver

-(void)playAgain {
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}


@end
