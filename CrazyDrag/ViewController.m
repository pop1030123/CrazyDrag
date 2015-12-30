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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)showAlert:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"aaa" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertViewStyleDefault  handler:^(UIAlertAction *action){
        NSLog(@"") ;
    }];
    
    [alertController addAction:action] ;
    
    [self presentViewController:alertController animated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
