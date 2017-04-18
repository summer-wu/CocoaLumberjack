//
//  LogDateFormatter.m
//  Taker
//
//  Created by n on 16/12/1.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import "BeijingLogDateFormatter.h"

@implementation BeijingLogDateFormatter
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setDateFormat:@"MM-dd HH:mm:ss.SSS"];

        NSTimeZone *timezone = [NSTimeZone timeZoneForSecondsFromGMT:28800];//3600*8，即东八区，北京时间
        [self setTimeZone:timezone];

        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [self setLocale:enUSPOSIXLocale];//设置固定的locale，忽略用户配置
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


@end
