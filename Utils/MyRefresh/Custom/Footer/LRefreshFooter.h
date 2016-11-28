//
//  LRefreshFooter.h
//  CSCUtil
//
//  Created by csc on 16/10/11.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "LRefreshComponent.h"

@interface LRefreshFooter : LRefreshComponent
//创建footer
+(instancetype)footerWithRefreshingBlock:(LRefreshComponentRefreshingBlock)refreshingBlock;

/**提示没有更多的数据*/
-(void)endRefreshingWithNoMoreData;

/**消除没有更多数据的状态*/
-(void)resetNoMoreData;
@end
