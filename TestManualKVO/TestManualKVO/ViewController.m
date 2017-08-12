//
//  ViewController.m
//  TestManualKVO
//
//  Created by Lin,Shiwei on 2017/8/12.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
@interface ViewController ()
@property (nonatomic, strong) Student *student;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 创建学生对象
    _student = [[Student alloc] init];
    
    // 监听属性name
    [_student addObserver:self
               forKeyPath:@"name"  // 属性
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:nil];
    
    // 监听实例变量age
    [_student addObserver:self
               forKeyPath:@"age"   // 实例变量
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:nil];
    
    _student.name = @"YouXianMing"; // 改变名字
    _student.age  = @"18";          // 改变年龄
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    NSLog(@"%@", change);
}
@end
