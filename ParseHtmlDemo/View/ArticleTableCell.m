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
    
    NSURL *avatarIconUrl = [NSURL URLWithString:model.wrap_img_src];
    
//    [self.avatarIcon sd_setImageWithURL:avatarIconUrl placeholderImage:[UIImage imageNamed:@"icon_tabbar_me_active"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        
//    }];
    [self.avatarIcon sd_setImageWithURL:avatarIconUrl placeholderImage:[UIImage imageNamed:@"icon_tabbar_me_active"]  options:SDWebImageRetryFailed | SDWebImageLowPriority completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            NSLog(@"avatarIconUrl load error:%@",error);
        }
    }];
    
    NSURL *articleImgUrl = [NSURL URLWithString:model.avatar_src];
    
    [self.articleImgView sd_setImageWithURL:articleImgUrl placeholderImage:[UIImage imageNamed:@"temp"]  options:SDWebImageRetryFailed | SDWebImageLowPriority completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            NSLog(@"articleImgUrl load error:%@",error);
        }
    }];
//    [self.articleImgView sd_setImageWithURL:articleImgUrl placeholderImage:[UIImage imageNamed:@"temp"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        if (error) {
//            NSLog(@"articleImgUrl load error:%@",error);
//        }
//       
//    }];
    
    self.authorName.text = model.avatar_name;
    self.timeLab.text = model.data_shared_at;
    self.articleContentLab.text = model.title;
    [self.articleTypeBtn setTitle:model.collection_tag forState:UIControlStateNormal];
    self.readNumLab.text = [NSString stringWithFormat:@"阅读:%@",model.readNum];
    self.commentsNumLab.text = [NSString stringWithFormat:@"评论:%@",model.comentsNum];
    self.likeNumLab.text = [NSString stringWithFormat:@"喜欢:%@",model.likeNum];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
