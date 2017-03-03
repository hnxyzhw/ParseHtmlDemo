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
    
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    [self setUI];
    
    [self loadData];
}


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
    return  150;
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
