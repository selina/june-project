//
//  TapTheButton.m
//  juneproject
//
//  Created by Selina Wang on 6/7/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "TapTheButton.h"

@implementation TapTheButton {
    CCLabelTTF *_label1;
    CCLabelTTF *_label2;
    CCLabelTTF *_label3;
    CCLabelTTF *_label4;
    CCLabelTTF *_label5;
    CCLabelTTF *_label6;
    CCLabelTTF *_label7;
    CCLabelTTF *_label8;
    CCButton *_continueButton;
    int count;
    
}

-(void)didLoadFromCCB {
    self.userInteractionEnabled = true;
    count = 0;
}

//some REALLY DUMB code i'm sorry i'm pressed for time
-(void)buttonPressed {
    if (count == 0) {
        _label1.visible = NO;
        _label2.visible = YES;
    }
    else if (count == 1) {
        _label2.visible = NO;
        _label3.visible = YES;
    }
    else if (count == 2) {
        _label3.visible = NO;
        _label4.visible = YES;
    }
    else if (count == 3) {
        _label4.visible = NO;
        _label5.visible = YES;
    }
    else if (count == 4) {
        _label5.visible = NO;
        _label6.visible = YES;
    }
    else if (count == 5) {
        _label6.visible = NO;
        _label7.visible = YES;
    }
    else if (count == 6) {
        _label7.visible = NO;
        _label8.visible = YES;
    }
    else if (count == 7) {
        _label8.visible = NO;
        _continueButton.visible = YES;
    }
        
    
    count += 1;

}


@end
