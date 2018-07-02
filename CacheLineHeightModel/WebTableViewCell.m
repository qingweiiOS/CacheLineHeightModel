//
//  WebTableViewCell.m
//  CacheLineHeightModel
//
//  Created by qingweiqw on 16/12/21.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "WebTableViewCell.h"

@interface WebTableViewCell()
{
    
    UIImageView *_iconImge;
    
    UILabel *_nameLabel;
    
    UIImageView *_vipImage;
    
    UILabel *_textLabel;
    
    UIImageView *_imagePricture;
}
@end

@implementation WebTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _iconImge = [[UIImageView alloc]init];
        [self.contentView addSubview:_iconImge];
        _nameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_nameLabel];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _vipImage =[[ UIImageView alloc]init];
        [self.contentView addSubview:_vipImage];
        _vipImage.image = [UIImage imageNamed:@"vip"];
        _textLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_textLabel];
        _textLabel.numberOfLines = 0;
        _textLabel.font = [UIFont systemFontOfSize:14];
        _imagePricture  = [[UIImageView alloc]init];
        
        [self.contentView addSubview:_imagePricture];
    }
   return self;
}
#pragma mark - 重写set方法，给成员变量赋值
- (void)setModel:(WebModel *)model{
    
    _model = model;
    
    _iconImge.image = [UIImage imageNamed:self.model.icon];
    
    _nameLabel.text = self.model.name;
    
    if (_model.vip) {
        
        _vipImage.hidden = NO;
        _nameLabel.textColor = [UIColor redColor];
        
        
    }else{
        
        _vipImage.hidden = YES;
        _nameLabel.textColor = [UIColor blackColor];
    }
    
    _textLabel.text =  self.model.text;
    
    _imagePricture.image = [UIImage imageNamed:self.model.picture];

}
- (void)setFrameDic:(NSDictionary *)frameDic
{
         _frameDic = frameDic;
         _iconImge.frame = [[self.frameDic objectForKey:@"iconFrame"] CGRectValue];
        _nameLabel.frame = [[self.frameDic objectForKey:@"nameFrame"] CGRectValue];
        _vipImage.frame = [[self.frameDic objectForKey:@"vipFrame"] CGRectValue];
        
        _textLabel.frame = [[self.frameDic objectForKey:@"textFrame"] CGRectValue];
        _imagePricture.frame = [[self.frameDic objectForKey:@"imageFrame"] CGRectValue];
    
}
#pragma mark - 计算frame


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
