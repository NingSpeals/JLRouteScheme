//
//  FirstViewController.m
//  JLRouteScheme
//
//  Created by lizhaojie on 16/11/29.
//  Copyright © 2016年 siemens. All rights reserved.
//

#import "FirstViewController.h"
#import <Masonry.h>
@interface FirstViewController ()

@end
/*
 routeMap:字典
 scheme：route（NSArray）
 
 */
@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"First";
    self.view.backgroundColor = [UIColor cyanColor];
    [self addBtn];
    // Do any additional setup after loading the view.
}

- (void)addBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    [btn addTarget:self action:@selector(skipNext) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma - mark ----------- url中有汉字要encode下 -----------


- (void)skipNext{
    NSString *name = @"中国";
    NSString *url = @"RouteOne://push/FirstNextViewController?titleText=fromFirst&name=中国";
    NSCharacterSet *allowCharacters = [[NSCharacterSet characterSetWithCharactersInString:name] invertedSet];
    NSString *encodedUrl = [url stringByAddingPercentEncodingWithAllowedCharacters:allowCharacters];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:encodedUrl]];
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
