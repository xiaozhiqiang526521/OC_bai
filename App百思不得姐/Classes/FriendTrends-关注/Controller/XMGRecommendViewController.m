//
//  XMGRecommendViewController.m
//  App百思不得姐
//
//  Created by garday on 16/6/16.
//  Copyright © 2016年 garday. All rights reserved.
//

#import "XMGRecommendViewController.h"
#import <AFNetworking.h>
#import <AVFoundation/AVFoundation.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "XMGRecommendCatrgaryCell.h"
#import "XMGRecommendCategory.h"
#import "XMGRecommendUserCell.h"
#import "XMGRecommendUser.h"
#import <MJRefresh.h>
#define XMGSelectedCategory self.actegories[self.categoryTableView.indexPathForSelectedRow.row]
@interface XMGRecommendViewController ()<UITableViewDataSource,UITableViewDelegate  >
{


   
}
/***右边的用户表格  ***/
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/***左边的类别表格 ***/
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/***左边的类别数据 ***/
@property (nonatomic ,strong)NSArray *actegories;
/*** 请求参数 ***/
@property (nonatomic, strong)NSMutableDictionary *params;
/***AFN请求管理者 ***/
@property (nonatomic ,strong)AFHTTPSessionManager *manager;

@end

@implementation XMGRecommendViewController
static NSString *const XMGCategoryId = @"category";
static NSString *const XMGuseryId = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    //网络请求
    [self laodCategories];
    //添加刷新控件
    [self setupRefresh];
    //控件的初始化
    [self setupTableView];
    //
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 懒加载
-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

-(void)setupTableView
{
//注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGRecommendCatrgaryCell class]) bundle:nil] forCellReuseIdentifier:XMGCategoryId]; 
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:XMGuseryId];
    
//设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
//对userTableView的高度设置
    self.userTableView.rowHeight = 70;
    
//设置标题
    self.navigationItem.title = @"推荐关注";
//设置背景色
    self.view.backgroundColor = XMGGlobalBg;
    
//    self.userTableView.tableFooterView
   
}

/**请求的是左侧菜单数据**/
-(void)laodCategories
{
//显示指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//发送网络请求
     NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//隐藏指示器
        [SVProgressHUD dismiss];
//服务器返回的JSON数据
        self.actegories = [XMGRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
//刷新表格
      [self.categoryTableView reloadData];
    
//进入此界面时默认选中第一个
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
       // 让用户表格进入刷新
        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        /**显示失败信息**/
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

/**添加刷新控件**/
-(void)setupRefresh
{
/**顶部刷新**/
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
/**底部刷新**/
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
                                    
 }


/** 时刻监测footer的状态**/
-(void)checkFooterState
{
    XMGRecommendCategory *rc =XMGSelectedCategory;
    
    //每次刷新右边数据时，都控制footer显示或隐藏
    self.userTableView.mj_footer.hidden = (rc.users.count == 0);
    
    //让底部控件结束刷新
    if (rc.users.count == rc.total) {/**全部加载完毕  **/
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else
    {
        [self.userTableView.mj_footer endRefreshing];
    }

}

                  #pragma mark - 加载用户数据
/**顶部网络数据请求**/
-(void)loadNewUsers
{
   
    XMGRecommendCategory *rc = XMGSelectedCategory;
    //设置当前页码为1
    rc.currentPage = 1;
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.ID);
    params[@"page"] = @(rc.currentPage);
    self.params = params;
    //发送请求给服务器，加载右侧的数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典数组->模型数组
        NSArray *users = [XMGRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //清楚所有旧数据
        [rc.users removeAllObjects];
        
        //添加到当前类别的用户数组中
        [rc.users addObjectsFromArray:users];
        
        //保存总数
        rc.total = [responseObject[@"total"]integerValue];
        

/**当用户点击刷新时，且没有刷新完成时单击另一个模块，此方法就会调用，使前一个请求停止请求数据，然后请求最新的模块的数据**/
        if (self.params != params)return ;
//刷新右边表格
    [self.userTableView reloadData];
        
//结束刷新
    [self.userTableView.mj_header endRefreshing];
//让底部控件结束刷新
        [self checkFooterState];
           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//提醒
    [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
//结束刷新
    [self.userTableView.mj_header endRefreshing];
    }];
    
}

/**底部网络数据请求**/
-(void)loadMoreUsers
{
    XMGRecommendCategory *category = XMGSelectedCategory;
    //发送请求给服务器，加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] =@(category.ID);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    //字典数组->模型数组
        NSArray *users = [XMGRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //添加到当前类别的用户数组中
        [category.users addObjectsFromArray:users];
        
        //不是最后一次请求
        if (self.params != params ) return ;

        
        //刷新右边表格
        [self.userTableView reloadData];
        
        //让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params ) return ;
        
        //提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        //让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }];
    
}

                   #pragma mark - 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
/***左边的类别表格 ***/
    if (tableView == self.categoryTableView) return self.actegories.count;
    
/** 时刻监测footer的状态**/
    [self checkFooterState];
   
  return [XMGSelectedCategory users].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
if (tableView == self.categoryTableView) {
/***左边的类别表格 ***/
    XMGRecommendCatrgaryCell *cell =[tableView dequeueReusableCellWithIdentifier:XMGCategoryId];
    
    cell.category = self.actegories[indexPath.row];
        return cell;    }
    
  else{/***右边的用户表格 ***/
        XMGRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGuseryId];
       
        cell.user = [XMGSelectedCategory users][indexPath.row];
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//结束刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    XMGRecommendCategory *c = self.actegories[indexPath.row];
    if (c.users.count) {
//先是曾经的数据
        [self.userTableView reloadData];   }
    
    else{
//赶紧刷新表格，目的是: 马上显示当前category的用户数据，不让用户看见上一个caterory的残留数据
        [self.userTableView reloadData];
    //进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];   }
}


                    #pragma mark - 控制器的销毁
-(void)dealloc{
    
 /**停止所有操作**/
    [self.manager.operationQueue cancelAllOperations];
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
