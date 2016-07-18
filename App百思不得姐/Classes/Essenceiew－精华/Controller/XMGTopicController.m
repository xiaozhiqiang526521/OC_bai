//
//  XMGTopicController.m
//  App百思不得姐
//
//  Created by garday on 16/6/23.
//  Copyright © 2016年 garday. All rights reserved.
//

#import "XMGTopicController.h"
#import "XMGTopic.h"

#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "XMGTopicCell.h"
#import "XMGCommentViewController.h"

@interface XMGTopicController ()
/***帖子数据 ***/
@property (nonatomic ,strong)NSMutableArray *topics;
/***当前页码 ***/
@property (nonatomic ,assign)NSInteger page;
/***当加载下一页数据时需要这个参数 ***/
@property (nonatomic ,copy)NSString *maxtime;
/***上一次的请求参数 ***/
@property (nonatomic ,strong)NSDictionary *params;

@end
static NSString *const XMGTopicCellId = @"topic";
@implementation XMGTopicController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupRefresh];//添加刷新空间
}

-(NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

-(void)setupTableView
{
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;//设置控制器view的height值为整个屏幕的高度（默认是比屏幕高度少20）
    
    CGFloat top = XMGTitilesViewH+XMGTitilesViewY;
    self.tableView.contentInset =UIEdgeInsetsMake(top, 0, bottom, 0);
    
    //设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGTopicCell class]) bundle:nil] forCellReuseIdentifier:XMGTopicCellId];
    
}

/**加载新的帖子数据**/
-(void)loadNewTopics
{
    //结束上拉刷新
    [self.tableView.mj_footer endRefreshing];
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary  *responseObject) {
        
        if (self.params != params)return ;
        
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典转模型
        self.topics =[XMGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];//刷新表格
        
        [self.tableView.mj_header endRefreshing];//结束刷新
        //清空页码
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params)return ;
        [self.tableView.mj_header endRefreshing];//结束刷新
    }];
    
}

/**加载更多帖子数据**/
-(void)loadMoreTopics
{
    //结束下拉刷新
    [self.tableView.mj_header endRefreshing];
    
    self.page++;
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary  *responseObject) {
        if (self.params != params)return ;
        
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典转模型
        NSArray *newTopics =[XMGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        
        [self.tableView reloadData];//刷新表格
        
        [self.tableView.mj_footer endRefreshing];//结束刷新
        
        //设置页码
        self.page = page;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params)return ;
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        self.page--;
        //恢复页码
        
        
        /**显示失败信息**/
        //        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
    
}


-(void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;//自动改变透明度
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XMGTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGTopicCellId];
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XMGCommentViewController *cm = [[XMGCommentViewController alloc]init];
    cm.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:cm animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取出帖子模型
    XMGTopic *topic = self.topics[indexPath.row];

    //返回这个模型对应的cell高度
    return topic.cellHeight;
}


@end
