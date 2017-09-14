//
//  ViewController.m
//  TestDefine
//
//  Created by Lin,Shiwei on 2017/8/4.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    __typeof__(self) vc = [[ViewController alloc] init]   ;
    NSLog(@"%@",[vc class]);
NSLog(@"%p, %p",[ViewController class], [self class]);
    
    Class cls = NSClassFromString(@"ViewController");
    
    
    NSString *s = @"我是女生，漂亮的女生";
    NSString *ss = @"漂亮";
    NSRange r = [self findString:ss in:s];
    
    
    
//    [self moveArr:@[1,2,3,4,5,6] count:2];
}

- (NSRange)findString:(NSString* )target in:(NSString *)str{
    return [str rangeOfString:target];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)moveArr:(NSArray *)arr count:(NSInteger)n{
    NSMutableArray *marr = [NSMutableArray array];
    for (NSInteger i = n; i<arr.count; i++) {
        [marr addObject:arr[i]];
    }
    for (NSInteger i = 0; i<n; i++) {
        [marr addObject:arr[i]];
    }
    
    return [marr copy];
}


@end
