//
//  XMGRecommendCatrgaryCell.m
//  App百思不得姐
//
//  Created by garday on 16/6/16.
//  Copyright © 2016年 garday. All rights reserved.
//

#import "XMGRecommendCatrgaryCell.h"
#import "XMGRecommendCategory.h"

@interface XMGRecommendCatrgaryCell ()

/**  选中时显示的指示器控件*/
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;


@end

@implementation XMGRecommendCatrgaryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
//当cell的selection为none时，即使cell被选中了，内部子控件也不会进入高亮状态
    //点击文字高亮状态
//    self.textLabel.highlightedTextColor =XMGRGBColor(219, 21, 26);
    
}
-(void)setCategory:(XMGRecommendCategory *)category
{
    _category = category;
    self.textLabel.text = category.name;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    //重新调整textlabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

/**
 可以在这个方法中监听cell的选中和取消选中
 */
-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.selectedIndicator.hidden =!selected;
    self.textLabel.textColor = selected?XMGRGBColor(219, 21, 26):XMGRGBColor(78, 78, 78);
}


@end
