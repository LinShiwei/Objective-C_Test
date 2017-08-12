//
//  NSObject+OverrideResponsToSel.m
//  TestBAD_ACCESS
//
//  Created by Lin,Shiwei on 2017/8/12.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "NSObject+OverrideResponsToSel.h"
#import <objc/runtime.h>
@implementation NSObject (OverrideResponsToSel)
//- (BOOL)respondsToSelector:(SEL)aSelector{
//    return true;
//}//想在category中重写本类的方法，会有警告，不建议这么做。
//#ifdef _FOR_DEBUG_

+ (void)load{
    Method m1 = class_getInstanceMethod(self, @selector(respondsToSelector:));
    Method m2 = class_getInstanceMethod(self, @selector(lsw_respondsToSelector:));
    method_exchangeImplementations(m1, m2);
}

- (BOOL)lsw_respondsToSelector:(SEL)aSelector{
    printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);
    return [self lsw_respondsToSelector:aSelector];
}

//#endif
@end
