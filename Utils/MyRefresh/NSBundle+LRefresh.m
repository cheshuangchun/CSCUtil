//
//  NSBundle+LRefresh.m
//  CSCUtil
//
//  Created by csc on 16/10/11.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "NSBundle+LRefresh.h"

@implementation NSBundle (LRefresh)
+(instancetype)l_refreshBundle
{
    static NSBundle * refreshBundle = nil;
    if(refreshBundle == nil)
    {
        NSString * bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingString:@"/csc.bundle"];
        
        refreshBundle = [NSBundle bundleWithPath:bundlePath];
    }
    return refreshBundle;
}

+ (UIImage *)l_arrowImage
{
    static UIImage *arrowImage = nil;
    if (arrowImage == nil) {
        arrowImage = [[UIImage imageWithContentsOfFile:[[self l_refreshBundle] pathForResource:@"arrow@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return arrowImage;
}

+ (NSString *)l_localizedStringForKey:(NSString *)key
{
    return [self l_localizedStringForKey:key value:nil];
}

+ (NSString *)l_localizedStringForKey:(NSString *)key value:(NSString *)value
{
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        // （iOS获取的语言字符串比较不稳定）目前框架只处理en、zh-Hans、zh-Hant三种情况，其他按照系统默认处理
        NSString *language = [NSLocale preferredLanguages].firstObject;
        if ([language hasPrefix:@"en"]) {
            language = @"en";
        } else if ([language hasPrefix:@"zh"]) {
            if ([language rangeOfString:@"Hans"].location != NSNotFound) {
                language = @"zh-Hans"; // 简体中文
            } else { // zh-Hant\zh-HK\zh-TW
                language = @"zh-Hant"; // 繁體中文
            }
        } else {
            language = @"en";
        }
        
        // 从MJRefresh.bundle中查找资源
        bundle = [NSBundle bundleWithPath:[[NSBundle l_refreshBundle] pathForResource:language ofType:@"lproj"]];
    }
    value = [bundle localizedStringForKey:key value:value table:@"Localizable"];
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}
@end
