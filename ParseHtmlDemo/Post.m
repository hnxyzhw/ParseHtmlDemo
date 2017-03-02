//
//  Post.m
//  ParseHtmlDemo
//
//  Created by andson-zhw on 17/3/2.
//  Copyright © 2017年 andson. All rights reserved.
//

#import "Post.h"
#import <Ono.h>

static NSString *const kUrlStr=@"http://www.jianshu.com";

@implementation Post
+(NSArray*)getNewPosts{
    NSMutableArray *array=[NSMutableArray array];
    NSData *data= [NSData dataWithContentsOfURL:[NSURL URLWithString:kUrlStr]];
    
    NSError *error;
    ONOXMLDocument *doc=[ONOXMLDocument HTMLDocumentWithData:data error:&error];
    ONOXMLElement *postsParentElement= [doc firstChildWithXPath:@"/html/body/div[1]/div/div[1]/div[3]/ul"];
    [postsParentElement.children enumerateObjectsUsingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"%@",element);
        Post *post=[Post postWithHtmlStr:element];
        if(post){
            [array addObject:post];
        }
    }];
    return array;
}

+(instancetype)postWithHtmlStr:(ONOXMLElement*)element{
    
    Post *p=[Post new];
    ONOXMLElement *titleElement= [element firstChildWithXPath:@"div/a"];
    p.postUrl= [titleElement valueForAttribute:@"href"];
    p.title= [titleElement stringValue];
//    ONOXMLElement *dateElement= [element firstChildWithXPath:@"div[2]/span[1]"];
//    p.postDate= [dateElement stringValue];
    return p;
}

-(void)setPostUrl:(NSString *)postUrl{
    _postUrl=[kUrlStr stringByAppendingString:postUrl];
}
@end
