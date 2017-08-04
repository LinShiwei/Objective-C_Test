//
//  PrefectSingleton.h
//  TestOCSingleton
//
//  Created by Lin,Shiwei on 2017/8/4.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrefectSingleton : NSObject<NSCopying>
+ (instancetype)sharedPrefectSingleton;

@end
