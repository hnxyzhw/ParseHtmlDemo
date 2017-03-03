//
//  NSDate+ZHW.h
//  ParseHtmlDemo
//
//  Created by hongwu zhu on 2017/3/3.
//  Copyright © 2017年 andson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZHW)
/**
 * 比较from和self的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;

@end
