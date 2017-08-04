//
//  SimpleSingleton.m
//  TestOCSingleton
//
//  Created by Lin,Shiwei on 2017/8/4.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "SimpleSingleton.h"



@implementation SimpleSingleton
+ (instancetype)sharedSimpleSingleton{
    static SimpleSingleton *sharedSimpleSingleton = nil;
    @synchronized (self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken,^{
            NSLog(@"%@",self);
            sharedSimpleSingleton = [[self alloc] init];
        });

    }
    return sharedSimpleSingleton;
}
@end
