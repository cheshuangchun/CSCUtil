//
//  LRefreshConst.h
//  CSCUtil
//
//  Created by csc on 16/10/9.
//  Copyright © 2016年 csc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
// 字体大小
#define LRefreshLabelFont [UIFont boldSystemFontOfSize:14]
// RGB颜色
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//屏幕宽高
#define CSWIDTH [UIScreen mainScreen].bounds.size.width
#define CSHEIGHT [UIScreen mainScreen].bounds.size.height

static const CGFloat LRefreshLabelLeftInset = 25;
static const CGFloat LRefreshHeaderHeight = 54.0;
static const CGFloat LRefreshFooterHeight = 44.0;
static const CGFloat LRefreshFastAnimationDuration = 0.25;
static const CGFloat LRefreshSlowAnimationDuration = 0.4;

static NSString *const LRefreshKeyPathContentOffset = @"contentOffset";
static NSString *const LRefreshKeyPathContentInset = @"contentInset";
static NSString *const LRefreshKeyPathContentSize = @"contentSize";
static NSString *const LRefreshKeyPathPanState = @"state";

static NSString *const LRefreshHeaderLastUpdatedTimeKey = @"LRefreshHeaderLastUpdatedTimeKey";


static NSString *const LRefreshHeaderLastTimeText = @"LRefreshHeaderLastTimeText";
static NSString *const LRefreshHeaderDateTodayText = @"LRefreshHeaderDateTodayText";
static NSString *const LRefreshHeaderNoneLastDateText = @"LRefreshHeaderNoneLastDateText";

// 状态检查
#define MJRefreshCheckState \
LRefreshState oldState = self.state; \
if (state == oldState) return; \
[super setState:state];

@interface LRefreshConst : NSObject

@end
