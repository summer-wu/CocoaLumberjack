// Software License Agreement (BSD License)
//
// Copyright (c) 2010-2016, Deusty, LLC
// All rights reserved.
//


/**
 * NSAsset replacement that will output a log message even when assertions are disabled.
 **/
#define DDAssert(condition, frmt, ...)                                                \
        if (!(condition)) {                                                           \
            NSString *description = [NSString stringWithFormat:frmt, ## __VA_ARGS__]; \
            DDLogError(@"%@", description);                                           \
            NSAssert(NO, description);                                                \
        }
#define DDAssertCondition(condition) DDAssert(condition, @"Condition not satisfied: %s", #condition)

