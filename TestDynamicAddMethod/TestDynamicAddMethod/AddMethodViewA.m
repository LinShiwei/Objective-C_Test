//
//  AddMethodViewA.m
//  TestDynamicAddMethod
//
//  Created by Lin,Shiwei on 2017/8/2.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "AddMethodViewA.h"
#import <objc/runtime.h>
@implementation AddMethodViewA

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

void newMethod(id self,SEL sel)
{
    ClassMethodCallLog(@"newMethod")
    NSLog(@"%@",[NSThread currentThread]);
}

- (void)existedMethod{
    ClassMethodCallLog(@"existedMethod")
    NSLog(@"%@",[NSThread currentThread]);

}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    
    if (sel == @selector(newMethod)) {
        // 动态添加eat方法
        
        // 第一个参数：给哪个类添加方法
        // 第二个参数：添加方法的方法编号
        // 第三个参数：添加方法的函数实现（函数地址）
        // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        class_addMethod(self, @selector(newMethod), newMethod, "v@:");
        
    }
    
    return [super resolveInstanceMethod:sel];
}
@end
