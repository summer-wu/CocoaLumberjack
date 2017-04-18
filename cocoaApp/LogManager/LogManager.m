//
//  LogManager.m
//  Taker
//
//  Created by n on 16/11/30.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import "LogManager.h"
#import "OTLogFormatter.h"
#import "OTLogFileManager.h"


@interface LogManager ()
@property (nonatomic,strong) DDFileLogger *fileLogger;
@property (nonatomic,strong) OTLogFormatter *logFormatter;
@end

@implementation LogManager
+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (void)createAndAdd3Loggers{
    self.logFormatter = [OTLogFormatter new];
    [DDTTYLogger sharedInstance].logFormatter = self.logFormatter;
    [DDASLLogger sharedInstance].logFormatter = self.logFormatter;
    [DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode console
    [DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs

    OTLogFileManager *logFileManager = [OTLogFileManager new];//直接放在app根目录即可。
    _fileLogger = [[DDFileLogger alloc]initWithLogFileManager:logFileManager];
    _fileLogger.logFormatter = self.logFormatter;
    _fileLogger.maximumFileSize = INT_MAX;
    [DDLog addLogger:_fileLogger];

    DDLogFileInfo *info = _fileLogger.currentLogFileInfo;
    LogManagerAddLogHasFunctionName(@"\n\n\n=====\noperation_long creatation Date: %@ FilePath:%@",info.creationDate,info.filePath);
}


- (NSString *)getUsefulLog{
    //DDFileLogger不会buffer log。它也没有实现flush方法。
    OTLogFileManager *logFileManager = _fileLogger.logFileManager;
    NSString *usefulLog = [logFileManager getUsefulLog];
    return usefulLog;
}

@end



