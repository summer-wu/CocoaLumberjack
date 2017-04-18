//
//  LogDateFormatter.h
//  Taker
//
//  Created by n on 16/12/1.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import <Foundation/Foundation.h>

///总是北京时间。不打印年月日（为了节约磁盘空间），格式为@"HH:mm:ss.SSS"
///目前仅在OTLogFormatter中用到了
@interface BeijingLogDateFormatter : NSDateFormatter
+ (instancetype)sharedInstance;
@end
