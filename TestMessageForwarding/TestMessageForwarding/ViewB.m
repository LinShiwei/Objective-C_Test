//
//  ViewB.m
//  TestMessageForwarding
//
//  Created by Lin,Shiwei on 2017/7/27.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewB.h"
#import <objc/runtime.h>
@implementation ViewB

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//
+ (void)load{
    ClassMethodCallLog(@"load");
//    Method m1 = class_getClassMethod([self class], @selector(initialize));
//    Method m2 = class_getClassMethod([self class], @selector(customInitialize));
//
//    method_exchangeImplementations(m1, m2);

}

+ (void)initialize{
    ClassMethodCallLog(@"vb initialize");
//    Method m1 = class_getClassMethod([self class], @selector(load));
//    Method m2 = class_getClassMethod([self class], @selector(customLoad));
//    
////    Method m1 = class_getClassMethod([self class], @selector(printClassMethodB));
////    Method m2 = class_getClassMethod([self class], @selector(printClassMethodBMock));
////    
//    method_exchangeImplementations(m1, m2);
}

- (void)printSomething{
    ClassMethodCallLog(@"- printSomething");
}

+ (void)printClassMethodB{
    ClassMethodCallLog(@"+ pintClassMethodB");
}

+ (void)printClassMethodBMock{
    ClassMethodCallLog(@"+ printClassMethodBMock");
}

- (void)printB{
    ClassMethodCallLog(@"printB");
}

+ (void)customInitialize{
    ClassMethodCallLog(@"customInitialize");
}

+ (void)customLoad{
    ClassMethodCallLog(@"customLoad");
}

+ (BOOL)resolveClassMethod:(SEL)sel{
    ClassMethodCallLog(@"resolveClassMethod:sel");
    return [super resolveClassMethod:sel];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    ClassMethodCallLog(@"resolveInstanceMethod:sel");

    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    ClassMethodCallLog(@"- forwardingTargetForSelector:");

    return [super forwardingTargetForSelector:aSelector];
}

+ (id)forwardingTargetForSelector:(SEL)aSelector{
    ClassMethodCallLog(@"+ forwardingTargetForSelector:");

    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    ClassMethodCallLog(@"- methodSignatureForSelector:");

    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    ClassMethodCallLog(@"- forwardInvocation:");

    [super forwardInvocation:anInvocation];
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    ClassMethodCallLog(@"+ methodSignatureForSelector:");

    return [super methodSignatureForSelector:aSelector];
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation{
    ClassMethodCallLog(@"+ forwardInvocation:");

    [super forwardInvocation:anInvocation];
}
@end
