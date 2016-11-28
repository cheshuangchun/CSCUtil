//
//  LRefreshFooter.m
//  CSCUtil
//
//  Created by csc on 16/10/11.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "LRefreshFooter.h"

@interface LRefreshFooter()
@property (assign, nonatomic) CGFloat lastBottomDelta;
@end

@implementation LRefreshFooter

//创建footer
+(instancetype)footerWithRefreshingBlock:(LRefreshComponentRefreshingBlock)refreshingBlock;
{
    LRefreshFooter * cmp = [[self alloc]init];
    cmp.refreshingBlock = refreshingBlock;
    return cmp;
}

#pragma mark 重写父类的方法
-(void)prepare
{
    [super prepare];
    //设置高度
    self.l_h = LRefreshFooterHeight;
    //默认不会自动隐藏
    
    
    
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
}

#pragma mark 实现父类的方法
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    [super scrollViewContentOffsetDidChange:change];
    
    //如果正在刷新，直接返回
    if(self.state == LRefreshStateRefreshing)return;
    
    _scrollViewOriginalInset = self.scrollView.contentInset;
    //当前的contentOffset
    CGFloat currentOffsetY = self.scrollView.l_offsetY;
    
    //尾部控件刚好出现的offsetY
    CGFloat happenOffsetY = [self happenOffsetY];//self.scrollView.contentSize.height - self.scrollView.frame.size.height;
    //如果是向下滚动到看不见尾部控件，直接返回
    if(currentOffsetY <= happenOffsetY)return;
    //上拉百分比
    CGFloat pullingPercent = (currentOffsetY-happenOffsetY)/self.l_h;
    
    //如果已经全部加载，仅仅设置pullingPercent,然后返回
    if(self.state == LRefreshStateNoMoreData)
    {
        self.pullingPercent = pullingPercent;
        return;
    }
    
    if(self.scrollView.isDragging)
    {
        self.pullingPercent = pullingPercent;
        //普通和即将刷新的临界点
        CGFloat normal2pullingOffsetY = happenOffsetY + self.l_h;
        NSLog(@"normal2pullingOffsetY ===================%f",normal2pullingOffsetY);
        if(self.state == LRefreshStateIdle && currentOffsetY > normal2pullingOffsetY)
        {
            //转为即将刷新状态
            self.state = LRefreshStatePulling;
        }else if (self.state == LRefreshStatePulling && currentOffsetY <= normal2pullingOffsetY)
        {
            //转为普通状态
            self.state = LRefreshStateIdle;
        }
    
    }else if (self.state == LRefreshStatePulling)//即将刷新
    {
      //开始刷新
        [self beginRefreshing];
    }else if (pullingPercent <1)
    {
        self.pullingPercent = pullingPercent;
    }
}

-(void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
//    // 内容的高度
//    CGFloat contentHeight = self.scrollView.mj_contentH + self.ignoredScrollViewContentInsetBottom;
//    // 表格的高度
//    CGFloat scrollHeight = self.scrollView.mj_h - self.scrollViewOriginalInset.top - self.scrollViewOriginalInset.bottom + self.ignoredScrollViewContentInsetBottom;
//    // 设置位置和尺寸
//    self.mj_y = MAX(contentHeight, scrollHeight);
    
    CGFloat contentHeight = self.scrollView.l_contentH;
    CGFloat scrollheight = self.scrollView.l_h- self.scrollViewOriginalInset.top;
    
    
    
    self.l_y = MAX(contentHeight, scrollheight);
}

-(void)setState:(LRefreshState)state
{
    //将当前的状态赋值给 oldState
    MJRefreshCheckState
    
    //根据状态来设置属性
    if(state == LRefreshStateNoMoreData || state == LRefreshStateIdle)
    {
        //刷新完毕
        if(oldState == LRefreshStateRefreshing)
        {
            [UIView animateWithDuration:LRefreshSlowAnimationDuration animations:^{
                //self.scrollView.l_insetB = 0;
                self.scrollView.l_insetB -= self.lastBottomDelta;
//                NSLog(@"hh:%f==============inB:%f",self.lastBottomDelta,self.scrollView.l_insetB);
            } completion:^(BOOL finished) {
                self.pullingPercent = 0.0;
    
            }];
        }
        
        if(oldState == LRefreshStateRefreshing && state == LRefreshStateNoMoreData)
        {
            self.scrollView.l_insetB = 44 ;
        }
        
    }else if(state == LRefreshStateRefreshing)
    {
        
        [UIView animateWithDuration:LRefreshSlowAnimationDuration animations:^{
            CGFloat bottom = self.l_h + self.scrollViewOriginalInset.bottom;
            CGFloat deltaH = [self heightForContentBreakView];
            if (deltaH < 0) { // 如果内容高度小于view的高度
                bottom -= deltaH;
            }
            self.lastBottomDelta = bottom - self.scrollView.l_insetB;
            self.scrollView.l_insetB = bottom;
            self.scrollView.l_offsetY = [self happenOffsetY] + self.l_h;
        } completion:^(BOOL finished) {
            [self executeRefreshingCallback];
        }];
        
        
        
    }
}


#pragma mark -公共方法
-(void)endRefreshingWithNoMoreData
{
    self.state = LRefreshStateNoMoreData;
}

-(void)resetNoMoreData
{
    self.state = LRefreshStateIdle;
}

#pragma mark -私有方法
#pragma mark 获得scrollView的内容 超出 view 的高度
#pragma mark - 私有方法
#pragma mark 获得scrollView的内容 超出 view 的高度
- (CGFloat)heightForContentBreakView
{
    CGFloat h = self.scrollView.frame.size.height - self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top;
    NSLog(@"height:%f-========bottom:%f=========top:%f======h:%f=======contentSize.height:%f",self.scrollView.frame.size.height,self.scrollViewOriginalInset.bottom,self.scrollViewOriginalInset.top,h,self.scrollView.contentSize.height);
    return self.scrollView.contentSize.height - h;
}

#pragma mark 刚好看到上拉刷新控件时的contentOffset.y
- (CGFloat)happenOffsetY
{
    CGFloat deltaH = [self heightForContentBreakView];
    if (deltaH > 0) {
        return deltaH - self.scrollViewOriginalInset.top;
    } else {
        return - self.scrollViewOriginalInset.top;
    }
}

@end
