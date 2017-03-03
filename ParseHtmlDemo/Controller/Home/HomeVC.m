//
//  HomeVC.m
//  ParseHtmlDemo
//
//  Created by andson-zhw on 17/3/3.
//  Copyright © 2017年 andson. All rights reserved.
//

#import "HomeVC.h"
#import "ArticleTableCell.h"
#import "HomeModel.h"


// 用到的两个宏：
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

static NSString *const HomeCell = @"HomeCell";

@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataArr;
}
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"首页";
    
    //监听横竖屏
    //[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    [self setUI];
    
    [self loadData];
}


- (void)deviceOrientationDidChange
{
    //NSLog(@"deviceOrientationDidChange:%ld",(long)[UIDevice currentDevice].orientation);
    if([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
//        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
//        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
        //[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
        [self orientationChange:NO];
        //注意： UIDeviceOrientationLandscapeLeft 与 UIInterfaceOrientationLandscapeRight
    } else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft) {
        //[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
        [self orientationChange:YES];
    }else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight){
        //[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft];
         [self orientationChange:YES];
    }
}

- (void)orientationChange:(BOOL)landscapeRight
{
    if (landscapeRight) {
        [UIView animateWithDuration:0.2f animations:^{
            //self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.view.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            self.tableView.frame = self.view.bounds;
            //[self.tableView reloadData];
        }];
    } else {
        [UIView animateWithDuration:0.2f animations:^{
            //self.view.transform = CGAffineTransformMakeRotation(0);
            self.view.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            self.tableView.frame = self.view.bounds;
            //[self.tableView reloadData];
        }];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

//设置是否隐藏
- (BOOL)prefersStatusBarHidden {
    //    [super prefersStatusBarHidden];
    return NO;
}

//设置隐藏动画
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}
//// 支持横屏显示
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    // 如果该界面需要支持横竖屏切换
//    return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft;
//    // 如果该界面仅支持横屏
//    // return UIInterfaceOrientationMaskLandscapeRight；
//}

-(void)loadData{
    
    _dataArr = [NSMutableArray arrayWithArray:[HomeModel getNewPosts]];
    [self.tableView reloadData];
}

-(void)setUI{
    //初始化文章列表
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"ArticleTableCell" bundle:nil] forCellReuseIdentifier:HomeCell];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  170;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ArticleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeCell];
    if (!cell) {
        cell = [[ArticleTableCell alloc] init];
    }
    [cell setCellData:_dataArr[indexPath.row]];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
