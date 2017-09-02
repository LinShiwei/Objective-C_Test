//
//  PrefectSingleton.m
//  TestOCSingleton
//
//  Created by Lin,Shiwei on 2017/8/4.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "PrefectSingleton.h"

@implementation PrefectSingleton
static PrefectSingleton *sharedPrefectSingleton = nil;

+ (instancetype)sharedPrefectSingleton{
    @synchronized (self) {
        if (sharedPrefectSingleton == nil) {
            sharedPrefectSingleton = [[super allocWithZone:nil] init];// 避免死循环，不能用self
            // 如果 在单例类里面重写了 allocWithZone 方法 ，在创建单例对象时 使用 [[DataHandle alloc] init] 创建，会死循环。
        }
    }
    return sharedPrefectSingleton;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [PrefectSingleton sharedPrefectSingleton];
}

- (id)copy{
    return self;
}

- (id)mutableCopy{
    return self;
}

- (id)copyWithZone:(struct _NSZone *)zone{
    return self;
}


+ (instancetype)alloc
{
    return [PrefectSingleton sharedPrefectSingleton];
}
/*ARC 中不需要重写下列方法。
// 因为只有一个实例， 一直不释放，所以不增加引用计数。无意义。

- (instancetype)retain
{
    return self;
}

- (oneway void)release
{
    // nothing
}

- (instancetype)autorelease
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax; // 返回整形最大值。
}
*/

@end
