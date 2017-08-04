//
//  NotificationPerson.m
//  TestKVOLowLevel
//
//  Created by Lin,Shiwei on 2017/8/3.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "NotificationPerson.h"
#import <objc/message.h>
extern NSString *const observerKey ;

@implementation NotificationPerson
- (void)setName:(NSString *)name
{
    [super setName:name];
    
    // 通知观察者调用observeValueForKeyPath
    // 需要把观察者保存到当前对象
    // 获取观察者
    id obsetver = objc_getAssociatedObject(self, observerKey);
    
    [obsetver observeValueForKeyPath:@"name" ofObject:self change:nil context:nil];
    
}

@end
