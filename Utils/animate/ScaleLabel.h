//
//  ScaleLabel.h
//  CSCUtil
//
//  Created by csc on 16/8/22.
//  Copyright © 2016年 csc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScaleLabel : UIView
@property (nonatomic, strong) UILabel * backedLabel;
@property (nonatomic, strong) UILabel * colorLabel;
@property (nonatomic, copy)   NSString * text;

@property (assign, nonatomic) CGFloat  startScale;
@property (assign, nonatomic) CGFloat  endScale;
-(void)startAnimation;
@end
