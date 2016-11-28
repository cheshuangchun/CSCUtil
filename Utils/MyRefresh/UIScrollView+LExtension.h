//
//  UIScrollView+LExtension.h
//  CSCUtil
//
//  Created by csc on 16/10/10.
//  Copyright © 2016年 csc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (LExtension)
@property (assign, nonatomic) CGFloat l_insetT;
@property (assign, nonatomic) CGFloat l_insetB;
@property (assign, nonatomic) CGFloat l_insetL;
@property (assign, nonatomic) CGFloat l_insetR;

@property (assign, nonatomic) CGFloat l_offsetX;
@property (assign, nonatomic) CGFloat l_offsetY;

@property (assign, nonatomic) CGFloat l_contentW;
@property (assign, nonatomic) CGFloat l_contentH;
@end
