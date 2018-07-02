//
//  WebModel.h
//  CacheLineHeightModel
//
//  Created by qingweiqw on 16/12/21.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebModel : NSObject

//唯一标识(id)
@property (nonatomic, copy) NSString *identifier;

//文字
@property (nonatomic, copy) NSString *text;

//头像
@property (nonatomic, copy) NSString *icon;

//图片
@property (nonatomic, copy) NSString *picture;

//名字
@property (nonatomic, copy) NSString *name;

//是否是VIP
@property (nonatomic, assign) BOOL vip;

//通过一个字典来存储模型
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
