//
//  XMGVEssenceiewController.m
//  App百思不得姐
//
//  Created by garday on 16/6/15.
//  Copyright © 2016年 garday. All rights reserved.
//

#import "XMGVEssenceiewController.h"
#import "XMGRecommendTagsViewController.h"
#import "XMGTopicController.h"


@interface XMGVEssenceiewController ()<UIScrollViewDelegate>
/***标签栏底部的红色指示器 ***/
@property (nonatomic ,weak)UIView *indicatorview;
/***当前选中的按钮 ***/
@property (nonatomic ,weak)UIButton *selectedButton;
/*** 顶部的所有标签 ***/
@property (nonatomic ,weak)UIView *titlesView;
/*** 底部的所有内容 ***/
@property (nonatomic ,weak)UIScrollView *contentView;

@end

@implementation XMGVEssenceiewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNva];   //设置导航栏
    
    [self setupChildVces]; //初始化子控制器
    
    [self setupTitlesView]; //设置顶部标签栏
    
    [self setupContentView]; //底部scrollview
    
  
    
 
}


                             /**设置导航栏**/

-(void)setupNva
{
    self.view.backgroundColor = XMGGlobalBg;
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    //设置导航栏左边的按钮
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}

-(void)tagClick
{
    XMGRecommendTagsViewController *tags =[[XMGRecommendTagsViewController alloc]init];
    [self.navigationController pushViewController:tags animated:YES];
}


                        /**设置顶部标签栏**/

-(void)setupTitlesView
{
    //标签栏整体
    UIView *titlesView = [[UIView alloc]init];
    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.7];
    titlesView.width = self.view.width;
    titlesView.height = XMGTitilesViewH;
    titlesView.y = XMGTitilesViewY;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    
    //底部红色指示器
    UIView *indicatorView = [[UIView alloc]init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorview = indicatorView;

    
    //内部子标签
   
    CGFloat width = titlesView.width/self.childViewControllers.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        UIButton *button =[  [UIButton alloc]init];
        button.tag = i;
        button.height = height;
        button.width = width ;
        button.x = i * width;
        UIViewController *vc = self.childViewControllers[i];
        
        [button setTitle:vc.title forState:UIControlStateNormal];
//        [button layoutIfNeeded]; //强制布局（强制更新子控件的frame ）
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [button addTarget:self action:@selector(titlesClicked:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        //默认选中点击第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
        [button.titleLabel sizeToFit]; // 让按钮内部label根据文字内容来计算尺寸
            self.indicatorview.width = button.titleLabel.width;
            self.indicatorview.centerX =button.centerX;
        }
    }
    [titlesView addSubview:indicatorView];
 }

#pragma mark - 点击事件
-(void)titlesClicked:(UIButton *)button
{
/**修改按钮状态**/
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorview.width = button.titleLabel.width;
        self.indicatorview.centerX =button.centerX;
    }];
    
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x =button.tag *self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

                         /**底部scrollview**/

-(void)setupContentView
{
    //不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc]init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;//分页
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;

    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

                               /**初始化子控制器**/

-(void)setupChildVces
{
    XMGTopicController *All = [[XMGTopicController alloc]init];
    All.title = @"全部";
    All.type = XMGTopicTypeAll;
    [self addChildViewController:All];
    
    XMGTopicController *Video = [[XMGTopicController alloc]init];
      Video.title = @"视频";
    Video.type = XMGTopicTypeVideo;
    [self addChildViewController:Video];
    
    XMGTopicController *Voice = [[XMGTopicController alloc]init];
    Voice.title =@"声音";
    Voice.type = XMGTopicTypeVoice;
    [self addChildViewController:Voice];
    
    XMGTopicController *Picture = [[XMGTopicController alloc]init];
    Picture.title = @"图片";
    Picture.type = XMGTopicTypePicture;
    [self addChildViewController:Picture];
    
    XMGTopicController *Word = [[XMGTopicController alloc]init];
      Word.title = @"段子";
    Word.type = XMGTopicTypeWord;

    [self addChildViewController:Word];
    
}

#pragma mark - <uiscrollView代理>
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //添加子控制器view
    
    //当前的索引
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    
    //取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x= scrollView.contentOffset.x;
    vc.view.y = 0; //设置控制器view的y值为0（默认是20）；
    vc.view.height = scrollView.height;
    [scrollView addSubview:vc.view];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //点击按钮
    NSInteger index =scrollView.contentOffset.x / scrollView.width;
    [self titlesClicked:self.titlesView.subviews[index]];
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
