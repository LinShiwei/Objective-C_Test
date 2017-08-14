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
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_queue_t queue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
//    dispatch_queue_t queue = dispatch_queue_create("cocurr", DISPATCH_QUEUE_CONCURRENT);
//
//    dispatch_async(queue, ^{
//        NSLog(@"任务1---%@", [NSThread currentThread]);
//        _labelA.str = @"111";
//        NSLog(@"任务1---%@", [NSThread currentThread]);
//
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"任务2---%@", [NSThread currentThread]);
//        _labelA.str = @"222";
//        NSLog(@"任务2---%@", [NSThread currentThread]);
//    });
//    dispatch_barrier_async(queue, ^{
//        NSLog(@"任务5---%@---%@", [NSThread currentThread],_labelA.str);
//
//    });
//    
////    dispatch_async(queue, ^{
////        NSLog(@"任务5---%@---%@", [NSThread currentThread],_labelA.str);
////    });
//    dispatch_async(queue, ^{
//        NSLog(@"任务3---%@", [NSThread currentThread]);
//        _labelA.str = @"333";
//        NSLog(@"任务3---%@", [NSThread currentThread]);
//    });
//    dispatch_barrier_async(queue, ^{
//        NSLog(@"任务4---%@---%@", [NSThread currentThread],_labelA.str);
//    });
//    
    
/*    dispatch_queue_t queue = dispatch_queue_create("12312312", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"----1-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----2-----%@", [NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"----barrier-----%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"----3-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----4-----%@", [NSThread currentThread]);
    });//*/
    
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_apply(6, queue, ^(size_t index) {
//        NSLog(@"%zd------%@",index, [NSThread currentThread]);
//    });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
