//
//  Student.m
//  TestManualKVO
//
//  Created by Lin,Shiwei on 2017/8/12.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "Student.h"

@implementation Student

@synthesize name = _name;
- (void)setName:(NSString *)name
{
    _name = name;
}
- (NSString *)name
{
    return _name;
}


// 手动设定KVO
- (void)setAge:(NSString *)age
{
    [self willChangeValueForKey:@"age"];
    _age = age;
    [self didChangeValueForKey:@"age"];
}
- (NSString *)age
{
    return _age;
}
//automaticallyNotifiesObserversForKey会在每次addObserver的时候调用，判断是否要自动调用willChangeValueForKey和didChangeValueForKey
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
{
    // 如果监测到键值为age,则指定为非自动监听对象
    if ([key isEqualToString:@"age"])
    {
        return NO;
    }
    
    return [super automaticallyNotifiesObserversForKey:key];
}

@end
