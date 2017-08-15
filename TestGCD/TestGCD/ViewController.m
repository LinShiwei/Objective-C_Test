//
//  ViewController.m
//  TestGCD
//
//  Created by Lin,Shiwei on 2017/8/11.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewController.h"
#import "LabelA.h"
#import "GCDtask.h"
@interface ViewController ()
@property (nonatomic,strong) LabelA *labelA;
@property (nonatomic,strong) GCDtask *task;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _labelA = [[LabelA alloc] init];
    _task = [[GCDtask alloc] init];
    [_task runTask];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
//    
//    dispatch_async(queue, ^{
//        _labelA
//    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
