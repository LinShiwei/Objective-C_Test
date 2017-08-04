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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
