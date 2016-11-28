//
//  LRefreshNormalHeader.h
//  CSCUtil
//
//  Created by csc on 16/10/9.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "LRefreshStateHeader.h"

@interface LRefreshNormalHeader : LRefreshStateHeader
@property (strong, nonatomic) UIImageView * arrowView;
//菊花样式
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
@end
