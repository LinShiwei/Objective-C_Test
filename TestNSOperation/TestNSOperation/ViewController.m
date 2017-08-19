//
//  ViewController.m
//  TestNSOperation
//
//  Created by Lin,Shiwei on 2017/8/15.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewController.h"
#import "define.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self task1];
    [self task2];
//    [self task3];
//    [self task4];
//    [self task5];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that3  can be recreated.
}

- (void)task0{
    __weak id weakSelf = self;
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        NSLog(@"task0 heavy work in thread %@",[NSThread currentThread]);
        sleep(3);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            __typeof__(self) strongSelf = weakSelf;
            NSLog(@"task0 ui in thread %@",[NSThread currentThread]);
        }];
    }];
}

- (void)task1{
//    NSMethodSignature *sign = [[self class] instanceMethodSignatureForSelector:@selector(customSelector)];
    NSMethodSignature *sig = [self methodSignatureForSelector:@selector(customSelector)];
    NSInvocation *invo = [NSInvocation invocationWithMethodSignature:sig];
    invo.target = self;//这两行不能少
    invo.selector = @selector(customSelector);//这两行不能少
    NSInvocationOperation *opera = [[NSInvocationOperation alloc] initWithInvocation: invo];
    NSOperationQueue *que = [[NSOperationQueue alloc] init];
    [que addOperation:opera];
//    [opera start ];
}

- (void)task2{
    NSInvocationOperation *opera = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(customSelector) object:nil];
//    NSOperationQueue *que = [[NSOperationQueue alloc] init];
//    [que addOperation:opera];
    [opera start];//如果不加入queue，则会在当前线程运行,并且是同步运行，会阻塞线程直至完成。
    NSLog(@"task2 is async %d",[opera isAsynchronous]);
    NSLog(@"task2 %f",CFAbsoluteTimeGetCurrent());
}

- (void)task3{
    __weak __typeof(self) weakSelf = self;
    NSBlockOperation *opera = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf customSelector];
    }];
    NSOperationQueue *que = [[NSOperationQueue alloc] init];
    [que addOperation:opera];
//    [opera start];

}

- (void)task4{
    NSOperationQueue *que = [[NSOperationQueue alloc] init];
    que.maxConcurrentOperationCount = 2;//当任务书大于最大并发数时，后来的任务需等前面的任务完成才开始，且queue会维护一个线程池，后来的任务会使用前面任务执行的线程执行，当没有可复用的线程时，才开辟新的线程。
    for (int i = 0; i<10; i++) {
        if (i == 9) {
            NSInvocationOperation *opera = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(customSel2) object:nil];
            [que addOperation:opera];
            opera.queuePriority = NSOperationQueuePriorityHigh;
            continue;
        }
        
        NSInvocationOperation *opera = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(customSelector) object:nil];
        [que addOperation:opera];
    }
}

- (void)task5{
    NSOperationQueue *que = [[NSOperationQueue alloc] init];
    NSOperation *pre = nil;
    for (int i = 0; i<10; i++) {
        NSInvocationOperation *opera = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(customSelector) object:nil];
        if (pre) {
            [opera addDependency:pre];
        }
        pre = opera;
        [que addOperation:opera];
    }
}
- (void)customSelector{
    NSLog(@"customSelector %f",CFAbsoluteTimeGetCurrent());
    ClassMethodCallLog(@"customSelector");
    NSLog(@"begin %@",[NSThread currentThread]);
    [NSThread sleepForTimeInterval:1];
    NSLog(@"%@",[NSThread currentThread]);
    NSLog(@"customSelector %f",CFAbsoluteTimeGetCurrent());

}

- (void)customSel2{
    ClassMethodCallLog(@"customSel2");
    NSLog(@"begin %@",[NSThread currentThread]);
    [NSThread sleepForTimeInterval:2];
    NSLog(@"%@",[NSThread currentThread]);

}

@end
