//
//  XMGShowPictureViewController.m
//  App百思不得姐
//
//  Created by garday on 16/6/27.
//  Copyright © 2016年 garday. All rights reserved.
//

#import "XMGShowPictureViewController.h"
#import "XMGTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "XMGProgressView.h"

@interface XMGShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet XMGProgressView *progressView;

@end

@implementation XMGShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
/**添加图片**/
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = YES;
    
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
  
/**图片的尺寸**/
    CGFloat pictureW = XMGScreenW;
    CGFloat pictureH = XMGScreenW * self.topic.height /self.topic.width;
    
    if (pictureH > XMGScreenH) {//图片显示高度超过一个频幕,需要滚动查看
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
        
    }else{
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = XMGScreenH * 0.5;
    }
/**马上显示当前图片的下载进度**/
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    
/**下载图片**/
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [self.progressView setProgress:1.0 * receivedSize /expectedSize animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(id)sender {
    
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片并没有下载完成!"];
        return;
    }

    //将图片写入相册
    UIImageWriteToSavedPhotosAlbum( self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error) {
        [SVProgressHUD showSuccessWithStatus:@"保存失败！"];

    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
    }
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
