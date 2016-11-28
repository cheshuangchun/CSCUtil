//
//  LRefreshHeader.h
//  CSCUtil
//
//  Created by csc on 16/10/9.
//  Copyright © 2016年 csc. All rights reserved.
//  下拉刷新控件：负责监控用户下拉的状态

#import "LRefreshComponent.h"
@interface LRefreshHeader : LRefreshComponent
/**
 *  创建header
 *
 *  @param refreshingBlock <#refreshingBlock description#>
 *
 *  @return <#return value description#>
 */
+(instancetype)headerWithRefreshingBlock:(LRefreshComponentRefreshingBlock)refreshingBlock;



//这个key用来存储上一次下拉刷新成功的时间
@property (strong, nonatomic) NSString * lastUpdatedTimeKey;

@end
