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
//    [self barrierTask];
//    [self sourceTask];
//    [self sourceTask2];
//    [self timerTask];
    [self suspendTask0];
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
    //事件句柄根据已完成的工作单元来更新进度条。若主线程比较空闲并且这些工作单元进行的比较慢，那么事件句柄会在每个工作单元完成的时候被调用，实时更新。如果主线程忙于其他工作，或者工作单元完成速度很快，那么完成事件会被联结起来，导致进度条只在主线程变得可用时才被更新，并且一次将积累的改变更新至GUI。
    //现在你可能会想，听起来倒是不错，但是要是我不想让事件被联结呢？有时候你可能想让每一次信号都会引起响应，什么后台的智能玩意儿统统不要。啊。。其实很简单的，别把自己绕进去了。如果你想让每一个信号都得到响应，那使用dispatch_async函数不就行了。实际上，使用的dispatch source而不使用dispatch_async的唯一原因就是利用联结的优势。
}

- (void)sourceTask2{
    //创建source，以DISPATCH_SOURCE_TYPE_DATA_ADD的方式进行累加，而DISPATCH_SOURCE_TYPE_DATA_OR是对结果进行二进制或运算
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_main_queue());
    
    //事件触发后执行的句柄
    dispatch_source_set_event_handler(source,^{
        
        NSLog(@"监听函数：%lu",dispatch_source_get_data(source));
        
    });
    
    //开启source
    dispatch_resume(source);
    
    dispatch_queue_t myqueue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(myqueue, ^ {
        
        for(int i = 1; i <= 4; i ++){
            
            NSLog(@"~~~~~~~~~~~~~~%d", i);
            
            //触发事件，向source发送事件，这里i不能为0，否则触发不了事件
            dispatch_source_merge_data(source,i);
            
            //当Interval的事件越长，则每次的句柄都会触发
            [NSThread sleepForTimeInterval:0.001];
        }
    });
    
}

- (void)sourceTask3{
    //1、指定DISPATCH_SOURCE_TYPE_DATA_ADD，做成Dispatch Source(分派源)。设定Main Dispatch Queue 为追加处理的Dispatch Queue
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_main_queue());
    
    __block NSUInteger totalComplete = 0;
    
    dispatch_source_set_event_handler(source, ^{
        
        //当处理事件被最终执行时，计算后的数据可以通过dispatch_source_get_data来获取。这个数据的值在每次响应事件执行后会被重置，所以totalComplete的值是最终累积的值。
        NSUInteger value = dispatch_source_get_data(source);
        
        totalComplete += value;
        
        NSLog(@"进度：%@", @((float)totalComplete/100));
        
        NSLog(@":large_blue_circle:线程号：%@", [NSThread currentThread]);
    });
    
    //分派源创建时默认处于暂停状态，在分派源分派处理程序之前必须先恢复。
    dispatch_resume(source);
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //2、恢复源后，就可以通过dispatch_source_merge_data向Dispatch Source(分派源)发送事件:
    for (NSUInteger index = 0; index < 100; index++) {
        
        dispatch_async(queue, ^{
            
            dispatch_source_merge_data(source, 1);
            
            NSLog(@":recycle:线程号：%@~~~~~~~~~~~~i = %ld", [NSThread currentThread], index);
            
            usleep(20000);//0.02秒
            
        });
    }
    
    //3、比较上面的for循环代码，将dispatch_async放在外面for循环的外面，打印结果不一样
    //dispatch_async(queue, ^{
    //
    //    for (NSUInteger index = 0; index < 100; index++) {
    //
    //        dispatch_source_merge_data(source, 1);
    //
    //        NSLog(@":recycle:线程号：%@~~~~~~~~~~~~i = %ld", [NSThread currentThread], index);
    //
    //        usleep(20000);//0.02秒
    //    }
    //});
    
    
    //2是将100个任务添加到queue里面，而3是在queue里面添加一个任务，而这一个任务做了100次循环
    
}

- (void)timerTask{
    //倒计时时间
    __block int timeout = 3;
    
    //创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //创建timer
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //设置1s触发一次，0s的误差
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    //触发的事件
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            //取消dispatch源
            dispatch_source_cancel(_timer);
            
        }
        else{
            
            timeout--;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //更新主界面的操作
                
                NSLog(@"~~~~~~~~~~~~~~~~%d", timeout);
                
            });
        }
    });
    
    //开始执行dispatch源
    dispatch_resume(_timer);
}


- (void)suspendTask0{
    //创建DISPATCH_QUEUE_SERIAL队列
    dispatch_queue_t queue1 = dispatch_queue_create("com.iOSChengXuYuan.queue1", 0);
    dispatch_queue_t queue2 = dispatch_queue_create("com.iOSChengXuYuan.queue2", 0);
    
    //创建group
    dispatch_group_t group = dispatch_group_create();
    
    //异步执行任务
    dispatch_async(queue1, ^{
        NSLog(@"任务 1 ： queue 1...");
        sleep(3);
        NSLog(@":white_check_mark:完成任务 1");
    });
    
    dispatch_async(queue2, ^{
        NSLog(@"任务 1 ： queue 2...");
        sleep(3);
        NSLog(@":white_check_mark:完成任务 2");
    });
    
    //将队列加入到group
    dispatch_group_async(group, queue1, ^{
        NSLog(@":no_entry_sign:正在暂停 1");
        dispatch_suspend(queue1);
    });
    
    dispatch_group_async(group, queue2, ^{
        NSLog(@":no_entry_sign:正在暂停 2");
        dispatch_suspend(queue2);
    });
    
    //等待两个queue执行完毕后再执行
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"＝＝＝＝＝＝＝等待两个queue完成, 再往下进行...");
    
    //异步执行任务
    dispatch_async(queue1, ^{
        NSLog(@"任务 2 ： queue 1");
    });
    dispatch_async(queue2, ^{
        NSLog(@"任务 2 ： queue 2");
    });
    
    //在这里将这两个队列重新恢复
    sleep(5);
    dispatch_resume(queue1);
    dispatch_resume(queue2);
    //dispatch_suspend 会暂停队列里的任务，正在执行的block会继续执行完，之后的block不会被执行，等到resume后才执行后续的block任务
    
    //当将dispatch_group_wait(group, DISPATCH_TIME_FOREVER);注释后，会产生崩溃，因为所有的任务都是异步执行的，在执行恢复queue1和queue2队列的时候，可能这个时候还没有执行queue1和queue2的挂起队列
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
