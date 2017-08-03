//
//  ViewA+View_TestSuper.m
//  TestMessageForwarding
//
//  Created by Lin,Shiwei on 2017/8/2.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewA+View_TestSuper.h"

@implementation ViewA (View_TestSuper)

+ (void)load{
    ClassMethodCallLog(@"view_testSuper_load");
    
}

+ (void)initialize{
    ClassMethodCallLog(@"view_testSuper_initialize");

}

- (void)testSuper{
    NSString *str = [super description];
    NSLog(@"%@",str);
}

- (void)testOverride{
    ClassMethodCallLog(@"category_testOverride");
}//当类和category中声明了相同的方法，运行时会在类对象的方法列表里添加这两个方法，category的方法排在原类的方法前面，因此调用的时候会先找到category中的方法，先调用。而且不管调用的位置是否导入了category头文件、也不管声明的方法有没有暴露在外，category中的方法都会覆盖本类的方法。
@end
