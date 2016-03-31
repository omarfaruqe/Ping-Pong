//
//  GameScene.m
//  PingPong
//
//  Created by Omar Faruqe on 2016-03-31.
//  Copyright (c) 2016 Omar Faruqe. All rights reserved.
//

#import "GameScene.h"

@interface GameScene()
@property (strong, nonatomic) UITouch *leftPaddleMotivatingTouch;
@property (strong, nonatomic) UITouch *rightPaddleMotivatingTouch;

@end

@implementation GameScene
static const CGFloat kTrackPixelsPerSecond = 1000;

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
        CGPoint p = [touch locationInNode:self];
        NSLog(@"\n%f %f %f %f",p.x, p.y, self.frame.size.height, self.frame.size.width);
        if (p.x < self.frame.size.width * 0.3) {
            self.leftPaddleMotivatingTouch = touch;
            NSLog(@"Left");
        }
        else if (p.x > self.frame.size.width * 0.7){
            self.rightPaddleMotivatingTouch = touch;
            NSLog(@"Right");
        }
        else{
            SKNode *ball = [self childNodeWithName:@"ball"];
            ball.physicsBody.velocity = CGVectorMake(ball.physicsBody.velocity.dx * 2.0, ball.physicsBody.velocity.dy);
        }
    }
    [self trackPaddlesToMotivatingTouches];
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self trackPaddlesToMotivatingTouches];
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if([touches containsObject:self.leftPaddleMotivatingTouch])
        self.leftPaddleMotivatingTouch = nil;
    if([touches containsObject:self.rightPaddleMotivatingTouch])
        self.rightPaddleMotivatingTouch = nil;
}
-(void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if([touches containsObject:self.leftPaddleMotivatingTouch])
        self.leftPaddleMotivatingTouch = nil;
    if([touches containsObject:self.rightPaddleMotivatingTouch])
        self.rightPaddleMotivatingTouch = nil;
}

-(void)update:(CFTimeInterval)currentTime {
    
}

- (void) trackPaddlesToMotivatingTouches{
    id a = @[@{@"node":[self childNodeWithName:@"left_paddle"], @"touch": self.leftPaddleMotivatingTouch ?: [NSNull null]},
             @{@"node":[self childNodeWithName:@"right_paddle"], @"touch": self.rightPaddleMotivatingTouch ?: [NSNull null]}];
    
    for(NSDictionary *o in a){
        SKNode *node = o[@"node"];
        UITouch *touch = o[@"touch"];
        if([[NSNull null] isEqual:touch])
            continue;
        
        CGFloat yPos = [touch locationInNode:self].y;
        NSTimeInterval duratino = ABS(yPos - node.position.y) / kTrackPixelsPerSecond;
        
        SKAction *moveAction = [SKAction moveToY:yPos duration:duratino];
        [node runAction:moveAction withKey:@"moving!"];
    }
}

@end
