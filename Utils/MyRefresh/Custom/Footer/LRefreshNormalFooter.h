//
//  LRefreshNormalFooter.h
//  CSCUtil
//
//  Created by csc on 16/10/12.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "LRefreshStateFooter.h"

@interface LRefreshNormalFooter : LRefreshStateFooter
//@property (weak, nonatomic, readonly) UIImageView *arrowView;
/**
 *  箭头
 */
@property (strong, nonatomic)UIImageView * arrowView;

/**菊花样式*/
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
@end
