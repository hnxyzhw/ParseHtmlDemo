//
//  HomeModel.h
//  ParseHtmlDemo
//
//  Created by hongwu zhu on 2017/3/2.
//  Copyright © 2017年 andson. All rights reserved.
//

#import "BaseModel.h"

@interface HomeModel : BaseModel
 /** 文章作者头像图片地址*/
@property (copy,nonatomic) NSString *wrap_img_src;
 /** 文章作者头像个人链接*/
@property (copy,nonatomic) NSString *wrap_img_blink;

 /** 文章首图图片链接*/
@property (copy,nonatomic) NSString *avatar_blink;
 /** 文章首图图片url地址*/
@property (copy,nonatomic) NSString *avatar_src;
 /** 图片尺寸*/
@property (copy,nonatomic) NSString *avatar_alt;

 /** 文章作者链接*/
@property (copy,nonatomic) NSString *blue_link;
 /** 文章作者姓名*/
@property (copy,nonatomic) NSString *avatar_name;

 /** 文章发布时间,日期格式*/
@property (copy,nonatomic) NSString *data_shared_at;
 /** 发布时间，小时*/
@property (copy,nonatomic) NSString *time;

 /** 文章标题*/
@property (copy,nonatomic) NSString *title;
 /** 文章标题链接*/
@property (copy,nonatomic) NSString *title_blink;

 /** 文章简要内容*/
@property (copy,nonatomic) NSString *abstract;

 /** 文章分类标签租链接*/
@property (copy,nonatomic) NSString *collection_tag_blank;
 /** 文章分类标签*/
@property (copy,nonatomic) NSString *collection_tag;

 /** 阅读链接*/
@property (copy,nonatomic) NSString *read_blank;
 /** 阅读人数*/
@property (copy,nonatomic) NSString *readNum;

 /** 评论链接*/
@property (copy,nonatomic) NSString *comments_blank;
 /** 评论数*/
@property (copy,nonatomic) NSString *comentsNum;

 /** 点赞数*/
@property (copy,nonatomic) NSString *likeNum;


@property (copy,nonatomic) NSString *postDate;

+(NSArray*)getNewPosts;
//+(instancetype)postWithHtmlStr:(ONOXMLElement*)element;
@end
