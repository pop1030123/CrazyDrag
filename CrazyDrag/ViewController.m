//
//  ViewController.m
//  CrazyDrag
//
//  Created by 鹏 付 on 15/12/30.
//  Copyright © 2015年 鹏 付. All rights reserved.
//

#import "ViewController.h"
#import "AboutViewController.h"

@interface ViewController (){
    int currentValue ;
    int targetValue ;
    int scoreValue ;
    int roundCount ;
}
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;

@property (strong, nonatomic) IBOutlet UILabel *targetInfo;
@property (strong, nonatomic) IBOutlet UISlider *slider;
- (IBAction)toAboutPage:(id)sender;

@end

@implementation ViewController
@synthesize slider ;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNewRound] ;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)startNewRound{
    roundCount +=1 ;
    currentValue = self.slider.value ;
    targetValue = 1+arc4random()%100 ;
    self.slider.value = currentValue ;
    self.targetInfo.text = [NSString stringWithFormat:@"需要: %d" ,targetValue] ;
}

- (void)resetGame{
    scoreValue = 0 ;
    roundCount = 1 ;
    self.scoreLabel.text = [NSString stringWithFormat:@"......"] ;
    [self startNewRound] ;
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
