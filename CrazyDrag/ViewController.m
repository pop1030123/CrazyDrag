//
//  ViewController.m
//  CrazyDrag
//
//  Created by 鹏 付 on 15/12/30.
//  Copyright © 2015年 鹏 付. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

int currentValue ;
- (void)viewDidLoad {
    [super viewDidLoad];
    currentValue = 50 ;
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)showAlert:(id)sender {
    
    NSString *message = [NSString stringWithFormat:@"你选择了%d" ,currentValue];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"aaa" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertViewStyleDefault  handler:^(UIAlertAction *action){
        NSLog(@"") ;
    }];
    
    [alertController addAction:action] ;
    
    [self presentViewController:alertController animated:true completion:nil];
}
- (IBAction)movedSlide:(id)sender {
    
    UISlider *slider = (UISlider*)sender ;
    currentValue = (int)lroundf(slider.value) ;
    NSLog(@"current value :%d" ,currentValue) ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
