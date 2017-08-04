//
//  ViewController.m
//  TestCopyProperty
//
//  Created by Lin,Shiwei on 2017/8/3.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewController.h"
#import "ViewA.h"
@interface ViewController ()
@property (nonatomic,strong) NSMutableString *vcStr;
@property (nonatomic,strong) ViewA *viewA;
@property (nonatomic,strong) NSMutableArray * muarr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    int a = 10;
    _vcStr = [NSMutableString stringWithFormat:@"%d",a];
    
    _viewA = [[ViewA alloc] init];
    
    _viewA.strL = [_vcStr mutableCopy];
    
    _muarr = [NSMutableArray array];
    
//    _viewA.arr = [_muarr mutableCopy];
    NSLog(@"vcstr : %@",_vcStr);
    [_viewA changeStrL];
    
    NSLog(@"_va_str : %@",_viewA.strL);

    [_viewA changeStrLWith:_vcStr];
    
    NSLog(@"_va_changestr : %@",_viewA.strL);

}

- (void)viewDidAppear:(BOOL)animated{
//    _vcStr
    
    [_viewA.strL appendString:@"aad"];
    
    
    
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
