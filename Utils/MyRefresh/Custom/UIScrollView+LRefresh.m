//
//  UIScrollView+LRefresh.m
//  CSCUtil
//
//  Created by csc on 16/10/9.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "UIScrollView+LRefresh.h"
#import "LRefreshHeader.h"
#import "LRefreshFooter.h"
#import <objc/runtime.h>

@implementation UIScrollView (LRefresh)

#pragma mark -header
static const char LRefreshHeaderkey = '\0';
-(void)setL_header:(LRefreshHeader *)l_header
{
    if(l_header != self.l_header)
    {
        //删除旧的，添加新的
        [self.l_header removeFromSuperview];
        [self insertSubview:l_header atIndex:0];
        
        //存储新的
        [self willChangeValueForKey:@"l_header"];
        objc_setAssociatedObject(self, &LRefreshHeaderkey, l_header, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"l_header"];
        
        
    }
}

-(LRefreshHeader *) l_header
{
    return objc_getAssociatedObject(self, &LRefreshHeaderkey);
}

#pragma mark -footer
static const char LRefreshFooterkey = '\0';
-(void)setL_footer:(LRefreshFooter *)l_footer
{
    if(l_footer != self.l_footer)
    {
        //删除旧的，添加新的
        [self.l_footer removeFromSuperview];
        [self insertSubview:l_footer atIndex:0];
        
        //存储新的
        [self willChangeValueForKey:@"l_footer"];
        objc_setAssociatedObject(self, &LRefreshFooterkey, l_footer, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"l_footer"];
    }
}

-(LRefreshFooter *)l_footer
{
    return objc_getAssociatedObject(self, &LRefreshFooterkey);
}

@end
