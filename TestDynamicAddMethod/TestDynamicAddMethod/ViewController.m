//
//  ViewController.m
//  TestDynamicAddMethod
//
//  Created by Lin,Shiwei on 2017/8/2.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) AddMethodViewA *addMethodViewA;
@property (nonatomic, assign) BOOL isAborted;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isAborted = NO;

    // Do any additional setup after loading the view, typically from a nib.
    _addMethodViewA = [[AddMethodViewA alloc] init];
    [_addMethodViewA performSelector:@selector(newMethod)];//默认在main thread中执行，虽然有警告，但是不影响调用。
    
    [_addMethodViewA performSelectorInBackground:@selector(existedMethod) withObject:nil];//虽然有警告，但是不影响调用。
    
    
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(newThread:) object:nil];
    [thread start];
    //    When performing a selector on another thread, the target must have an active run loop
    [self performSelector:@selector(test:) onThread:thread withObject:nil waitUntilDone:false];
    NSLog(@"done");
}

- (void)newThread:(id)obj {
    @autoreleasepool {
        NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
        while (!_isAborted) {
            [currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        NSLog(@"线程停止");
    }
}

- (void)test:(id)obj {
    [self threadInfo:@"test"];
    _isAborted = YES;
}

- (void)threadInfo:(NSString *)info {
    NSLog(@"%@--%@", info, [NSThread currentThread]);
}

@end
