//
//  WebTableViewCell.h
//  CacheLineHeightModel
//
//  Created by qingweiqw on 16/12/21.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebModel.h"

@interface WebTableViewCell : UITableViewCell
@property(nonatomic,strong) WebModel *model;
@property(nonatomic,strong) NSDictionary *frameDic;
@end
