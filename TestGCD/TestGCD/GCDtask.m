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
//    [self sourceTask];
//    [self suspendTask];
//    [self setTargetQueueTask];
//    [self task1];
//    [self task2];
}

- (void)groupTask{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("group1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("group2", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue3 = dispatch_queue_create("group3", DISPATCH_QUEUE_SERIAL);

    dispatch_group_async(group, queue, ^{
        NSLog(@"1--%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:3];

    });
    //notify 前面如果没有任何任务加入到queue里，则会直接执行，如果有任务，才会等以加入的任务完成后，再执行。
    //在执行notify回调之前，如果持续有新任务加入到group中，则notify会一直延续到所有任务完成后再执行。
    //group-notify,可以监测多个queue，不同的queue可以用在同一个group中。notify会等所有queue中的任务完成后再执行。notify也可以选择在不同的queue中执行。
    //如果设置了多个notify，则当group中的所有queue的任务完成后，它们会同时开始执行，notify里带有参数queue，他们会在自己对应的queue中执行，并发或串行执行取决于它们对应的queue。
    dispatch_group_notify(group, queue, ^{
        NSLog(@"finish");
    });
    [NSThread sleepForTimeInterval:1];

    dispatch_group_async(group, queue2, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2--%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2];
    });
    
    dispatch_group_async(group, queue2, ^{
        NSLog(@"3--%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue2, ^{
        NSLog(@"4--%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue3, ^{
        NSLog(@"5--%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:1];
    });
    dispatch_group_async(group, queue3, ^{
        NSLog(@"6--%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue3, ^{
        NSLog(@"7--%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:3];
    });
    dispatch_group_notify(group, queue, ^{
        NSLog(@"finish2--%@",[NSThread currentThread]);
        NSLog(@"finish2--%@",[NSThread currentThread]);
        NSLog(@"finish2--%@",[NSThread currentThread]);
        NSLog(@"finish2--%@",[NSThread currentThread]);

    });
    dispatch_group_notify(group, queue, ^{
        NSLog(@"finish3--%@",[NSThread currentThread]);
    });
    dispatch_group_notify(group, queue3, ^{
        NSLog(@"finish4--%@",[NSThread currentThread]);
        NSLog(@"finish4--%@",[NSThread currentThread]);
        NSLog(@"finish4--%@",[NSThread currentThread]);
        NSLog(@"finish4--%@",[NSThread currentThread]);
        
    });
    dispatch_group_notify(group, queue3, ^{
        NSLog(@"finish5--%@",[NSThread currentThread]);
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"finsh6 in main,thread %@",[NSThread currentThread]);
        
    });
}

- (void)barrierTask{
    //barrier 只能用在同一个queue中。而group可以用在不同的queue之间
    //多个barrier会顺序执行，必须等前一个barrier执行完毕再执行下一个。
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
        NSLog(@"----barrier-----%@", [NSThread currentThread]);
        NSLog(@"----barrier-----%@", [NSThread currentThread]);
        NSLog(@"----barrier-----%@", [NSThread currentThread]);
        NSLog(@"----barrier-----%@", [NSThread currentThread]);
        NSLog(@"----barrier-----%@", [NSThread currentThread]);

    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"----barrier2-----%@", [NSThread currentThread]);
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"----barrier3-----%@", [NSThread currentThread]);
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

- (void)sourceTask{
    dispatch_queue_t queue = dispatch_queue_create("source", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t main = dispatch_get_main_queue();
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, main);
    dispatch_source_set_event_handler(source, ^{
        NSLog(@"source add: %lu",dispatch_source_get_data(source));
    });
    dispatch_resume(source);
//
    //always call dispatch_apply from a background queue because it is synchronous and will also use the current thread amongst the various threads it uses.
    //dispatch_apply 会阻塞当前线程。
    dispatch_async(queue, ^{
        dispatch_apply(10, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
            // do some work on data at index
            [NSThread sleepForTimeInterval:index];
            NSLog(@"sleep %lu, in thread %@",index,[NSThread currentThread]);
            dispatch_source_merge_data(source, 1);
        });
    });
}

- (void)suspendTask{
    dispatch_queue_t queue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        NSLog(@"1");
        [NSThread sleepForTimeInterval:1];
    });
    dispatch_async(queue, ^{
        NSLog(@"2");
        [NSThread sleepForTimeInterval:1];
    });
    NSLog(@"main sleep for 0.5");
    [NSThread sleepForTimeInterval:0.5];
    NSLog(@"main end sleep for 0.5");
    
    dispatch_suspend(queue);
    dispatch_async(queue, ^{
        NSLog(@"3");
        [NSThread sleepForTimeInterval:1];
    });
    NSLog(@"main sleep for 3");
    [NSThread sleepForTimeInterval:3];
    NSLog(@"main end sleep for 3");
    dispatch_resume(queue);

}

- (void)setTargetQueueTask{
    dispatch_queue_t queue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
    dispatch_set_target_queue(queue, dispatch_get_main_queue());
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);//main queue
    });

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
