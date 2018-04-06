//
//  ViewController.m
//  HTChatUIExample
//
//  Created by coderhong on 2018/4/6.
//  Copyright © 2018年 coderhong. All rights reserved.
//

#import "ViewController.h"
#import "HTChatViewController.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)chatingClick:(UIButton *)sender {
    
    HTChatViewController *vc = [[HTChatViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
