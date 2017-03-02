//
//  ViewController.m
//  ParseHtmlDemo
//
//  Created by andson-zhw on 17/3/2.
//  Copyright © 2017年 andson. All rights reserved.
//

#import "ViewController.h"
#import "HomeModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  NSArray *ar=  [HomeModel getNewPosts];
    
    NSLog(@"%@",ar);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
