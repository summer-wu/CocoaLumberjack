//
//  OTLogFileManager.m
//  Taker
//
//  Created by n on 16/12/2.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import "OTLogFileManager.h"

#define BLog(formatString, ...) NSLog((@"%s " formatString), __PRETTY_FUNCTION__, ##__VA_ARGS__);
#define kFM [NSFileManager defaultManager]
#define PATH_DOCUMENTDIR @"/Users/n/Desktop/Log/"

#define kMaxUsefulContentSize 20*1024//单位字节.超出20KB就认为旧内容是unuseful的
#define kOperationLogFileName @"operation_log.log"

@interface OTLogFileManager ()
@property (nonatomic,strong) NSFileHandle *readingFileHandle;
@property (nonatomic,strong) NSMutableString *metaLog;//关于Log的信息
@end

@implementation OTLogFileManager

-(instancetype)init{
    self = [super initWithLogsDirectory:PATH_DOCUMENTDIR];//放在document目录
    if (self) {
        if (![kFM fileExistsAtPath:[self logFilePath]]) {
            [kFM createFileAtPath:[self logFilePath] contents:nil attributes:nil];
        }
        self.metaLog = [[NSMutableString alloc]init];
        [self removeUnusefulLogContent];
        self.maximumNumberOfLogFiles = 1;//只保存1个log文件
        self.logFilesDiskQuota = 0;//禁用磁盘配额，log文件可以占满磁盘

//        BLog(@"usefulLog:%@",[self getUsefulLog]);
    }
    return self;
}

#pragma mark -
- (NSFileHandle *)readingFileHandle{
    if (!_readingFileHandle) {
        //文件可能不存在，不存在就下次继续创建
        _readingFileHandle = [NSFileHandle fileHandleForReadingAtPath:[self logFilePath]];//The initialized file handle object or nil if no file exists at path.
    }
    return _readingFileHandle;
}

- (void)removeUnusefulLogContent{
    if ([self currentLogFileBigThanMaxUsefulContentSize]){
        NSError *e;
        [[self getUsefulLog] writeToFile:[self logFilePath] atomically:YES encoding:NSUTF8StringEncoding error:&e];
        if (e) {
            [self.metaLog appendFormat:@"-removeUnusefulLogContent 出错:%@",e];
            BLog(@"-removeUnusefulLogContent 出错:%@",e);
        } else {
            [self.metaLog appendString:@"-removeUnusefulLogContent 成功用最后20k覆盖文件"];
            BLog(@"-removeUnusefulLogContent 成功用最后20k覆盖文件");
        }
    } else {
        [self.metaLog appendString:@"-removeUnusefulLogContent 成功用最后20k覆盖文件"];
        BLog(@"-removeUnusefulLogContent 未超过20k，不需要修改文件");
    }
}

//这个方法总会返回字符串，永远不会返回nil。即使出错也要告诉服务器出了什么错误
- (NSString *)getUsefulLog{
    NSString *s;
    if ([self currentLogFileBigThanMaxUsefulContentSize]) {//如果大于20K
        NSUInteger fileSize = [self logFileSize];
        NSUInteger offset = fileSize - kMaxUsefulContentSize;
        self.readingFileHandle = nil;//设置为nil，让getter创建新的filehandle。覆盖文件后如果不重新打开则总是读取未覆盖之前的文件
        [self.readingFileHandle seekToFileOffset:offset];
        @try {
            NSData *data = [self.readingFileHandle readDataOfLength:kMaxUsefulContentSize];// 获取最后20k，读取时有可能Exception
            s = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        } @catch (NSException *exception) {
            s = [NSString stringWithFormat:@"-getUsefulLog exception: %@",exception];
        }
        s = [NSString stringWithFormat:@"fileSize:%ld offset:%ld\n\n=====\n%@",fileSize,offset,s];//在返回的数据前加上一句message
    } else {//如果小于20k，就读取整个文件
        NSError *e;
        s = [NSString stringWithContentsOfFile:[self logFilePath] usedEncoding:nil error:&e];
        if (e) {
            s = [NSString stringWithFormat:@"-getUsefulLog e:%@",e];
        }
        s = [NSString stringWithFormat:@"small than20k\n%@",s];
    }
    s = [NSString stringWithFormat:@"metaLog:%@\n\n=====\n%@",self.metaLog,s];
    return s;
}

#pragma mark - 覆盖这两个方法，为了让文件名更易读
- (NSString *)newLogFileName{
    return kOperationLogFileName;
}

- (BOOL)isLogFile:(NSString *)fileName{
    return [fileName isEqualToString:kOperationLogFileName];
}

- (NSString *)createNewLogFile{
    //原来的做法每次的创建一个新文件，因为我这里只需要一个文件，所以直接返回文件名就可以
    return [self newLogFileName];
}

#pragma mark - 辅助方法
- (BOOL)currentLogFileBigThanMaxUsefulContentSize{
    BOOL result = [self logFileSize] > kMaxUsefulContentSize;
    BLog(@"-currentLogFileBigThanMaxUsefulContentSize : %d",result);
    return result;
}

//如果取不到，就认为这个文件尺寸为0
- (NSUInteger)logFileSize{
    NSError *e;
    NSDictionary *attributes = [kFM attributesOfItemAtPath:[self logFilePath] error:&e];
    if (e) {
        BLog(@"-logFileSize e:%@",e);
        return 0;
    } else {
        NSNumber *size = attributes[NSFileSize];
        return size.unsignedIntegerValue;
    }
}

- (NSString *)logFilePath{
    NSString *path = [self.logsDirectory stringByAppendingPathComponent:kOperationLogFileName];
    return path;
}

@end
