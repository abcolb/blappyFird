//
//  Game.m
//  FlappyBird
//
//  Created by Alexandra Barry on 5/29/14.
//  Copyright (c) 2014 AlexBarryServices. All rights reserved.
//

#import "Game.h"

@interface Game ()

@end

@implementation Game

-(IBAction)StartGame:(id)sender
{
    BarrierTop.hidden = NO;
    BarrierBottom.hidden = NO;
    
    StartGame.hidden = YES;
    BirdMovement = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(BirdMoving) userInfo:nil repeats:YES];
    [self PlaceBarriers];
    BarrierMovement = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(BarrierMoving) userInfo:nil repeats:YES];
}

-(void)BirdMoving
{
    Bird.center = CGPointMake(Bird.center.x, Bird.center.y - BirdFlight);
    BirdFlight = BirdFlight - 5;
    
    if (BirdFlight < -15){
        BirdFlight = -15;
    }
    
    if (BirdFlight > 0){
        Bird.image = [UIImage imageNamed:@"flappyUp.JPG"];
    }
    if (BirdFlight < 0){
        Bird.image = [UIImage imageNamed:@"flappyDown.JPG"];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    BirdFlight = 30;
}

-(void)PlaceBarriers
{
    RandomTopBarrierPosition = arc4random() %350;
    RandomTopBarrierPosition = RandomTopBarrierPosition -228;
    RandomBottomBarrierPosition = RandomTopBarrierPosition + 655;
    
    BarrierTop.center = CGPointMake(340, RandomTopBarrierPosition);
    BarrierBottom.center = CGPointMake(340, RandomBottomBarrierPosition);
    
}

-(void)BarrierMoving{
    BarrierTop.center = CGPointMake(BarrierTop.center.x - 1, BarrierTop.center.y);
    BarrierBottom.center = CGPointMake(BarrierBottom.center.x - 1, BarrierBottom.center.y);
    
    if (BarrierTop.center.x < -26){
        [self PlaceBarriers];
    }
    
    if (BarrierTop.center.x == -7){
        [self Score];
    }
    
    if (CGRectIntersectsRect(Bird.frame, BarrierTop.frame) || CGRectIntersectsRect(Bird.frame, BarrierBottom.frame) || CGRectIntersectsRect(Bird.frame, Top.frame) || CGRectIntersectsRect(Bird.frame, Bottom.frame))
    {
        [self GameOver];
    }
    
}

-(void)Score{
    ScoreNumber = ScoreNumber +1;
    ScoreLabel.text = [NSString stringWithFormat: @"%i", ScoreNumber];
}

-(void)GameOver{
    
    if (ScoreNumber > HighScoreNumber){
        [[NSUserDefaults standardUserDefaults] setInteger:ScoreNumber forKey:@"HighScoreSaved"];
    }
    
    [BarrierMovement invalidate];
    [BirdMovement invalidate];
    
    Exit.hidden = NO;
    Bird.hidden = YES;
    BarrierTop.hidden = YES;
    BarrierBottom.hidden = YES;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    BarrierTop.hidden = YES;
    BarrierBottom.hidden = YES;
    
    Exit.hidden = YES;
    ScoreNumber = 0;
    
    HighScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
