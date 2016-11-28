//
//  LRefreshStateFooter.h
//  CSCUtil
//
//  Created by csc on 16/10/12.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "LRefreshFooter.h"

@interface LRefreshStateFooter : LRefreshFooter
//显示刷新状态的label
@property (strong, nonatomic) UILabel * stateLabel;
//设置state状态下的文字
-(void)setTitle:(NSString *)title forState:(LRefreshState)state;

//获取state状态下的title
-(NSString *)titleForState:(LRefreshState)state;

@end
