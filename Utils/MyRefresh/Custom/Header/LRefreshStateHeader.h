//
//  LRefreshStateHeader.h
//  CSCUtil
//
//  Created by csc on 16/10/9.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "LRefreshHeader.h"

@interface LRefreshStateHeader : LRefreshHeader
#pragma mark 刷新时间相关
//显示上一次刷新时间的label
@property (strong, nonatomic) UILabel * lastUpdatedTimeLabel;

#pragma mark 状态相关
//文字距离圆圈、箭头的距离
@property (assign, nonatomic) CGFloat labelLeftInset;
//显示刷新状态的label
@property (nonatomic, strong) UILabel * stateLabel;
//设置state状态下的文字
-(void)setTitle:(NSString *)title forState:(LRefreshState)state;
@end
