//
//  ArticleTableCell.m
//  ParseHtmlDemo
//
//  Created by andson-zhw on 17/3/3.
//  Copyright © 2017年 andson. All rights reserved.
//

#import "ArticleTableCell.h"
#import "HomeModel.h"
//#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"

@implementation ArticleTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCellData:(id)data{
    HomeModel *model = (HomeModel *)data;
    
    //头像
    NSURL *avatarIconUrl = [NSURL URLWithString:model.avatar_src];
    [self.avatarIcon sd_setImageWithURL:avatarIconUrl placeholderImage:[UIImage imageNamed:@"icon_tabbar_me_active"]  options:SDWebImageRetryFailed | SDWebImageLowPriority completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            NSLog(@"avatarIconUrl load error:%@",error);
        }
    }];
    
    if (model.wrap_img_src) {
        //文章首图
        NSURL *articleImgUrl = [NSURL URLWithString:model.wrap_img_src];//
        
        [self.articleImgView sd_setImageWithURL:articleImgUrl placeholderImage:[UIImage imageNamed:@"temp"]  options:SDWebImageRetryFailed | SDWebImageLowPriority completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) {
                NSLog(@"articleImgUrl load error:%@",error);
            }
        }];
    }
    
    self.authorName.text = model.avatar_name;
    //处理时间日期
    if (model.data_shared_at) {
        //[self resloveDateString:model.data_shared_at];
    }
    self.timeLab.text = model.data_shared_at;
    
    self.articleContentLab.text = model.title;
    
    self.articleTagLab.text = model.collection_tag;
    self.readNumLab.text = [NSString stringWithFormat:@"阅读:%d",[model.readNum intValue]];
    self.commentsNumLab.text = [NSString stringWithFormat:@"评论:%d",[model.comentsNum intValue]];
    self.likeNumLab.text = [NSString stringWithFormat:@"喜欢:%d",[model.likeNum intValue]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
