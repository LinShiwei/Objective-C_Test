//
//  GCDtask.m
//  TestGCD
//
//  Created by Lin,Shiwei on 2017/8/14.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "GCDtask.h"

@implementation GCDtask
- (void)runTask{
//    [self groupTask];
    [self barrierTask];
    [self task1];
    [self task2];
}

- (void)groupTask{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("group1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("group2", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"1");
        [NSThread sleepForTimeInterval:3];

    });
    //notify 前面如果没有任何任务加入到queue里，则会直接执行，如果有任务，才会等以加入的任务完成后，再执行。
    //在执行notify回调之前，如果持续有新任务加入到group中，则notify会一直延续到所有任务完成后再执行。
    //group-notify,可以监测多个queue，不同的queue可以用在同一个group中。notify会等所有queue中的任务完成后再执行。
    dispatch_group_notify(group, queue, ^{
        NSLog(@"finish");
    });
    [NSThread sleepForTimeInterval:1];

    dispatch_group_async(group, queue2, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2");
        [NSThread sleepForTimeInterval:2];
    });
    
    dispatch_group_async(group, queue2, ^{
        NSLog(@"3");
    });
    dispatch_group_async(group, queue2, ^{
        NSLog(@"4");
    });
    
}

- (void)barrierTask{
    //barrier 只能用在同一个queue中。而group可以用在不同的queue之间
    //下面的queue和queue2是不同的queue，它们内存地址不一样
    dispatch_queue_t queue = dispatch_queue_create("same", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("same", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{
        NSLog(@"----1-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----2-----%@", [NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"----barrier-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue2, ^{
        NSLog(@"----queue2-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----3-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----4-----%@", [NSThread currentThread]);
    });//*/
//    dispatch_release(queue);自动引用计数不需要这个；
}

- (void)task1{
    dispatch_queue_t queue1 = dispatch_queue_create("12312312", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("12312312", DISPATCH_QUEUE_CONCURRENT);

    NSAssert(![queue1 isEqual:queue2], @"即使identifier一样，两个queue也不是是同一个");
//    (lldb) p queue1
//    (OS_dispatch_queue *) $0 = 0x0000608000172a80
//    (lldb) p queue2
//    (OS_dispatch_queue *) $1 = 0x0000608000172b40
}

- (void)task2{
    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t queue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSAssert([queue1 isEqual:queue2], @"两个queue是同一个");

//    (lldb) p queue1
//    (OS_dispatch_queue_root *) $2 = 0x0000000106fa93c0
//    (lldb) p queue2
//    (OS_dispatch_queue_root *) $3 = 0x0000000106fa93c0
}
@end
