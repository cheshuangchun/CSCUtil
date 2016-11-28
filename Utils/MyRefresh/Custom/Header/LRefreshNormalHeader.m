//
//  LRefreshNormalHeader.m
//  CSCUtil
//
//  Created by csc on 16/10/9.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "LRefreshNormalHeader.h"

@interface LRefreshNormalHeader()
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;
@end

@implementation LRefreshNormalHeader
#pragma mark -懒加载子控件
-(UIImageView *)arrowView //箭头
{
    if(!_arrowView)
    {
        UIImageView * arrowView = [[UIImageView alloc]initWithImage:[UIImage imagesNamedFromName:@"arrow"]];
        arrowView.frame = CGRectMake(40, 10, 15, 34);
        _arrowView = arrowView;
        [self addSubview:_arrowView];
    }
    return _arrowView;
}

-(UIActivityIndicatorView *)loadingView
{
    if(!_loadingView)
    {
        UIActivityIndicatorView * loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        loadingView.frame = CGRectMake(30, 17, 20, 20);
        _loadingView = loadingView;
        [self addSubview:_loadingView];
    }
    return _loadingView;
}



#pragma mark -重写父类的方法
-(void)prepare
{
    [super prepare];
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

-(void)placeSubviews
{
    [super placeSubviews];
    
    
}

-(void)setState:(LRefreshState)state
{
    MJRefreshCheckState
    //根据状态做事情
    if(state == LRefreshStateIdle)
    {
        if(oldState == LRefreshStateRefreshing)
        {
            self.arrowView.transform = CGAffineTransformIdentity;
            [UIView animateWithDuration:LRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != LRefreshStateIdle) return;
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                self.arrowView.hidden = NO;
                
            }];
        }else
        {
            [self.loadingView stopAnimating];
            self.arrowView.hidden = NO;
            [UIView animateWithDuration:LRefreshFastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformIdentity;
            }];
        }
        
        
    }else if (state == LRefreshStatePulling)//下拉的过程
    {
        [self.loadingView stopAnimating];
        self.arrowView.hidden = NO;
        [UIView animateWithDuration:LRefreshFastAnimationDuration animations:^{
            self.arrowView.transform = CGAffineTransformMakeRotation(-M_PI);
        }];
        
    }else if (state == LRefreshStateRefreshing)//刷新
    {
        self.loadingView.alpha = 1.0;
        [self.loadingView startAnimating];
        self.arrowView.hidden = YES;
    }
    
}
@end
