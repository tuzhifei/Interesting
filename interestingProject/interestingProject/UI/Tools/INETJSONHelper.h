//
//  INETJSONHelper.h
//  router
//
//  Created by mark on 2019/6/6.
//  Copyright © 2019 Wireless Department. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface INETJSONHelper : NSObject

#ifdef __cplusplus
extern "C" {
#endif
    
    NSString *NSStringFromDictionaryForKey(NSDictionary *dictionary, NSString *key);
    NSNumber *NSNumberFromDictionaryForKey(NSDictionary *dictionary, NSString *key);
    NSArray *NSArrayFromDictionaryForKey(NSDictionary *dictionary, NSString *key);
    NSDictionary *NSDictionaryFromDictionaryForKey(NSDictionary *dictionary, NSString *key);
    int IntFromDictionaryForKey(NSDictionary *dictionary, NSString *key);
    CGFloat CGFloatFromDictionaryForKey(NSDictionary *dictionary, NSString *key);
    BOOL BooleanFromDictionaryForKey(NSDictionary *dictionary, NSString *key);
    
#ifdef __cplusplus
}
#endif

@end

NS_ASSUME_NONNULL_END
