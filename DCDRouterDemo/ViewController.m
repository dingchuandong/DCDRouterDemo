//
//  ViewController.m
//  DCDRouter
//
//  Created by boohee on 2018/6/1.
//  Copyright © 2018年 boohee. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:web];
//    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://aos.prf.hn/click/camref:1101l3uIq/destination:https://www.apple.com/cn/shop/go/apple_watch"]]];
    
//    WKWebView *webs = [[WKWebView alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:webs];
//    [webs loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://aos.prf.hn/click/camref:1101l3uIq/destination:https://www.apple.com/cn/shop/go/apple_watch"]]];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *but = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 200/2, 200, 200, 200)];
        [button setBackgroundColor:[UIColor redColor]];
        [button setTitle:@"(1)跳转" forState:UIControlStateNormal];
        button.routingString = @"/First";
        button;
    });
    [self.view addSubview:but];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
