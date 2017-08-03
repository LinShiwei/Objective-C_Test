//
//  ViewA.m
//  TestMessageForwarding
//
//  Created by Lin,Shiwei on 2017/7/27.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewA.h"
@interface ViewA ()
@property (weak,nonatomic) id target;
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
    }
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    return [_target methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    [anInvocation invokeWithTarget:_target];
//    self->_str = @"a";
//    _str = @"C";
//    self.str = @"b";
//    self.testPolymorphic;
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
@end