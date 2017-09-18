//
//  Task.m
//  TestLock
//
//  Created by Linsw on 2017/9/14.
//  Copyright © 2017年 Linsw. All rights reserved.
//

#import "Task.h"
#import <pthread.h>
#import <os/lock.h>
@interface Task()
@property (nonatomic,strong) NSRecursiveLock *recLock;
@property (nonatomic,strong) NSCondition *condition;
@property (nonatomic,strong) NSConditionLock *conditionLock;
@property (nonatomic,strong) NSConditionLock *conditionLock2;
@property (nonatomic,assign) pthread_mutex_t lock;
@property (nonatomic,assign) pthread_rwlock_t rwLock;

@property (nonatomic,assign) os_unfair_lock_t unfairLock;

@property (nonatomic,assign) pthread_cond_t pcondition;
@property (nonatomic,assign) BOOL readyToGo;


@property (nonatomic,assign) bool donloadFinish;
@property (nonatomic,assign) NSInteger count;

@end
@implementation Task
__weak Task *weakSelf;

- (instancetype)init{
    
    self = [super init];
    if (self) {
        _recLock = [[NSRecursiveLock alloc] init];
        _conditionLock = [[NSConditionLock alloc] init];
        _donloadFinish = false;
        _count = 0;
        
        weakSelf = self;
        pthread_mutex_init(&_lock,NULL);
        pthread_rwlock_init(&_rwLock, NULL);
        /*
         参数 rwlock 是一个指向读写锁的指针,参数 attr 是一个读写锁属性对象的指针,如果将
         NULL 传递给它,则使用默认属性来初始化一个读写锁。如果成功,pthread_rwlock_init
         就返回 0。如果不成功,pthread_rwlock_init 就返回一个非零的错误码。
         */
        
        pthread_cond_init(&_pcondition, NULL);
        _readyToGo = true;
        
        _unfairLock = &(OS_UNFAIR_LOCK_INIT);
        
    }
    return self;
}

- (void)run{

//    [self myRecursiveFunction:10];
//    [self nsconditionTestTask];
//    [self nsconditionlockTestTask];
//    [self pthreadMutexTestTask];
//    [self pthreadRWTestTask];
    [self pthreadConditionTestTask];
}

- (void)myRecursiveFunction:(NSInteger)value{
    [_recLock lock];
    if (value != 0)
    {
        --value;
        [self myRecursiveFunction:value];
        NSLog(@"%ld",(long)value);
    }
    [_recLock unlock];
}

- (void)nsconditionTestTask{
    _donloadFinish = false;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ClassMethodCallLog(@"dispatchRun_download");
        [self download];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ClassMethodCallLog(@"dispatchRun_doStuff");
        [self doStuffWithDownloadPicture];
    });
}

- (void)download {
    [self.condition lock];
    //TODO: 下载文件代码
    [NSThread sleepForTimeInterval:1];
    _donloadFinish = true;
    NSLog(@"sleep %@",[NSThread currentThread]);
    [NSThread sleepForTimeInterval:1];
    if (_donloadFinish) { // 下载结束后，给另一个线程发送信号，唤起另一个处理程序
        [self.condition signal];
        NSLog(@"finish == tru3 %@",[NSThread currentThread]);
        [self.condition unlock];
    }
}

- (void)doStuffWithDownloadPicture {
    [self.condition lock];
    while (!_donloadFinish) {
        [self.condition wait];
    }
    //TODO: 处理图片代码
    NSLog(@"do Stuff %@",[NSThread currentThread]);
    ClassMethodCallLog(@"doStuffWithDownloadPicture");
    [NSThread sleepForTimeInterval:2];
    [self.condition unlock];
}

- (void)nsconditionlockTestTask{
    _conditionLock2 = [[NSConditionLock alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ClassMethodCallLog(@"dispatchRun_download");
        __typeof(self) strongSelf = weakSelf;
        [strongSelf consumer];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ClassMethodCallLog(@"dispatchRun_doStuff");
        __typeof(self) strongSelf = weakSelf;
        [strongSelf producer];

    });
}

- (void)producer {
    while (YES) {
        [self.conditionLock lock];
        NSLog(@"have something");
        self.count++;
        [NSThread sleepForTimeInterval:0.5];
        [self.conditionLock unlockWithCondition:1];
        [NSThread sleepForTimeInterval:0.5];

    }
}

- (void)consumer {
    while (YES) {
//        NSLog(@"%d",self.conditionLock.condition);
        [self.conditionLock lockWhenCondition:1];
//        NSLog(@"%d",self.conditionLock.condition);

        NSLog(@"use something");
        self.count--;
        [NSThread sleepForTimeInterval:0.5];
        [self.conditionLock unlockWithCondition:0];
    }
}

- (void)pthreadMutexTestTask{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ClassMethodCallLog(@"dispatchRun_download");
        __typeof(self) strongSelf = weakSelf;
        [strongSelf pthreadMutexTask];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ClassMethodCallLog(@"dispatchRun_download");
        __typeof(self) strongSelf = weakSelf;
        [strongSelf pthreadMutexTask2];
    });
}

