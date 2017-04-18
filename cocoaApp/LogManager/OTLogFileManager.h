//
//  OTLogFileManager.h
//  Taker
//
//  Created by n on 16/12/2.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import <CocoaLumberjack/CocoaLumberjack.h>

/**
只维护一个log文件。超过20K，则只保留最后的20k.
 logFileManager功能是对log文件进行archive、删除、创建新文件
*/
@interface OTLogFileManager : DDLogFileManagerDefault

///调用这个方法前，先执行flush。获取usefulLog，每次都会读取文件
- (NSString *)getUsefulLog;
@end
