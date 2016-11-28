//
//  LRefreshComponent.h
//  CSCUtil
//
//  Created by csc on 16/10/9.
//  Copyright © 2016年 csc. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  刷新控件的状态
 */
typedef NS_ENUM(NSInteger,LRefreshState) {
    //普通闲置状态
    LRefreshStateIdle = 1,
    //松开就可以刷新的状态
    LRefreshStatePulling,
    //正在刷新中的状态
    LRefreshStateRefreshing,
    //即将刷新的状态
    LRefreshStateWillRefresh,
    //所有数据加载完毕，没有更多的数据了的状态
    LRefreshStateNoMoreData
};
//进入刷新状态的回调
typedef void (^LRefreshComponentRefreshingBlock)();
//开始刷新后的回调
typedef void (^LRefreshComponentbeginRefreshingCompletionBlock)();
//结束刷新后的回调
typedef void (^LRefreshComponentEndRefreshingCompletionBlock)();
@interface LRefreshComponent : UIView
{
    //记录scrollView刚开始的inset
    UIEdgeInsets _scrollViewOriginalInset;
    //父控件
    __weak UIScrollView * _scrollView;
}

#pragma mark 刷新回调
//正在刷新的回调
@property (copy, nonatomic) LRefreshComponentRefreshingBlock refreshingBlock;
//设置回调对象和回调方法
-(void)setRefreshingTarget:(id)target refreshingAction:(SEL)action;
//触发回调(交给子类去调用)
-(void)executeRefreshingCallback;

//回调对象
@property (weak, nonatomic) id refreshingTarget;
//回调方法
@property (assign, nonatomic) SEL refreshingAction;
//触发回调
#pragma mark - 交给子类去访问
/** 记录scrollView刚开始的inset */
@property (assign, nonatomic, readonly) UIEdgeInsets scrollViewOriginalInset;
/** 父控件 */
@property (weak, nonatomic, readonly) UIScrollView *scrollView;

#pragma mark 刷新状态控制
//进入刷新状态
-(void)beginRefreshing;

//刷新状态  一般交给子类内部实现
@property (assign, nonatomic) LRefreshState state;

//结束刷新状态
-(void)endRefreshing;

#pragma mark 交给子类们去实现
//初始化
-(void)prepare NS_REQUIRES_SUPER;

/** 摆放子控件frame */
- (void)placeSubviews NS_REQUIRES_SUPER;

/** 当scrollView的contentOffset发生改变的时候调用 */
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
/**当scrollview的contentSize发生改变的时候调用*/
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change  NS_REQUIRES_SUPER;
#pragma mark - 其他
/** 拉拽的百分比(交给子类重写) */
@property (assign, nonatomic) CGFloat pullingPercent;
@end

@interface UILabel(LRefresh)
+ (instancetype)l_label;
//- (CGFloat)mj_textWith;
@end
