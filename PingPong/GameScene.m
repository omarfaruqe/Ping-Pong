//
//  GameScene.m
//  PingPong
//
//  Created by Omar Faruqe on 2016-03-31.
//  Copyright (c) 2016 Omar Faruqe. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeFill;
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    
    SKNode *ball = [self childNodeWithName:@"ball"];
    ball.physicsBody.angularVelocity = 1.0;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
