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

/**
 * This class provides a log formatter that filters log statements from a logging context not on the whitelist.
 *
 * A log formatter can be added to any logger to format and/or filter its output.
 * You can learn more about log formatters here:
 * Documentation/CustomFormatters.md
 *
 * You can learn more about logging context's here:
 * Documentation/CustomContext.md
 *
 * But here's a quick overview / refresher:
 *
 * Every log statement has a logging context.
 * These come from the underlying logging macros defined in DDLog.h.
 * The default logging context is zero.
 * You can define multiple logging context's for use in your application.
 * For example, logically separate parts of your app each have a different logging context.
 * Also 3rd party frameworks that make use of Lumberjack generally use their own dedicated logging context.
 **/
@interface DDContextWhitelistFilterLogFormatter : NSObject <DDLogFormatter>

/**
 *  Designated default initializer
 */
- (instancetype)init NS_DESIGNATED_INITIALIZER;

/**
 *  Add a context to the whitelist
 *
 *  @param loggingContext the context
 */
- (void)addToWhitelist:(NSUInteger)loggingContext;

/**
 *  Remove context from whitelist
 *
 *  @param loggingContext the context
 */
- (void)removeFromWhitelist:(NSUInteger)loggingContext;

/**
 *  Return the whitelist
 */
@property (readonly, copy) NSArray<NSNumber *> *whitelist;

/**
 *  Check if a context is on the whitelist
 *
 *  @param loggingContext the context
 */
- (BOOL)isOnWhitelist:(NSUInteger)loggingContext;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * This class provides a log formatter that filters log statements from a logging context on the blacklist.
 **/
@interface DDContextBlacklistFilterLogFormatter : NSObject <DDLogFormatter>

- (instancetype)init NS_DESIGNATED_INITIALIZER;

/**
 *  Add a context to the blacklist
 *
 *  @param loggingContext the context
 */
- (void)addToBlacklist:(NSUInteger)loggingContext;

/**
 *  Remove context from blacklist
 *
 *  @param loggingContext the context
 */
- (void)removeFromBlacklist:(NSUInteger)loggingContext;

/**
 *  Return the blacklist
 */
@property (readonly, copy) NSArray<NSNumber *> *blacklist;


/**
 *  Check if a context is on the blacklist
 *
 *  @param loggingContext the context
 */
- (BOOL)isOnBlacklist:(NSUInteger)loggingContext;

@end
