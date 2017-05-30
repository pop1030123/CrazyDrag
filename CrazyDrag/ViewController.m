//
//  ViewController.m
//  CrazyDrag
//
//  Created by 鹏 付 on 15/12/30.
//  Copyright © 2015年 鹏 付. All rights reserved.
//

#import "ViewController.h"
#import "AboutViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController (){
    int currentValue ;
    int targetValue ;
    int scoreValue ;
    int roundCount ;
}

@property(strong ,nonatomic)AVAudioPlayer *audioPlayer ;

@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;

@property (strong, nonatomic) IBOutlet UILabel *targetInfo;
@property (strong, nonatomic) IBOutlet UISlider *slider;
- (IBAction)toAboutPage:(id)sender;

@end

@implementation ViewController
@synthesize slider ;
@synthesize audioPlayer ;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *imageNormal = [UIImage imageNamed:@"SliderThumb-Normal"] ;
    [self.slider setThumbImage:imageNormal forState:UIControlStateNormal];
    
    UIImage *imageHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"] ;
    [self.slider setThumbImage:imageHighlighted forState:UIControlStateHighlighted] ;
    
    UIImage *trackLeftImage = [[UIImage imageNamed:@"SliderTrackLeft"] stretchableImageWithLeftCapWidth:14 topCapHeight:0] ;
    [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal] ;
    
    UIImage *trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"] stretchableImageWithLeftCapWidth:14 topCapHeight:0] ;
    [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal] ;
    
    
    [self startNewRound] ;
    
    [self playBackgroundMusic];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)playBackgroundMusic{
    NSString *musicPath = [[NSBundle mainBundle]pathForResource:@"no" ofType:@"mp3"] ;
    NSURL *url = [NSURL fileURLWithPath:musicPath] ;
    NSError *error ;
    
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error] ;
    
    if(audioPlayer == nil){
        NSString *errorLog = [NSString stringWithString:[error description]] ;
        NSLog(@"the play error %@:" ,errorLog) ;
    }else{
        audioPlayer.numberOfLoops = -1 ;
        [audioPlayer play] ;
    }
    
}

- (void)startNewRound{
    roundCount +=1 ;
    currentValue = self.slider.value ;
    targetValue = 1+arc4random()%100 ;
    self.slider.value = currentValue ;
    self.targetInfo.text = [NSString stringWithFormat:@"拖动滑动条，让靶心尽可能接近数字: %d" ,targetValue] ;
}

- (void)resetGame{
    
    CATransition *animation = [CATransition animation] ;
    animation.type = kCATransitionFade ;
    animation.duration = 1 ;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    scoreValue = 0 ;
    roundCount = 1 ;
    self.scoreLabel.text = [NSString stringWithFormat:@"......"] ;
    [self startNewRound] ;
    
    [self.view.layer addAnimation:animation forKey:nil] ;
}

- (IBAction)showAlert:(id)sender {
    
    int differ = abs(currentValue - targetValue) ;
    int point = 100 - differ ;
    
    scoreValue += point ;
    
    NSString *suffix = @"" ;
    
    if(differ == 0){
        suffix = @"你太厉害了，满分！" ;
        scoreValue += 100 ;
    }else if(differ <= 5){
        suffix = @"太棒了，就差一点了！" ;
        if(differ == 1){
            scoreValue += 50 ;
        }
    }else if(differ <= 10){
        suffix = @"再接再励！" ;
    }else{
        suffix = @"太丢脸了!!" ;
    }
    
    NSString *message = [NSString stringWithFormat:@"你的得分是%d ,%@",point ,suffix];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"抽奖结果" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault  handler:^(UIAlertAction *action){
        self.scoreLabel.text = [NSString stringWithFormat:@"第%d回合 ，你的总分是 ：%d" ,roundCount ,scoreValue] ;
        [self startNewRound] ;
    }];
    
    [alertController addAction:action] ;
    
    [self presentViewController:alertController animated:true completion:^(){
        
    }];
}

- (IBAction)resetGame:(id)sender {
    [self resetGame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSliderMoved:(UISlider*)sender {
    currentValue = (int) lroundf([sender value])  ;
    NSLog(@"current value is %d",currentValue);
}

- (IBAction)toAboutPage:(id)sender {
    AboutViewController *aboutViewController = [[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil] ;
    
    aboutViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal ;
    
    [self presentViewController:aboutViewController animated:true completion:nil] ;
}
@end
