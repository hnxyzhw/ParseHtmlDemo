//
//  HomeModel.m
//  ParseHtmlDemo
//
//  Created by hongwu zhu on 2017/3/2.
//  Copyright © 2017年 andson. All rights reserved.
//

#import "HomeModel.h"
#import <Ono.h>
#import "NSDate+ZHW.h"

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
    
//    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
//    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    
    HomeModel *model = [HomeModel new];
    
    //1右侧文章图片节点
    ONOXMLElement *wrap_imgElement = [element firstChildWithTag:@"a"];
    if (wrap_imgElement) {
        model.wrap_img_blink = [kUrlStr stringByAppendingString:[wrap_imgElement valueForAttribute:@"href"]];
        ONOXMLElement *wrap_imgSrcElement = [wrap_imgElement firstChildWithTag:@"img"];
        if (wrap_imgSrcElement) {
            //替换图片链接里的“|”为“/"
            NSString *wrap_imgStr = [[wrap_imgSrcElement valueForAttribute:@"src"] stringByReplacingOccurrencesOfString:@"|" withString:@"/"] ;
             model.wrap_img_src = wrap_imgStr;
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
                    //替换图片链接里的“|”为“/"
                    NSString *avatarStr = [[avatarImgSrcElement valueForAttribute:@"src"] stringByReplacingOccurrencesOfString:@"|" withString:@"/"] ;
                    model.avatar_src = avatarStr;
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
                    model.data_shared_at = [self resloveDateString:[timeElement valueForAttribute:@"data-shared-at"]];
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
        
        //5底部标签
        //ONOXMLElement *metaElement = [contentElement firstChildWithXPath:@"div[@class='meta']/a[@class='collection-tag']"];
        ONOXMLElement *collection_tagElement = [contentElement firstChildWithXPath:@"div[@class='meta']/a[@class='collection-tag']"];
        if (collection_tagElement) {
            model.collection_tag_blank = [collection_tagElement valueForAttribute:@"href"];
            model.collection_tag = [collection_tagElement stringValue];
        }
        
        ONOXMLElement *readNumElement = [contentElement firstChildWithXPath:@"div[@class='meta']/a[2]"];
        if (readNumElement) {
            NSString *str = [readNumElement stringValue];
            str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
            str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            model.readNum = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
            model.read_blank = [kUrlStr stringByAppendingString:[readNumElement valueForAttribute:@"href"]];
        }
        
        ONOXMLElement *commentsElement = [contentElement firstChildWithXPath:@"div[@class='meta']/a[3]"];
        if (contentElement) {
            model.comments_blank = [commentsElement valueForAttribute:@"href"];//[kUrlStr stringByAppendingString:];
            NSString *str = [commentsElement stringValue];
            str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
            str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            model.comentsNum = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
        
        ONOXMLElement *likeElement = [contentElement firstChildWithXPath:@"div[@class='meta']/span"];
        if (likeElement) {
            NSString *str = [commentsElement stringValue];
            str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
            str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            model.likeNum = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
    }
    
    return model;
}


-(void)setTitle_blink:(NSString *)title_blink{
    if (!title_blink) {
        return;
    }
    _title_blink = [kUrlStr stringByAppendingString:title_blink];
}

-(void)setWrap_img_blink:(NSString *)wrap_img_blink{
    if (!wrap_img_blink) {
        return;
    }
    _wrap_img_blink = [kUrlStr stringByAppendingString:wrap_img_blink];
}

-(void)setAvatar_blink:(NSString *)avatar_blink{
    if (!avatar_blink) {
        return;
    }
    _avatar_blink = [kUrlStr stringByAppendingString:avatar_blink];
}

-(void)setBlue_link:(NSString *)blue_link{
    if (!blue_link) {
        return;
    }
    _blue_link = [kUrlStr stringByAppendingString:blue_link];
}

-(void)setCollection_tag_blank:(NSString *)collection_tag_blank{
    if (!collection_tag_blank) {
        return;
    }
    _collection_tag_blank = [kUrlStr stringByAppendingString:collection_tag_blank];
}

-(void)setRead_blank:(NSString *)read_blank{
    if (!read_blank) {
        return;
    }
    _read_blank = [kUrlStr stringByAppendingString:read_blank];
}

-(void)setComments_blank:(NSString *)comments_blank{
    if (!comments_blank) {
        return;
    }
    _comments_blank = [kUrlStr stringByAppendingString:comments_blank];
}


#pragma mark - 处理日期
+(NSString *)resloveDateString:(NSString *)dateString{
    //NSArray *dateArr = [dateString componentsSeparatedByString:@"T"];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    //NSString *currentDateString = @"2014-01-08T21:21:22.737+05:30";
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZ"];
    NSDate *currentDate = [dateFormatter dateFromString:dateString];
    
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *newDateStr = [dateFormatter stringFromDate:currentDate];
    //NSLog(@"CurrentDate:%@", currentDate);
    return [self createtimeWith:newDateStr];
}

+ (NSString *)createtimeWith:(NSString *)sourceTimeStr
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间_create_time 是返回的时间;
    NSDate *create = [fmt dateFromString:sourceTimeStr];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return sourceTimeStr;
    }
}

@end
