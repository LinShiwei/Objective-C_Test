//
//  ViewController.m
//  TestRunLoop
//
//  Created by Linsw on 2017/8/5.
//  Copyright © 2017年 Linsw. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,weak) NSString *string_weak;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    CFRunLoopObserverContext context = {
//        0,
//        (__bridge void *)(self),
//        NULL,
//        NULL,
//        NULL
//    };
//    CFRunLoopObserverRef observerRef = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &runloopCallback, &context);
//    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observerRef, kCFRunLoopCommonModes);
//    
//    
//    CFRunLoopRef runloopRef = CFRunLoopGetCurrent();
//    struct __CFRunLoop* runloopStructPointer = runloopRef;
    //current mode = UIInitializationRunLoopMode,
    // 场景 1
    
    NSString *string = [NSString stringWithFormat:@"1234567890"];
    
    self.string_weak = string;
    
    //场景 2
    
    //        @autoreleasepool {
    
    //            NSString *string = [NSString stringWithFormat:@"1234567890"];
    
    //        _string_weak = string;
    
    //        }
    
    //    NSLog(@"string: %@",_string_weak);
    
    // 场景 3
    
    
    //        NSString *string = nil;
    
    //        @autoreleasepool {
    
    //            string = [NSString stringWithFormat:@”1234567890”];
    
    //
    
    //            _string_weak = string;
    
    //        }
    
    NSLog(@"%.4f  string: %@", CFAbsoluteTimeGetCurrent(),self.string_weak);
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    //current mode = UIInitializationRunLoopMode,
    
    [super viewWillAppear:animated];
    
    NSLog(@"%.4f  string: %@", CFAbsoluteTimeGetCurrent(),self.string_weak);
    
} 

- (void)viewDidAppear:(BOOL)animated { 
    
//    current mode = kCFRunLoopDefaultMode,

    CFRunLoopRef runloopRef = CFRunLoopGetCurrent();
    struct __CFRunLoop* runloopStructPointer = runloopRef;
    
    [super viewDidAppear:animated]; 
    
    NSLog(@"%.4f  string: %@", CFAbsoluteTimeGetCurrent(),self.string_weak);
    
}




//void runloopCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
//{
//    NSString* activityStr = @"unkown";
//    if (((activity >> 0)&1) == 1) {
//        activityStr = @"kCFRunLoopEntry";
//    }
//    else if (((activity >> 1)&1) == 1){
//        activityStr = @"kCFRunLoopBeforeTimers";
//    }
//    else if (((activity >> 2)&1) == 1){
//        activityStr = @"kCFRunLoopBeforeSources";
//    }
//    else if (((activity >> 5)&1) == 1){
//        activityStr = @"kCFRunLoopBeforeWaiting";
//    }
//    else if (((activity >> 6)&1) == 1){
//        activityStr = @"kCFRunLoopAfterWaiting";
//    }
//    else if (((activity >> 7)&1) == 1){
//        activityStr = @"kCFRunLoopExit";
//    }
//    else
//    {
//        activityStr = @"kCFRunLoopAllActivities";
//    }
//    
//    printf("[%.4f] activity:%s\n",CFAbsoluteTimeGetCurrent(),activityStr.UTF8String);
//}
@end
