 //
//  XMGRecommendTagCell.m
//  App百思不得姐
//
//  Created by garday on 16/6/18.
//  Copyright © 2016年 garday. All rights reserved.
//

#import "XMGRecommendTagCell.h"
#import "XMGRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface XMGRecommendTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end
@implementation XMGRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setRecommendTag:(XMGRecommendTag *)recommendTag
{
    _recommendTag =  recommendTag ;
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeNameLabel.text = recommendTag.theme_name;

NSString *subNumber = nil;
    if (recommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅",recommendTag.sub_number];
    }else{//大于等于10000
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅",recommendTag.sub_number / 10000.0];
    }
    self.subNumberLabel.text = subNumber;
}

//重写frame
-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -=2 * frame.origin.x ;
    frame.size.height -=1;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
