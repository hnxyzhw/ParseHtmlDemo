//
//  HomeModel.h
//  ParseHtmlDemo
//
//  Created by hongwu zhu on 2017/3/2.
//  Copyright © 2017年 andson. All rights reserved.
//

#import "BaseModel.h"

@interface HomeModel : BaseModel
@property (copy,nonatomic) NSString *wrap_img_src;
@property (copy,nonatomic) NSString *wrap_img_blink;

@property (copy,nonatomic) NSString *avatar_blink;
@property (copy,nonatomic) NSString *avatar_src;
@property (copy,nonatomic) NSString *avatar_alt;

@property (copy,nonatomic) NSString *blue_link;
@property (copy,nonatomic) NSString *avatar_name;

@property (copy,nonatomic) NSString *data_shared_at;
@property (copy,nonatomic) NSString *time;

@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *title_blink;

@property (copy,nonatomic) NSString *abstract;
@property (copy,nonatomic) NSString *postDate;

+(NSArray*)getNewPosts;
//+(instancetype)postWithHtmlStr:(ONOXMLElement*)element;
@end
