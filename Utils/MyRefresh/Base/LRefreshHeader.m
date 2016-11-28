//
//  LRefreshHeader.m
//  CSCUtil
//
//  Created by csc on 16/10/9.
//  Copyright © 2016年 csc. All rights reserved.
//  下拉刷新控件：负责监控用户下拉的状态

#import "LRefreshHeader.h"

@interface LRefreshHeader()
@property (assign, nonatomic) CGFloat insetTDelta;
@end


@implementation LRefreshHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)headerWithRefreshingBlock:(LRefreshComponentRefreshingBlock)refreshingBlock;
{
    LRefreshHeader * cmp = [[self alloc]init];
    cmp.refreshingBlock = refreshingBlock;
    return cmp;
}


#pragma mark - 覆盖父类的方法
-(void)prepare
{
    [super prepare];
    //设置key
    self.lastUpdatedTimeKey = LRefreshHeaderLastUpdatedTimeKey;
    //设置高度
    self.l_h = LRefreshHeaderHeight;
}

-(void)placeSubviews
{
    [super placeSubviews];
    
    // 设置y值(当自己的高度发生改变了，肯定要重新调整Y值，所以放到placeSubviews方法中设置y值)
    self.l_y = -self.l_h;//暂时固定 与本身的高度一致
}


-(void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];

    //在刷新的refreshing状态
    if(self.state == LRefreshStateRefreshing)
    {
        if(self.window == nil)return;
        // sectionheader停留解决
//        CGFloat insetT = - self.scrollView.mj_offsetY > _scrollViewOriginalInset.top ? - self.scrollView.mj_offsetY : _scrollViewOriginalInset.top;
//        insetT = insetT > self.mj_h + _scrollViewOriginalInset.top ? self.mj_h + _scrollViewOriginalInset.top : insetT;
//        self.scrollView.mj_insetT = insetT;
        self.scrollView.l_insetT = 118;//刷新的时候悬停
        self.insetTDelta = -54;//暂时写死了
        return;
    }
    // 跳转到下一个控制器时，contentInset可能会变
    _scrollViewOriginalInset = self.scrollView.contentInset;
    
    //当前的contentOffset
    CGFloat offsetY = self.scrollView.contentOffset.y;
    //头部刚好出现的offsetY
    CGFloat happenOffsetY = -self.scrollViewOriginalInset.top;
    //如果是向上滚动到看不见头部文件，直接返回
    if(offsetY > happenOffsetY)return;
    
    //普通和即将刷新的临界点
    CGFloat normal2pullingOffsetY = happenOffsetY-self.l_h;
    CGFloat pullingPercent = (happenOffsetY-offsetY)/self.l_h;
    if(self.scrollView.isDragging)//如果正在拖拽
    {
        self.pullingPercent = pullingPercent;
        if(self.state == LRefreshStateIdle && offsetY < normal2pullingOffsetY)
        {
            //转为即将刷新状态
            self.state = LRefreshStatePulling;
        }else if (self.state == LRefreshStatePulling && offsetY >= normal2pullingOffsetY)
        {
            self.state = LRefreshStateIdle;
        }
    }else if(self.state == LRefreshStatePulling)
    {
        //开始刷新
        [self beginRefreshing];
    }else if (pullingPercent <1)
    {
        self.pullingPercent = pullingPercent;
    }
    
}

-(void)setState:(LRefreshState)state
{
    LRefreshState oldState = self.state;
    if(state == oldState) return;
    [super setState:state];
    
    //根据状态做事情
    if(state == LRefreshStateIdle)//普通状态
    {
        if(oldState != LRefreshStateRefreshing)return;
        // 保存刷新时间
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:self.lastUpdatedTimeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 恢复inset和offset
        [UIView animateWithDuration:LRefreshSlowAnimationDuration animations:^{
            self.scrollView.l_insetT += self.insetTDelta;
//            self.alpha = 0.0;
        }completion:^(BOOL finished) {
            self.pullingPercent = 0.0;
            
//            if (self.endRefreshingCompletionBlock) {
//                self.endRefreshingCompletionBlock();
//            }
        }];
    }else if (state == LRefreshStateRefreshing)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
           [UIView animateWithDuration:LRefreshFastAnimationDuration animations:^{
               CGFloat top = self.scrollViewOriginalInset.top + self.l_h;
               //增加滚动区域top
               self.scrollView.l_insetT = top;
               //设置滚动位置
               [self.scrollView setContentOffset:CGPointMake(0, -top)];
           } completion:^(BOOL finished) {
               [self executeRefreshingCallback];
           }];
        });
    }
   
}

- (NSDate *)lastUpdatedTime
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:self.lastUpdatedTimeKey];
}

@end
