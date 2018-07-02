//
//  CalculateCacheHeight.h
//  CacheLineHeightModel
//
//  Created by qingweiqw on 16/12/21.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebModel.h"
#import <UIKit/UIKit.h>
@interface CalculateCacheHeight : NSObject
+ (instancetype)calculateCacheHeight;
/**
 * 得到指定模型的行高
 */

- (CGFloat)heigth:(WebModel *)model;
/**
 * 得到模型 对应cell中 子视图的frame
 */
- (NSDictionary *)frameDic:(WebModel *)model;
/// 清除指定 模型的行高和frame缓存
- (void)removeCache:(WebModel *)model;
/// 清除 所有行高和frame缓存
- (void)removeAllCache;

@end
