// Software License Agreement (BSD License)
//
// Copyright (c) 2010-2016, Deusty, LLC
// All rights reserved.
//


#import "DDASLLogger.h"

@protocol DDLogger;

/**
 *  This class provides the ability to capture the ASL (Apple System Logs)
 */
@interface DDASLLogCapture : NSObject

/**
 *  Start capturing logs
 */
+ (void)start;

/**
 *  Stop capturing logs
 */
+ (void)stop;

/**
 *  The current capture level.
 *  @note Default log level: DDLogLevelVerbose (i.e. capture all ASL messages).
 */
@property (class) DDLogLevel captureLevel;

@end
