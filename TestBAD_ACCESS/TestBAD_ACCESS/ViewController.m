//
//  ViewController.m
//  TestBAD_ACCESS
//
//  Created by Lin,Shiwei on 2017/8/12.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,assign) NSDate* dangerDate;//assign!
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-1];
    _dangerDate = date;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    double cc = [_dangerDate timeIntervalSinceReferenceDate];//cause BAD_ACCESS
    //When enable zombie, following log will be printed in console
    //2017-08-12 22:07:32.619 TestBAD_ACCESS[17098:3284528] *** -[__NSDate timeIntervalSinceReferenceDate]: message sent to deallocated instance 0x600000007d10

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
