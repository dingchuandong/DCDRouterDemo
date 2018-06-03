//
//  SecondViewController.m
//  RouterDemo
//
//  Created by boohee on 2018/4/28.
//  Copyright © 2018年 boohee. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *but = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 200/2, 200, 200, 200)];
        [button setBackgroundColor:[UIColor blueColor]];
        [button setTitle:@"(2)消失" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(dissVC) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:but];
    self.title = @"第二个页面";
}

- (void)dissVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
