//
//  ViewController.m
//  TestExternStatic
//
//  Created by Lin,Shiwei on 2017/8/3.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewController.h"
#import "ViewA.h"
@interface ViewController ()

@end
// 全局变量：只有一份内存，所有文件共享，与extern联合使用。

int a = 20;
// static修饰全局变量
static int age = 20;

//只在本文件内可用，实现类似于#define的功能。
static const NSTimeInterval kInterval = 3;

@implementation ViewController



- (void)test
{
    // static修饰局部变量
    static int age = 0;
    age++;
    NSLog(@"%d",age);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self test];
    [self test];
    
    extern int age;
    NSLog(@"%d",age);
    
    //用extern修饰的话，也需要import相应的头文件才能用。
    //使用extern修饰声明变量，然后在m文件中定义变量的值，这样可以保护变量，当h文件暴露给开发者时，可以防止变量的值被修改。
    NSLog(@"%@",VAStr);
    
//    NSLog(@"%d",b);

}


@end
