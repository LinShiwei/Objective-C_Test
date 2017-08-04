//
//  ViewController.m
//  TestExternStatic
//
//  Created by Lin,Shiwei on 2017/8/3.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end
// 全局变量：只有一份内存，所有文件共享，与extern联合使用。

int a = 20;
// static修饰全局变量
static int age = 20;
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
}


@end
