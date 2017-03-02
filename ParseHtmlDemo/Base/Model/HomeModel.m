//
//  HomeModel.m
//  ParseHtmlDemo
//
//  Created by hongwu zhu on 2017/3/2.
//  Copyright © 2017年 andson. All rights reserved.
//

#import "HomeModel.h"
#import <Ono.h>

static NSString *const kUrlStr=@"http://www.jianshu.com";

@implementation HomeModel
+(NSArray*)getNewPosts{
    NSMutableArray *array=[NSMutableArray array];
    NSData *data= [NSData dataWithContentsOfURL:[NSURL URLWithString:kUrlStr]];
    
    NSError *error;
    ONOXMLDocument *doc=[ONOXMLDocument HTMLDocumentWithData:data error:&error];
    ONOXMLElement *postsParentElement= [doc firstChildWithXPath:@"/html/body/div[1]/div/div[1]/div[3]/ul"];
    [postsParentElement.children enumerateObjectsUsingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",element);
        HomeModel *model = [HomeModel postWithHtmlStr:element];
        if(model){
            [array addObject:model];
        }
    }];
    return array;
}

+(instancetype)postWithHtmlStr:(ONOXMLElement*)element{
    
    HomeModel *model = [HomeModel new];
    
    //1右侧文章图片节点
    ONOXMLElement *wrap_imgElement = [element firstChildWithTag:@"a"];
    if (wrap_imgElement) {
        model.wrap_img_blink = [wrap_imgElement valueForAttribute:@"href"];
        ONOXMLElement *wrap_imgSrcElement = [wrap_imgElement firstChildWithTag:@"img"];
        if (wrap_imgSrcElement) {
             model.wrap_img_src = [wrap_imgSrcElement valueForAttribute:@"src"];
        }
    }
    
    //2文章信息节点
    ONOXMLElement *contentElement = [element firstChildWithTag:@"div"];
    if (contentElement) {
        //作者信息节点
        ONOXMLElement *authorElement = [contentElement firstChildWithXPath:@"div[1]"];
        if (authorElement) {
            //2.1作者头像节点
            ONOXMLElement  *avatarElement = [authorElement firstChildWithXPath:@"a"];
            if (avatarElement) {
                model.avatar_blink = [avatarElement valueForAttribute:@"href"];
                ONOXMLElement *avatarImgSrcElement = [avatarElement firstChildWithTag:@"img"];
                if (avatarImgSrcElement) {
                    model.avatar_src = [avatarImgSrcElement valueForAttribute:@"src"];
                    model.avatar_alt = [avatarImgSrcElement valueForAttribute:@"alt"];
                }

            }
            
            
            //2.2作者名字信息
            ONOXMLElement *nameElement = [authorElement firstChildWithTag:@"div"];
            if (nameElement) {
                //2.2.1作者名字
                ONOXMLElement *blue_linkElement = [nameElement firstChildWithTag:@"a"];
                if (blue_linkElement) {
                    model.avatar_name = [blue_linkElement stringValue];
                    model.blue_link = [blue_linkElement valueForAttribute:@"href"];
                }
                
                //2.2.2时间信息
                ONOXMLElement *timeElement = [nameElement firstChildWithTag:@"span"];
                if (timeElement) {
                    model.data_shared_at = [timeElement valueForAttribute:@"data-shared-at"];
                    model.time = [timeElement stringValue];
                }
            }
 
        }
        
        
        //3标题
        ONOXMLElement *titleElement= [contentElement firstChildWithTag:@"a"];
        if (titleElement) {
            model.title_blink= [titleElement valueForAttribute:@"href"];
            model.title= [titleElement stringValue];
        }
        
        //4内容
        ONOXMLElement *abstractElement = [contentElement firstChildWithXPath:@"p"];
        if (authorElement) {
            model.abstract = [abstractElement stringValue];
        }
        
        //
    }
    
    
    
    
    //    ONOXMLElement *dateElement= [element firstChildWithXPath:@"div[2]/span[1]"];
    //    p.postDate= [dateElement stringValue];
    return model;
}


-(void)setTitle_blink:(NSString *)title_blink{
    _title_blink = [kUrlStr stringByAppendingString:title_blink];
}

-(void)setWrap_img_blink:(NSString *)wrap_img_blink{
    _wrap_img_blink = [kUrlStr stringByAppendingString:wrap_img_blink];
}

-(void)setAvatar_blink:(NSString *)avatar_blink{
    _avatar_blink = [kUrlStr stringByAppendingString:avatar_blink];
}

-(void)setBlue_link:(NSString *)blue_link{
    _blue_link = [kUrlStr stringByAppendingString:blue_link];
}
@end
