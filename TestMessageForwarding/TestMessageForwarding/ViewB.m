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
    Method m1 = class_getClassMethod([self class], @selector(initialize));
    Method m2 = class_getClassMethod([self class], @selector(customInitialize));

    method_exchangeImplementations(m1, m2);

}

+ (void)initialize{
    ClassMethodCallLog(@"vb initialize");
    Method m1 = class_getClassMethod([self class], @selector(load));
    Method m2 = class_getClassMethod([self class], @selector(customLoad));
    
    method_exchangeImplementations(m1, m2);
}

- (void)printSomething{
    ClassMethodCallLog(@"printSomething");
}

+ (void)printClassMethodB{
    ClassMethodCallLog(@"pintClassMethodB");
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
@end
