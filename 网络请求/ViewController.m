//
//  ViewController.m
//  网络请求
//
//  Created by apple on 2018/1/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "DownLoadData.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [DownLoadData postLogin:^(id obj, NSError *error) {
        
    } userName:@"15738962856" passWord:@"123456"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
