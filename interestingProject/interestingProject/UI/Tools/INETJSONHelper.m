//
//  INETJSONHelper.m
//  router
//
//  Created by mark on 2019/6/6.
//  Copyright © 2019 Wireless Department. All rights reserved.
//

#import "INETJSONHelper.h"

@implementation INETJSONHelper

id DictionaryValueForKeyPath(NSDictionary *dictionary, NSString *keyPath) {
    static id value;
    @try {
        value = [dictionary valueForKeyPath:keyPath];
    } @catch (NSException *exception) {
        value = nil;
    } @finally {
        return value;
    }
}

NSString *NSStringFromDictionaryForKey(NSDictionary *dictionary, NSString *key) {
    id value = DictionaryValueForKeyPath(dictionary, key);
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@", (NSNumber *)value];
    }
    return [NSString string];
}

NSNumber *NSNumberFromDictionaryForKey(NSDictionary *dictionary, NSString *key) {
    id value = DictionaryValueForKeyPath(dictionary, key);
    if ([value isKindOfClass:[NSNumber class]]) {
        return value;
    }
    return [NSNumber numberWithChar:0];
}

NSArray *NSArrayFromDictionaryForKey(NSDictionary *dictionary, NSString *key) {
    id value = DictionaryValueForKeyPath(dictionary, key);
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return [NSArray array];
}

NSDictionary *NSDictionaryFromDictionaryForKey(NSDictionary *dictionary, NSString *key) {
    id value = DictionaryValueForKeyPath(dictionary, key);
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return [NSDictionary dictionary];
}

int IntFromDictionaryForKey(NSDictionary *dictionary, NSString *key) {
    id value = DictionaryValueForKeyPath(dictionary, key);
    if ([value isKindOfClass:NSString.class]) {
        return [(NSString *)value intValue];
    }
    else if ([value isKindOfClass:NSNumber.class]) {
        return [(NSNumber *)value intValue];
    }
    return 0;
}

CGFloat CGFloatFromDictionaryForKey(NSDictionary *dictionary, NSString *key) {
    id value = DictionaryValueForKeyPath(dictionary, key);
    if ([value isKindOfClass:NSString.class]) {
        return [(NSString *)value doubleValue];
    }
    else if ([value isKindOfClass:NSNumber.class]) {
        return [(NSNumber *)value doubleValue];
    }
    return 0.00;
}

BOOL BooleanFromDictionaryForKey(NSDictionary *dictionary, NSString *key) {
    id value = DictionaryValueForKeyPath(dictionary, key);
    if ([value isKindOfClass:NSString.class]) {
        if ([(NSString *)value isEqualToString:@"0"]) {
            return NO;
        } else if ([(NSString *)value isEqualToString:@"1"]) {
            return YES;
        }
    } else if ([value isKindOfClass:NSNumber.class]) {
        if (((NSNumber *)value).intValue == 0) {
            return NO;
        } else if (((NSNumber *)value).intValue == 1) {
            return YES;
        }
    }
    return NO;
}


@end
