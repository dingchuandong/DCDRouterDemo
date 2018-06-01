//
//  FirstViewController.m
//  RouterDemo
//
//  Created by boohee on 2018/4/28.
//  Copyright © 2018年 boohee. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"第一个页面";
    
    UIButton *but = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 200/2, 200, 200, 200)];
        [button setBackgroundColor:[UIColor redColor]];
        [button setTitle:@"(2)跳转" forState:UIControlStateNormal];
        //        [button.ti    ];
        button.routingString = @"/Second/?way=present";
        button;
    });
    [self.view addSubview:but];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
