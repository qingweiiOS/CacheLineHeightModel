//
//  CalculateCacheHeight.m
//  CacheLineHeightModel
//
//  Created by qingweiqw on 16/12/21.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "CalculateCacheHeight.h"
#import "UIView+Extension.h"
static const CGFloat H = - 1.0;
@interface CalculateCacheHeight ()
//文字frame
@property (nonatomic, assign) CGRect textFrame;
//头像frame
@property (nonatomic, assign) CGRect iconFrame;
//名字frame
@property (nonatomic, assign) CGRect nameFrame;
//VIPframe
@property (nonatomic, assign) CGRect vipFrame;
//图片frame
@property (nonatomic, assign) CGRect imageFrame;
//通过这个模型来算每一个CEll的frame
@property (nonatomic, assign) WebModel *model;
//竖屏缓存
@property (strong,nonatomic) NSCache *cachePortrait;
//横屏缓存 本dome只考虑竖屏
@property (strong,nonatomic) NSCache *cacheLandscape;

@end
@implementation CalculateCacheHeight
+(instancetype)calculateCacheHeight
{
    static CalculateCacheHeight *CCH;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CCH = [[CalculateCacheHeight alloc] init];
    });
    return CCH;
}
- (NSCache *)cachePortrait
{
    if(!_cachePortrait)
    {
        _cachePortrait = [NSCache new];
        // 缓存数据条数
        _cachePortrait.countLimit = 20;
        // 缓存的数据量
        _cachePortrait.totalCostLimit = 1024 * 15;
    }
    return _cachePortrait;
}
///对外接口
- (CGFloat)heigth:(WebModel *)model
{
    _model = model;
    //得到缓存行高
    CGFloat height = [self getCache];
    if(height == H)
    {
        //如果没有缓存 就计算并且缓存
        height = [self cacheHeigth];
    }
    return height;
}
///对外接口
- (NSDictionary *)frameDic:(WebModel *)model
{
    [self heigth:model];
    return [self.cachePortrait objectForKey:model.identifier];

}
//得到 缓存行高
- (CGFloat )getCache
{
    CGFloat height;
    NSDictionary *dic = [self.cachePortrait objectForKey:_model.identifier];
    height = [[dic objectForKey:@"cellHight"] floatValue];
    //如果没有缓存数据
    if(dic == nil)
    {
          height = H;
    }
    return height;
}
//计算行高和控件的frame 并缓存
- (CGFloat)cacheHeigth
{
    //=============计算各个子试图的frame======
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat margin = 15;
    //如果有横屏  那么还需要缓存一套
    //1.头像
    
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    CGFloat iconW = 40;
    CGFloat iconH = iconW;
    
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //2.名字
    CGRect nameRect = [self.model.name boundingRectWithSize:CGSizeMake(1000, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    CGFloat nameX = margin + iconW + iconX;
    CGFloat nameW = nameRect.size.width;
    CGFloat nameH = nameRect.size.height;
    CGFloat nameY = iconY + (iconH / 2.0f) - (nameH / 2.0f);
    self.nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    //3.vip
    CGFloat vipX = nameX + nameW + margin;
    CGFloat vipY = nameY;
    CGFloat vipW = nameH;
    CGFloat VipH = vipW;
    self.vipFrame = CGRectMake(vipX, vipY, vipW, VipH);
    //4.文字内容
    CGRect textRect = [self.model.text boundingRectWithSize:CGSizeMake(W - margin * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    CGFloat textX = iconX;
    CGFloat textY = iconY + iconH + margin;
    CGFloat textW = textRect.size.width;
    CGFloat textH = textRect.size.height;
    self.textFrame = CGRectMake(textX, textY, textW, textH);
    
    //5.图片
    UIImage *image = [UIImage imageNamed:self.model.picture];
    CGFloat imageX = iconX;
    CGFloat imageY = textY +textH +margin;
    //长宽比例
//    NSLog(@"%.2f,%.2f",image.size.height,image.size.width);
//    CGFloat scale = image.size.height/image.size.width;
    
    CGFloat imageW = image.size.width / 3.0f;
    CGFloat imageH = image.size.width / 3.0f;
    self.imageFrame = CGRectMake(imageX, imageY, imageW, imageH);
    CGFloat cellHight = 0.0;
    //6做判断
    if (self.model.picture) {
        
       cellHight = imageY + imageH + margin;
        
    }else{
        
        cellHight = textY +textH + margin;
    }
    NSDictionary *dic = @{@"iconFrame":[NSValue valueWithCGRect:self.iconFrame],
                          @"nameFrame":[NSValue valueWithCGRect:self.nameFrame],
                          @"vipFrame":[NSValue valueWithCGRect:self.vipFrame],
                          @"imageFrame":[NSValue valueWithCGRect:self.imageFrame],
                          @"textFrame":[NSValue valueWithCGRect:self.textFrame],
                          @"cellHight":@(cellHight)};
    //缓存frame 和行高
    [self.cachePortrait setObject:dic forKey:_model.identifier];
    return cellHight;
}
//清除指定模型的行高缓存
- (void)removeCache:(WebModel *)model
{
    [self.cachePortrait removeObjectForKey:model.identifier];
}
//清除所有行高和frame缓存
- (void)removeAllCache
{
    [self.cachePortrait removeAllObjects];
}
@end
