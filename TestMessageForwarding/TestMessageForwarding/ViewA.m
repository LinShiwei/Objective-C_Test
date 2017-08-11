//
//  ViewA.m
//  TestMessageForwarding
//
//  Created by Lin,Shiwei on 2017/7/27.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewA.h"
@interface ViewA (){
//@public NSString *_aString;
}
@property (weak,nonatomic) id target;
@property (strong,nonatomic) NSString *aString;
@end

@implementation ViewA


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (void)initialize{

    ClassMethodCallLog(@"initialize");
}

+ (void)load{
    ClassMethodCallLog(@"load");
    
}

- (instancetype)initWithForwardingTarget:(id)target{
    
    self = [super init];
    if (self) {
        ClassMethodCallLog(@"initWithForwardingTarget");
        NSLog(@"%@", NSStringFromClass([self class]));//Output "ViewA"
        NSLog(@"%@", NSStringFromClass([super class]));//Output "ViewA" the same with above.
        ClassMethodCallLog(@"initWithForwardingTarget");
        _target = target;
        _str = @"";
        __strTest = @"";
        _aString = @"";
    }
    return self;
}

+ (BOOL)resolveClassMethod:(SEL)sel{
    ClassMethodCallLog(@"+ resolveClassMethod:");

    return [super resolveClassMethod:sel];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    ClassMethodCallLog(@"+ resolveInstanceMethod:");

    if ([NSStringFromSelector(sel) isEqualToString:@"printSomething"]) {
        ClassMethodCallLog(@"isEqualToString:printSomething");
        return true;
    }
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    ClassMethodCallLog(@"- forwardingTargetForSelectro:");

    if ([NSStringFromSelector(aSelector) isEqualToString:@"printClassMethodB"]) {
        ClassMethodCallLog(@"isEqualToString:printClassMethodB");
        return [_target class];
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

+ (id)forwardingTargetForSelector:(SEL)aSelector{
    ClassMethodCallLog(@"+ forwardingTargetForSelectro:");

//    if ([NSStringFromSelector(aSelector) isEqualToString:@"printClassMethodB"]) {
//        return NSClassFromString(@"ViewB");
//    }
    
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    ClassMethodCallLog(@"- methodSignatureForSelector:");

    return [_target methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    ClassMethodCallLog(@"- forwardInvocation:");

    [anInvocation invokeWithTarget:_target];
//    self->_str = @"a";
//    _str = @"C";
//    self.str = @"b";
//    self.testPolymorphic;
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    ClassMethodCallLog(@"+ methodSignatureForSelector:");

    return [NSClassFromString(@"ViewB") methodSignatureForSelector:aSelector];
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation{
    ClassMethodCallLog(@"+ forwardInvocation:");

    [anInvocation invokeWithTarget:NSClassFromString(@"ViewB")];
}


- (BOOL)respondsToSelector:(SEL)aSelector{
    if (_target&&[_target respondsToSelector:aSelector]) {
        return true;
    }
    
    return [super respondsToSelector:aSelector];
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
}

- (void)setStr:(NSString *)str{
    _str = str;
}

- (void)testOverride{
    ClassMethodCallLog(@"testOverride");
}

- (void)somtFunc{
    ClassMethodCallLog(@"somtFunc");
}
@end
