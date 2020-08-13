//
//  ViewController.m
//  JLRouteScheme
//
//  Created by Ning on 2019/10/17.
//  Copyright © 2019 Ning. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "FirstViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBtn];
    // Do any additional setup after loading the view.
}
- (void)addBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setTitle:@"点击跳转" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    [btn addTarget:self action:@selector(skipNext) forControlEvents:UIControlEventTouchUpInside];

    
}
- (void)skipNext{
    NSString *url = @"RouteOne://push/FirstViewController";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    
    
//        [self.navigationController pushViewController:[FirstViewController new] animated:YES];
//        [ self presentViewController:[[FirstViewController alloc] init]  animated:YES completion:^{
//
//        }];
}


@end
