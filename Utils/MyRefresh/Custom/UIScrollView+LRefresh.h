//
//  UIScrollView+LRefresh.h
//  CSCUtil
//
//  Created by csc on 16/10/9.
//  Copyright © 2016年 csc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LRefreshHeader;
@class LRefreshFooter;
@interface UIScrollView (LRefresh)
//下拉刷新控件
@property (strong, nonatomic) LRefreshHeader * l_header;

//上拉加载控件
@property (strong, nonatomic) LRefreshFooter * l_footer;

#pragma mark -other

@end
