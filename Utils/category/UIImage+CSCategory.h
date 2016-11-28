//
//  UIImage+CSCategory.h
//  CSCUtil
//
//  Created by csc on 16/8/22.
//  Copyright © 2016年 csc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CSCategory)
/** 设置圆形图片(放到分类中使用) */
- (UIImage *)cutCircleImage;

/**
 *  获取bundle中的图片
 */
+(UIImage *)imagesNamedFromName:(NSString *)imgName;
@end
