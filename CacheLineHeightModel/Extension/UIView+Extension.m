//
//  UIView+Extension.m
//  恶犬
//  微微卿 制作
//  Created by qingweiqw on 16/12/19.
//  qingweiqw
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
/**
 *  切指定角位圆角
 *
 *  @param corner       UIRectCorner
 *  @param cornerRadius 圆角值
 */
- (void)clipsRectCorner:(UIRectCorner )corner cornerRadius:(CGFloat)cornerRadius
{
    CGSize cornerSize = CGSizeMake(cornerRadius, cornerRadius);
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds   byRoundingCorners:corner cornerRadii:cornerSize];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
     maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
//修改图片大小_ OC
- (UIImage *)scaleImage:(UIImage *)img ToSize:(CGSize)itemSize{
    UIImage *i;
    // 创建一个bitmap的context,并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect=CGRectMake(0, 0, itemSize.width, itemSize.height);
    // 绘制改变大小的图片
    [img drawInRect:imageRect];
    // 从当前context中创建一个改变大小后的图片
    i=UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return i;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

@end
