//
//  UIImage+CSCategory.m
//  CSCUtil
//
//  Created by csc on 16/8/22.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "UIImage+CSCategory.h"

@implementation UIImage (CSCategory)
/** 设置圆形图片(放到分类中使用) */
- (UIImage *)cutCircleImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 获取上下文
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    // 设置圆形
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctr, rect);
    // 裁剪
    CGContextClip(ctr);
    // 将图片画上去
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  获取bundle中的图片
 */
+(UIImage *)imagesNamedFromName:(NSString *)imgName;
{
    if(![imgName hasSuffix:@"png"])
    {
        imgName = [NSString stringWithFormat:@"%@.png",imgName];
    }
    
    NSString * bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingString:@"/csc.bundle"];
    NSString * filePath = [bundlePath stringByAppendingPathComponent:[NSString stringWithFormat:@"resources/%@",imgName]];
    UIImage *theImage=[UIImage imageWithContentsOfFile:filePath];
    return theImage;
}
@end
