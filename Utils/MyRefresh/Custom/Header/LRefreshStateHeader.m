//
//  LRefreshStateHeader.m
//  CSCUtil
//
//  Created by csc on 16/10/9.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "LRefreshStateHeader.h"

@interface LRefreshStateHeader()
//所有状态对应的文字
@property (strong, nonatomic) NSMutableDictionary * stateTitles;
@end


@implementation LRefreshStateHeader
#pragma mark 懒加载
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
        [self addSubview:_stateLabel = [UILabel l_label]];
    }
    return _stateLabel;
}

-(UILabel *)lastUpdatedTimeLabel
{
    if(!_lastUpdatedTimeLabel)
    {
        [self addSubview:_lastUpdatedTimeLabel=[UILabel l_label] ];
    }
    return _lastUpdatedTimeLabel;
}

#pragma mark - 日历获取在9.x之后的系统使用currentCalendar会出异常。在8.0之后使用系统新API。
- (NSCalendar *)currentCalendar {
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    return [NSCalendar currentCalendar];
}

#pragma mark key的处理
- (void)setLastUpdatedTimeKey:(NSString *)lastUpdatedTimeKey
{
    [super setLastUpdatedTimeKey:lastUpdatedTimeKey];
    
    // 如果label隐藏了，就不用再处理
    if (self.lastUpdatedTimeLabel.hidden) return;
    
    NSDate *lastUpdatedTime = [[NSUserDefaults standardUserDefaults] objectForKey:lastUpdatedTimeKey];
    
//    // 如果有block
//    if (self.lastUpdatedTimeText) {
//        self.lastUpdatedTimeLabel.text = self.lastUpdatedTimeText(lastUpdatedTime);
//        return;
//    }
    
    if (lastUpdatedTime) {
        // 1.获得年月日
        NSCalendar *calendar = [self currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
        NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:lastUpdatedTime];
        NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
        
        // 2.格式化日期
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        BOOL isToday = NO;
        if ([cmp1 day] == [cmp2 day]) { // 今天
            formatter.dateFormat = @" HH:mm";
            isToday = YES;
        } else if ([cmp1 year] == [cmp2 year]) { // 今年
            formatter.dateFormat = @"MM-dd HH:mm";
        } else {
            formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        }
        NSString *time = [formatter stringFromDate:lastUpdatedTime];
        
        // 3.显示日期
        self.lastUpdatedTimeLabel.text = [NSString stringWithFormat:@"%@%@%@",
                                          @"上次更新时间",
                                          isToday ? @"今天" : @"",
                                          time];
        
//        [NSString stringWithFormat:@"%@%@%@",
//                                          [NSBundle l_localizedStringForKey:LRefreshHeaderLastTimeText],
//                                          isToday ? [NSBundle l_localizedStringForKey:LRefreshHeaderDateTodayText] : @"",
//                                          time];
    } else {
        self.lastUpdatedTimeLabel.text = [NSString stringWithFormat:@"%@%@",
                                            @"上次更新时间",
                                          @"无记录"];;
        
//        [NSString stringWithFormat:@"%@%@",
//                                          [NSBundle l_localizedStringForKey:LRefreshHeaderLastTimeText],
//                                          [NSBundle l_localizedStringForKey:LRefreshHeaderNoneLastDateText]];
    }
}


#pragma mark -公共方法
//设置state状态下的文字
-(void)setTitle:(NSString *)title forState:(LRefreshState)state;
{
    if(title == nil)return;
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

#pragma mark 覆盖父类方法
-(void)prepare
{
    [super prepare];
    //初始化间距
    self.labelLeftInset = LRefreshLabelLeftInset;
    //初始化文字
    [self setTitle:@"下拉可以刷新" forState:LRefreshStateIdle];
    [self setTitle:@"松开立即刷新" forState:LRefreshStatePulling];
    [self setTitle:@"正在刷新数据中..." forState:LRefreshStateRefreshing];
}

-(void)placeSubviews
{
    [super placeSubviews];
    if(self.stateLabel.hidden) return;
    CGFloat stateLabelH = self.l_h * 0.5;
    self.stateLabel.frame = CGRectMake(0, 0, self.l_w, stateLabelH);
    self.lastUpdatedTimeLabel.frame = CGRectMake(0, stateLabelH, self.l_w, self.l_h-stateLabelH);
    
    
}

-(void)setState:(LRefreshState)state
{
    MJRefreshCheckState
    //设置状态文字
    self.stateLabel.text = self.stateTitles[@(state)];
    // 重新设置key（重新显示时间）
    self.lastUpdatedTimeKey = self.lastUpdatedTimeKey;
}

@end
