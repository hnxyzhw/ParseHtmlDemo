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
    
//    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSError *error;
//    ONOXMLDocument *doc=[ONOXMLDocument HTMLDocumentWithString:string encoding:NSUTF8StringEncoding error:&error];
    ONOXMLDocument *doc=[ONOXMLDocument HTMLDocumentWithData:data error:&error];
    ///html/body/div[1]/div/div[2]/div[2]/ul
    ///html/body/div[1]/div/div[1]/div[3]/ul
    
    NSString *pathStr = @"/html/body/div[@class='container index']/div[@class='row']/div[@class='col-xs-16 main']/div[@id='list-container']/ul[@class='note-list']";
    ONOXMLElement *postsParentElement= [doc firstChildWithXPath:pathStr];
    [postsParentElement.children enumerateObjectsUsingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL * _Nonnull stop) {
        //NSLog(@"%@",element);
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
        model.wrap_img_blink = [kUrlStr stringByAppendingString:[wrap_imgElement valueForAttribute:@"href"]];
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
                model.avatar_blink = [kUrlStr stringByAppendingString:[avatarElement valueForAttribute:@"href"]];
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
                    model.blue_link = [kUrlStr stringByAppendingString:[blue_linkElement valueForAttribute:@"href"]];
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
            model.title_blink= [kUrlStr stringByAppendingString:[titleElement valueForAttribute:@"href"]];
            model.title= [titleElement stringValue];
        }
        
        //4内容
        ONOXMLElement *abstractElement = [contentElement firstChildWithXPath:@"p"];
        if (authorElement) {
            model.abstract = [abstractElement stringValue];
        }
        
        //5底部标签
        //ONOXMLElement *metaElement = [contentElement firstChildWithXPath:@"div[@class='meta']/a[@class='collection-tag']"];
        ONOXMLElement *collection_tagElement = [contentElement firstChildWithXPath:@"div[@class='meta']/a[@class='collection-tag']"];
        if (collection_tagElement) {
            model.collection_tag_blank = [kUrlStr stringByAppendingString:[collection_tagElement valueForAttribute:@"href"]];
            model.collection_tag = [collection_tagElement stringValue];
        }
        
        ONOXMLElement *readNumElement = [contentElement firstChildWithXPath:@"div[@class='meta']/a[2]"];
        if (readNumElement) {
            model.readNum = [readNumElement stringValue];
            model.read_blank = [kUrlStr stringByAppendingString:[readNumElement valueForAttribute:@"href"]];
        }
        
        ONOXMLElement *commentsElement = [contentElement firstChildWithXPath:@"div[@class='meta']/a[3]"];
        if (contentElement) {
            model.comments_blank = [kUrlStr stringByAppendingString:[commentsElement valueForAttribute:@"href"]];
            model.comentsNum = [commentsElement stringValue];
        }
        
        ONOXMLElement *likeElement = [contentElement firstChildWithXPath:@"div[@class='meta']/span"];
        if (likeElement) {
            model.likeNum = [likeElement stringValue];
        }
    }
    
    return model;
}


//-(void)setTitle_blink:(NSString *)title_blink{
//    _title_blink = [kUrlStr stringByAppendingString:title_blink];
//}
//
//-(void)setWrap_img_blink:(NSString *)wrap_img_blink{
//    _wrap_img_blink = [kUrlStr stringByAppendingString:wrap_img_blink];
//}
//
//-(void)setAvatar_blink:(NSString *)avatar_blink{
//    _avatar_blink = [kUrlStr stringByAppendingString:avatar_blink];
//}
//
//-(void)setBlue_link:(NSString *)blue_link{
//    _blue_link = [kUrlStr stringByAppendingString:blue_link];
//}
//
//-(void)setCollection_tag_blank:(NSString *)collection_tag_blank{
//    _collection_tag_blank = [kUrlStr stringByAppendingString:collection_tag_blank];
//}
//
//-(void)setRead_blank:(NSString *)read_blank{
//    _read_blank = [kUrlStr stringByAppendingString:read_blank];
//}
//
//-(void)setComments_blank:(NSString *)comments_blank{
//    if (!comments_blank) {
//        return;
//    }
//    _comments_blank = [kUrlStr stringByAppendingString:comments_blank];
//}

@end
