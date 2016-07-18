//
//  XMGRecommendUserCell.m
//  App百思不得姐
//
//  Created by garday on 16/6/17.
//  Copyright © 2016年 garday. All rights reserved.
//

#import "XMGRecommendUserCell.h"
#import "XMGRecommendUser.h"
#import <UIImageView+WebCache.h>
@interface XMGRecommendUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;


@end
@implementation XMGRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setUser:(XMGRecommendUser *)user
{
    _user = user;
    self.screenNameLabel.text = user.screen_name;
   
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    NSString *fansCount = nil;
    if (user.fans_count < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    }else{//大于等于10000
        fansCount = [NSString stringWithFormat:@"%.1f万人关注",user.fans_count / 10000.0];
    }
    self.fansCountLabel.text = fansCount;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
