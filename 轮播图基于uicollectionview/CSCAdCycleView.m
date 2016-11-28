//
//  CSCAdCycleView.m
//  CSCUtil
//
//  Created by csc on 16/10/24.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "CSCAdCycleView.h"
#import "CSCAdSycleCell.h"
#define __WS  __weak __typeof(&*self)weakSelf = self;
static NSString * const cellIdentifier = @"adCycleCellIdentifier";

typedef void (^DidSelectItemBlock)(NSInteger selectItem);

@interface CSCAdCycleView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView * adCycleView;//广告view
@property (strong, nonatomic) UIPageControl * pageControl; //pageControl
@property (assign, nonatomic) NSInteger currentItem;//< 当前cell的item值
@property (assign, nonatomic) CGFloat timeInterval; //定时器时间

@property (strong, nonatomic) DidSelectItemBlock didSelectBlock;
@end


@implementation CSCAdCycleView


-(instancetype)initWithFrame:(CGRect)frame
                   dataArray:(NSArray *)dataArray
          didSelectItemBlock:(void(^)(NSInteger didSelectItem))block;
{
    if(self = [super initWithFrame:frame])
    {
    
    }
    return self;
}

@end
