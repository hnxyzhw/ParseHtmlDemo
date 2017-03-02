//
//  ViewController.m
//  ParseHtmlDemo
//
//  Created by andson-zhw on 17/3/2.
//  Copyright © 2017年 andson. All rights reserved.
//

#import "ViewController.h"
#import "Post.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Post getNewPosts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
