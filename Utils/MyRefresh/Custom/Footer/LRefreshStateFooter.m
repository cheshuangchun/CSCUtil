//
//  LRefreshStateFooter.m
//  CSCUtil
//
//  Created by csc on 16/10/12.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "LRefreshStateFooter.h"

@interface LRefreshStateFooter()
/**所有状态对应的文字*/
@property (strong, nonatomic) NSMutableDictionary * stateTitles;
@end


@implementation LRefreshStateFooter


#pragma mark -懒加载
-(NSMutableDictionary *)stateTitles
{
    if(!_stateTitles)
    {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

-(UILabel *)stateLabel
{
    if(!_stateLabel)
    {
        self.stateLabel = [UILabel l_label];
        [self addSubview:self.stateLabel];
    }
    return _stateLabel;
}

#pragma mark -公共方法
-(void)setTitle:(NSString *)title forState:(LRefreshState)state
{
    if(title == nil)return;
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

-(NSString *)titleForState:(LRefreshState)state
{
    return self.stateTitles[@(state)];
}

#pragma mark -重写父类的方法
-(void)prepare
{
    [super prepare];
    
    //初始化间距
    
    //初始化文字
    [self setTitle:@"上拉可以加载更多" forState:LRefreshStateIdle];//普通状态
    [self setTitle:@"松开立即加载更多" forState:LRefreshStatePulling];//上拉状态
    [self setTitle:@"正在加载更多的数据..." forState:LRefreshStateRefreshing];//刷新状态
    [self setTitle:@"已经全部加载完毕" forState:LRefreshStateNoMoreData];
    
}


-(void)placeSubviews
{
    [super placeSubviews];
    
    //状态标签frame
    self.stateLabel.frame = self.bounds;
}


-(void)setState:(LRefreshState)state
{
    MJRefreshCheckState
    //设置状态文字
    self.stateLabel.text = self.stateTitles[@(state)];
}

@end
