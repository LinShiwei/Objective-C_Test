//
//  NSObject+KVO.m
//  TestKVOLowLevel
//
//  Created by Lin,Shiwei on 2017/8/3.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/message.h>

#import "NotificationPerson.h"


NSString *const observerKey = @"observer";

@implementation NSObject (KVO)
// 监听某个对象的属性
// 谁调用就监听谁
- (void)ZJY_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    
    /*
     // 1.自定义NSKVONotifying_Person子类
     // 2.重写setName,在内部恢复父类做法,通知观察者
     // 3.如何让外界调用自定义Person类的子类方法,修改当前对象的isa指针,指向NotificationPerson
     */
    
    // 把观察者保存到当前对象
    objc_setAssociatedObject(self, (__bridge const void *)(observerKey), observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 修改对象isa指针
    object_setClass(self, [NotificationPerson class]);
    
}
@end
