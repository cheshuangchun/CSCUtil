//
//  CSCAdCycleView.h
//  CSCUtil
//
//  Created by csc on 16/10/24.
//  Copyright © 2016年 csc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSCAdCycleView : UIView

//图片数组
@property (strong, nonatomic) NSArray * imgArray;
//链接数组
@property (strong, nonatomic) NSArray * linkArray;
//其他字段
@property (strong, nonatomic) NSArray * otherArray;



-(instancetype)initWithFrame:(CGRect)frame
                   dataArray:(NSArray *)dataArray
          didSelectItemBlock:(void(^)(NSInteger didSelectItem))block;
@end
