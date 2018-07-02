//
//  WebModel.m
//  CacheLineHeightModel
//
//  Created by qingweiqw on 16/12/21.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "WebModel.h"

@implementation WebModel
#pragma mark - 初始化方法（模型转字典）
- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        //KVC
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
    
}
@end