- (void)pthreadMutexTask{
    pthread_mutex_lock(&_lock);//同一把锁，如果用来锁两个函数的内部代码，如task和task2，则这两个函数内部代码之间是互斥的。
    _count++;
    NSLog(@"task1 %@, count: %d",[NSThread currentThread],_count);
    [NSThread sleepForTimeInterval:3];
    pthread_mutex_unlock(&_lock);
    
    /* Template
     pthread_mutex_init(&lock,NULL);
     pthread_mutex_lock(&lock);
     //do your stuff
     pthread_mutex_unlock(&lock);
     pthread_mutex_destroy(&lock);
     */
}

- (void)pthreadMutexTask2{
//    [NSThread sleepForTimeInterval:0.1];
    pthread_mutex_lock(&_lock);
    _count++;
    NSLog(@"task2 %@, count: %d",[NSThread currentThread],_count);
    [NSThread sleepForTimeInterval:1];
    pthread_mutex_unlock(&_lock);
}

- (void)pthreadRWTestTask{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ClassMethodCallLog(@"dispatchRun_doStuff");
        __typeof(self) strongSelf = weakSelf;
        [strongSelf pthreadRWLockReadTask:1];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ClassMethodCallLog(@"dispatchRun_doStuff");
        __typeof(self) strongSelf = weakSelf;
        [strongSelf pthreadRWLockReadTask:2];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ClassMethodCallLog(@"dispatchRun_doStuff");
        __typeof(self) strongSelf = weakSelf;
        [strongSelf pthreadRWLockWriteTask:3];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ClassMethodCallLog(@"dispatchRun_doStuff");
        __typeof(self) strongSelf = weakSelf;
        [strongSelf pthreadRWLockWriteTask:4];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ClassMethodCallLog(@"dispatchRun_doStuff");
        __typeof(self) strongSelf = weakSelf;
        [strongSelf pthreadRWLockReadTask:5];
    });
}

- (void)pthreadRWLockReadTask:(NSInteger)tag{
    pthread_rwlock_rdlock(&_rwLock);
    NSLog(@"start read ---- %ld",tag);
    [NSThread sleepForTimeInterval:1];
    NSLog(@"end   read ---- %ld",tag);
    pthread_rwlock_unlock(&_rwLock);
    /*
     // 初始化
     pthread_rwlock_t rwlock = PTHREAD_RWLOCK_INITIALIZER
     // 读模式
     pthread_rwlock_wrlock(&lock);
     // 写模式
     pthread_rwlock_rdlock(&lock);
     // 读模式或者写模式的解锁
     pthread_rwlock_unlock(&lock);
     */
}

- (void)pthreadRWLockWriteTask:(NSInteger)tag{
    pthread_rwlock_wrlock(&_rwLock);
    NSLog(@"start wirte ---- %ld",tag);
    [NSThread sleepForTimeInterval:1];
    NSLog(@"end   wirte ---- %ld",tag);
    pthread_rwlock_unlock(&_rwLock);
}

- (void)pthreadConditionTestTask{
//    _readyToGo == false;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ClassMethodCallLog(@"dispatchRun_doStuff");
        __typeof(self) strongSelf = weakSelf;
        [strongSelf pthreadWaitConditionFunc];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ClassMethodCallLog(@"dispatchRun_doStuff");
        __typeof(self) strongSelf = weakSelf;
        [strongSelf pthreadSignalFunc];
    });
}

- (void)pthreadWaitConditionFunc{
    // Lock the mutex.
    NSLog(@"pthread condition: will lock");
    pthread_mutex_lock(&_lock);
    NSLog(@"pthread condition: after lock");

    // If the predicate is already set, then the while loop is bypassed;
    // otherwise, the thread sleeps until the predicate is set.
    while(_readyToGo == false)
    {
        NSLog(@"pthread condition: will wait");
        pthread_cond_wait(&_pcondition, &_lock);
        NSLog(@"pthread condition: after wait");
    }
    // Do work. (The mutex should stay locked.)
    // Reset the predicate and release the mutex.
    _readyToGo = false;
    NSLog(@"pthread condition: will unlock");
    pthread_mutex_unlock(&_lock);
    NSLog(@"pthread condition: after unlock");
}

- (void)pthreadSignalFunc{
    // At this point, there should be work for the other thread to do.
    NSLog(@"pthread signal: will lock");
    pthread_mutex_lock(&_lock);
    NSLog(@"pthread signal: after lock");
    _readyToGo = true;
    // Signal the other thread to begin work.
    NSLog(@"pthread signal: will signal");
    pthread_cond_signal(&_pcondition);
    NSLog(@"pthread signal: after signal");
    NSLog(@"pthread signal: will unlock");
    pthread_mutex_unlock(&_lock);
    NSLog(@"pthread signal: after unlock");
}

- (void)unfairLockTask{
    //os_unfair_lock 用于替代OSSpinLock，解决了优先级反转的问题。
    os_unfair_lock_lock(_unfairLock);
    NSLog(@"%@",[NSThread currentThread]);
    [NSThread sleepForTimeInterval:1];
    os_unfair_lock_unlock(_unfairLock);
}

- (void)dealloc{
    pthread_mutex_destroy(&_lock);
    pthread_rwlock_destroy(&_rwLock);
    pthread_cond_destroy(&_pcondition);
}

@end
