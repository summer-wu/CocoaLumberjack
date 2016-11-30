// Software License Agreement (BSD License)
//
// Copyright (c) 2010-2016, Deusty, LLC
// All rights reserved.
//


#import <Foundation/Foundation.h>

// Disable legacy macros
#ifndef DD_LEGACY_MACROS
    #define DD_LEGACY_MACROS 0
#endif

#import "DDLog.h"

// Custom key set on messages sent to ASL
extern const char* const kDDASLKeyDDLog;

// Value set for kDDASLKeyDDLog
extern const char* const kDDASLDDLogValue;

/**
 * This class provides a logger for the Apple System Log facility.
 *
 * As described in the "Getting Started" page,
 * the traditional NSLog() function directs its output to two places:
 *
 * - Apple System Log
 * - StdErr (if stderr is a TTY) so log statements show up in Xcode console
 *
 * To duplicate NSLog() functionality you can simply add this logger and a tty logger.
 * However, if you instead choose to use file logging (for faster performance),
 * you may choose to use a file logger and a tty logger.
 **/
@interface DDASLLogger : DDAbstractLogger <DDLogger>

/**
 *  Singleton method
 *
 *  @return the shared instance
 */
@property (class, readonly, strong) DDASLLogger *sharedInstance;

// Inherited from DDAbstractLogger

// - (id <DDLogFormatter>)logFormatter;
// - (void)setLogFormatter:(id <DDLogFormatter>)formatter;

@end
