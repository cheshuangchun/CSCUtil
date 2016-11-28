//
//  NSBundle+LRefresh.h
//  CSCUtil
//
//  Created by csc on 16/10/11.
//  Copyright © 2016年 csc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (LRefresh)
+ (instancetype)l_refreshBundle;
+ (UIImage *)l_arrowImage;
+ (NSString *)l_localizedStringForKey:(NSString *)key value:(NSString *)value;
+ (NSString *)l_localizedStringForKey:(NSString *)key;
@end
