//
//  NSObject+Property.m
//  TestAssociatedObject
//
//  Created by Lin,Shiwei on 2017/8/3.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>

static const char *key = "name";
static const char *strkey = "str";


@implementation NSObject (Property)
- (NSString *)name
{
    // 根据关联的key，获取关联的值。
    return objc_getAssociatedObject(self, key);
}

- (void)setName:(NSString *)name
{
    // 第一个参数：给哪个对象添加关联
    // 第二个参数：关联的key，通过这个key获取
    // 第三个参数：关联的value
    // 第四个参数:关联的策略
    objc_setAssociatedObject(self, key, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setStr:(NSString *)str{
    objc_setAssociatedObject(self, strkey, str, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (NSString *)str{
    return objc_getAssociatedObject(self, strkey);
}

@end
