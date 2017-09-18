//
//  ViewController.m
//  TestLock
//
//  Created by Linsw on 2017/9/14.
//  Copyright © 2017年 Linsw. All rights reserved.
//

#import "ViewController.h"
#import "Task.h"
@interface ViewController ()
@property (nonatomic,strong) Task *task;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.task = [[Task alloc] init];
    __weak ViewController *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ViewController *strongSelf = weakSelf;
        ClassMethodCallLog(@"dispatch1");
        [strongSelf.task run];
        
        
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ViewController *strongSelf = weakSelf;
        ClassMethodCallLog(@"dispatch2");
        [strongSelf.task run];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ViewController *strongSelf = weakSelf;
        ClassMethodCallLog(@"dispatch3");
        [strongSelf.task run];
    });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
