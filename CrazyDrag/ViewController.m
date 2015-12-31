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
}

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
    currentValue = 50 ;
    targetValue = 1+arc4random()%100 ;
    self.slider.value = currentValue ;
}


- (IBAction)showAlert:(id)sender {
    
    NSString *message = [NSString stringWithFormat:@"你选择了%d，目标是%d" ,currentValue ,targetValue];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"aaa" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault  handler:^(UIAlertAction *action){
        NSLog(@"") ;
    }];
    
    [alertController addAction:action] ;
    
    [self presentViewController:alertController animated:true completion:nil];
    [self startNewRound] ;
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
