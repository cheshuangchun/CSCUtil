//
//  LRefreshNormalFooter.m
//  CSCUtil
//
//  Created by csc on 16/10/12.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "LRefreshNormalFooter.h"

@interface LRefreshNormalFooter()
@property (strong, nonatomic) UIActivityIndicatorView * loadingView;
@end


@implementation LRefreshNormalFooter

#pragma mark 懒加载子控件
-(UIImageView *)arrowView
{
    if(!_arrowView)
    {
        UIImageView * arrowView = [[UIImageView alloc]initWithImage:[UIImage imagesNamedFromName:@"arrow"]];
        arrowView.frame = CGRectMake(40, 5, 15, 34);
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
        loadingView.frame = CGRectMake(30, 12, 20, 20);
        _loadingView = loadingView;
        [self addSubview:_loadingView];
    }
    return _loadingView;
}

- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    self.loadingView = nil;
    [self setNeedsLayout];
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
    }else if (state == LRefreshStatePulling)
    {
        [self.loadingView stopAnimating];
        self.arrowView.hidden = NO;
        [UIView animateWithDuration:LRefreshFastAnimationDuration animations:^{
            self.arrowView.transform = CGAffineTransformMakeRotation(-M_PI);
        }];
        
    }else if (state == LRefreshStateRefreshing)
    {
        self.loadingView.alpha = 1.0;
        [self.loadingView startAnimating];
        self.arrowView.hidden = YES;
    }else if (state == LRefreshStateNoMoreData)
    {
        self.arrowView.hidden = YES;
        [self.loadingView stopAnimating];
    }
    
    
}

-(void)endRefreshingWithNoMoreData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.state = LRefreshStateNoMoreData;
    });
}

@end
