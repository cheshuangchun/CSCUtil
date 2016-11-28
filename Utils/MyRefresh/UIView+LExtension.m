//
//  UIView+LExtension.m
//  CSCUtil
//
//  Created by csc on 16/10/9.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "UIView+LExtension.h"

@implementation UIView (LExtension)
-(void)setL_x:(CGFloat)l_x
{
    CGRect frame = self.frame;
    frame.origin.x = l_x;
    self.frame = frame;
}

-(CGFloat)l_x
{
    return self.frame.origin.x;
}

-(void)setL_y:(CGFloat)l_y
{
    CGRect frame = self.frame;
    frame.origin.y = l_y;
    self.frame = frame;
}

-(CGFloat)l_y
{
    return self.frame.origin.y;
}
-(void)setL_w:(CGFloat)l_w
{
    CGRect frame = self.frame;
    frame.size.width = l_w;
    self.frame = frame;
}

-(CGFloat)l_w
{
    return self.frame.size.width;
}
-(void)setL_h:(CGFloat)l_h
{
    CGRect frame = self.frame;
    frame.size.height = l_h;
    self.frame = frame;
}
-(CGFloat)l_h
{
    return self.frame.size.height;
}

-(void)setL_size:(CGSize)l_size
{
    CGRect frame = self.frame;
    frame.size = l_size;
    self.frame = frame;
}
-(CGSize)l_size
{
    return self.frame.size;
}

-(void)setL_origin:(CGPoint)l_origin
{
    CGRect frame = self.frame;
    frame.origin = l_origin;
    self.frame = frame;
}

-(CGPoint)l_origin
{
    return self.frame.origin;
}
@end
