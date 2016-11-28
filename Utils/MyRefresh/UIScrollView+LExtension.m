//
//  UIScrollView+LExtension.m
//  CSCUtil
//
//  Created by csc on 16/10/10.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "UIScrollView+LExtension.h"

@implementation UIScrollView (LExtension)
-(void)setL_insetT:(CGFloat)l_insetT
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = l_insetT;
    self.contentInset = inset;
}
-(CGFloat)l_insetT
{
    return self.contentInset.top;
}

-(void)setL_insetB:(CGFloat)l_insetB
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = l_insetB;
    self.contentInset = inset;
}
-(CGFloat)l_insetB
{
    return self.contentInset.bottom;
}

-(void)setL_insetL:(CGFloat)l_insetL
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = l_insetL;
    self.contentInset = inset;
}
-(CGFloat)l_insetL
{
    return self.contentInset.left;
}

-(void)setL_insetR:(CGFloat)l_insetR
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = l_insetR;
    self.contentInset = inset;
}
-(CGFloat)l_insetR
{
    return self.contentInset.right;
}

-(void)setL_offsetX:(CGFloat)l_offsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = l_offsetX;
    self.contentOffset = offset;
}
-(CGFloat)l_offsetX
{
    return self.contentOffset.x;
}

-(void)setL_offsetY:(CGFloat)l_offsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = l_offsetY;
    self.contentOffset = offset;
}

-(CGFloat)l_offsetY
{
    return self.contentOffset.y;
}

-(void)setL_contentW:(CGFloat)l_contentW
{
    CGSize size = self.contentSize;
    size.width = l_contentW;
    self.contentSize = size;
}
-(CGFloat)l_contentW
{
    return self.contentSize.width;
}

-(void)setL_contentH:(CGFloat)l_contentH
{
    CGSize size = self.contentSize;
    size.height = l_contentH;
    self.contentSize = size;
}
-(CGFloat)l_contentH
{
    return self.contentSize.height;
}
@end
