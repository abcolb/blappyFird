//
//  Game.h
//  FlappyBird
//
//  Created by Alexandra Barry on 5/29/14.
//  Copyright (c) 2014 AlexBarryServices. All rights reserved.
//

#import <UIKit/UIKit.h>

int BirdFlight;
int RandomTopBarrierPosition;
int RandomBottomBarrierPosition;
int ScoreNumber;
NSInteger HighScoreNumber;

@interface Game : UIViewController

{
    IBOutlet UIImageView *Bird;
    IBOutlet UIButton *StartGame;
    IBOutlet UIImageView *BarrierTop;
    IBOutlet UIImageView *BarrierBottom;
    IBOutlet UIImageView *Top;
    IBOutlet UIImageView *Bottom;
    IBOutlet UIButton *Exit;
    IBOutlet UILabel *ScoreLabel;
    
    NSTimer *BirdMovement;
    NSTimer *BarrierMovement;
}

-(IBAction)StartGame:(id)sender;
-(void)BirdMoving;
-(void)BarrierMoving;
-(void)PlaceBarriers;
-(void)Score;
-(void)GameOver;

@end
