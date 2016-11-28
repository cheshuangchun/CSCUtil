//
//  LRefreshComponent.m
//  CSCUtil
//
//  Created by csc on 16/10/9.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "LRefreshComponent.h"

@implementation LRefreshComponent

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark 初始化
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //准备工作
        [self prepare];
        //默认是普通状态
        self.state = LRefreshStateIdle;
        
    }
    
    return self;
}

//准备  子类实现更多
-(void)prepare
{
    //基本属性
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor lightGrayColor];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self placeSubviews];
}

- (void)placeSubviews{}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    //如果不是UIScrollView 不做任何事情
    if(newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]])
        return;
    //旧的父控件移除监听
    [self removeObservers];
    if(newSuperview)//新的父控件
    {
        //设置宽度
        self.l_w = newSuperview.l_w;
        //设置位置
        self.l_x = 0;
        //记录UIScrollView;
        _scrollView = (UIScrollView *)newSuperview;
        //设置 永远支持垂直弹簧效果
        _scrollView.alwaysBounceVertical = YES;
        //记录UIScrollView最开始的contentInset;
        _scrollViewOriginalInset = _scrollView.contentInset;
        //添加监听
        [self addObservers];
    }
    
}

#pragma mark -公共方法
-(void)setState:(LRefreshState)state
{
    _state = state;
}

#pragma mark 进入刷新状态
-(void)beginRefreshing
{
    [UIView animateWithDuration:LRefreshFastAnimationDuration animations:^{
        self.alpha = 1.0;
    }];
    self.pullingPercent = 1.0;
    //只要正在刷新，就完全显示
    if(self.window)
    {
        self.state = LRefreshStateRefreshing;
    }else
    {
        
    }
}


#pragma mark 结束刷新状态
-(void)endRefreshing
{
    self.state = LRefreshStateIdle;
}

//添加监听
-(void)addObservers
{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:LRefreshKeyPathContentOffset options:options context:nil];
    [self.scrollView addObserver:self forKeyPath:LRefreshKeyPathContentSize options:options context:nil];
    
}

//旧的父控件移除监听
-(void)removeObservers
{
    [self.superview removeObserver:self forKeyPath:LRefreshKeyPathContentOffset];
    [self.superview removeObserver:self forKeyPath:LRefreshKeyPathContentSize];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    //遇到这些情况就直接返回 (不知道神马卵用)
    if(!self.userInteractionEnabled)return;
    
    if(self.hidden) return;
    
    //scrollview的contentSize发生变化了
    if([keyPath isEqualToString:LRefreshKeyPathContentSize])
    {
        [self scrollViewContentSizeDidChange:change];
    }
    
    if([keyPath isEqualToString:LRefreshKeyPathContentOffset])//拖动改变contentOffset了
    {
        [self scrollViewContentOffsetDidChange:change];
    }
    
    
    
}
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{}

-(void)scrollViewContentSizeDidChange:(NSDictionary *)change{}

#pragma mark -内部方法
-(void)executeRefreshingCallback
{
    dispatch_async(dispatch_get_main_queue(), ^{
       if(self.refreshingBlock)
       {
           self.refreshingBlock();
       }
    });
}

@end


@implementation UILabel(LRefresh)
+ (instancetype)l_label
{
    UILabel *label = [[self alloc] init];
    label.font = LRefreshLabelFont;
    label.textColor = kColor(90, 90, 90);
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    return label;
}
@end
