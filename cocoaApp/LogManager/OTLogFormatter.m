//
//  OTLogFormatter.m
//  Taker
//
//  Created by n on 16/12/1.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import "OTLogFormatter.h"
#import "BeijingLogDateFormatter.h"
#import "LogManager.h"

@interface OTLogFormatter (){
    NSDateFormatter *_dateFormatter;
}
@end

@implementation OTLogFormatter

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dateFormatter = [BeijingLogDateFormatter sharedInstance];
    }
    return self;
}


- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSString *result;
    NSString *dateAndTime = [_dateFormatter stringFromDate:(logMessage->_timestamp)];
    if (logMessage->_context == DDLogContextLogManagerHasFunctionName){//用LogManagerAddLogHasFunctionName添加的
        result = [NSString stringWithFormat:@"%@,%@,%@", dateAndTime, logMessage->_function,logMessage->_message];
    } else {
        result = [NSString stringWithFormat:@"%@,,%@", dateAndTime, logMessage->_message];
    }
    return result;
}

@end
