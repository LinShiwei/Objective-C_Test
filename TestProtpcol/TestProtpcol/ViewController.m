//
//  ViewController.m
//  TestProtpcol
//
//  Created by Linsw on 2017/8/5.
//  Copyright © 2017年 Linsw. All rights reserved.
//

#import "ViewController.h"
#import "ViewA.h"
@interface ViewController ()
@property (nonatomic,strong) ViewA *viewA;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _viewA = [[ViewA alloc] quickInit];
    [_viewA protocolMethod];
    BOOL a = [_viewA respondsToSelector:@selector(protocolOptionalMethod)];
//    [_viewA protocolOptionalMethod];
    [_viewA printProperty];
    _viewA.property = @"bbb";
    
    NSLog(@"%@",_viewA.property);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
