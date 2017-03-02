//
//  Post.h
//  ParseHtmlDemo
//
//  Created by andson-zhw on 17/3/2.
//  Copyright © 2017年 andson. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ONOXMLElement;

@interface Post : NSObject
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *postDate;
@property (copy,nonatomic) NSString *postUrl;

+(NSArray*)getNewPosts;
+(instancetype)postWithHtmlStr:(ONOXMLElement*)element;
@end
