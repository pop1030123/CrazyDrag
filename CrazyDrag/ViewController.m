//
//  ViewController.m
//  CrazyDrag
//
//  Created by 鹏 付 on 15/12/30.
//  Copyright © 2015年 鹏 付. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    int currentValue ;
    int targetValue ;
    int scoreValue ;
    int roundCount ;
}
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;

@property (strong, nonatomic) IBOutlet UILabel *targetInfo;
@property (strong, nonatomic) IBOutlet UISlider *slider;

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
    currentValue = 50 ;
    targetValue = 1+arc4random()%100 ;
    self.slider.value = currentValue ;
    self.targetInfo.text = [NSString stringWithFormat:@"需要: %d" ,targetValue] ;
}


- (IBAction)showAlert:(id)sender {
    
    int differ = abs(currentValue - targetValue) ;
    int point = 100 - differ ;
    
    scoreValue += point ;
    
    NSString *message = [NSString stringWithFormat:@"你的得分是%d",point];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"aaa" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault  handler:^(UIAlertAction *action){
        NSLog(@"") ;
    }];
    
    [alertController addAction:action] ;
    
    [self presentViewController:alertController animated:true completion:^(){
        self.scoreLabel.text = [NSString stringWithFormat:@"第%d回合 ，你的总分是 ：%d" ,roundCount ,scoreValue] ;
        [self startNewRound] ;
    }];
}
- (IBAction)movedSlide:(UISlider *)sender {
    currentValue = (int)lroundf(sender.value) ;
    NSLog(@"current value :%d" ,currentValue) ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
