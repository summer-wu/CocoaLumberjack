//
//  LogManager.h
//  Taker
//
//  Created by n on 16/11/30.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

typedef NS_ENUM(NSUInteger, DDLogContext) {
    DDLogContextDefault = 0,//在默认的宏中都是0
    DDLogContextLogManagerNoFunctionName = 1,//app定义的。用context可以区分出来自哪个 method macro
    DDLogContextLogManagerHasFunctionName = 2
};

//这个类负责创建logger、移除logger。向logger中添加log，获取最新1000条log。
@interface LogManager : NSObject

+ (instancetype)sharedInstance;

//打开app的时候要创建3个logger，并添加到DDLog单例中
- (void)createAndAdd3Loggers;

//获取有用log
- (NSString *)getUsefulLog;
@end

//添加Log，不要用DDLogVerbose，用一个自定义的LogManagerLogVerbose
//#define DDLogVerbose(frmt, ...) LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagVerbose, 0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
//为了使用时不需要static const DDLogLevel ddLogLevel = DDLogLevelAll; 直接在宏中定义为level为ALl
//#define LOG_MAYBE(async, lvl, flg, ctx, tag, fnct, frmt, ...)

#define kTurnOnLogManager 1//0关闭，1打开
#if kTurnOnLogManager
    #define LogManagerAddLogNoFunctionName(frmt,...)  LOG_MAYBE(LOG_ASYNC_ENABLED, DDLogLevelAll, DDLogFlagVerbose, DDLogContextLogManagerNoFunctionName , nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
    #define LogManagerAddLogHasFunctionName(frmt,...) LOG_MAYBE(LOG_ASYNC_ENABLED, DDLogLevelAll, DDLogFlagVerbose, DDLogContextLogManagerHasFunctionName, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#else
    #define LogManagerAddLogNoFunctionName(frmt,...) (void)0;
    #define LogManagerAddLogHasFunctionName(frmt,...) (void)0;
#endif
//只允许用这一个LogManagerLogVerbose，其他宏不许用
#undef DDLogError
#undef DDLogWarn
#undef DDLogInfo
#undef DDLogDebug
#undef DDLogVerbose

#undef DDLogErrorToDDLog
#undef DDLogWarnToDDLog
#undef DDLogInfoToDDLog
#undef DDLogDebugToDDLog
#undef DDLogVerboseToDDLog
