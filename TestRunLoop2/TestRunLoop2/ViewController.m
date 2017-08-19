//
//  ViewController.m
//  TestRunLoop2
//
//  Created by Lin,Shiwei on 2017/8/6.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewController.h"
#import "CustomLabel.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong,nonatomic) CustomLabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CFRunLoopRef runloopRef = CFRunLoopGetCurrent();
    struct __CFRunLoop* runloopStructPointer = runloopRef;
    
    _label = [[CustomLabel alloc] init];
    [_label drawTextInRect:[_label bounds]];
    
    [self.view addSubview:_label];
    
    //use po to print runloopStructPointer
    
    CFOptionFlags activities = kCFRunLoopBeforeWaiting;
//    CFRunLoopObserverContext context = {
//        0,           // version
//        (__bridge void *)transactionGroup,  // info
//        &CFRetain,   // retain
//        &CFRelease,  // release
//        NULL         // copyDescription
//    };
    static CFRunLoopObserverRef observer;

    observer = CFRunLoopObserverCreate(NULL,        // allocator
                                       activities,  // activities
                                       YES,         // repeats
                                       INT_MAX,     // order after CA transaction commits
                                       &_callback,  // callback
                                       NULL);   // context
    CFRunLoopAddObserver(runloopRef, observer, kCFRunLoopCommonModes);
    CFRelease(observer);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*2);
    
}

static void _callback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    NSBlockOperation *p1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"operation %@",[NSThread currentThread]);
    }];
//    NSOperationQueue *que = [[NSOperationQueue alloc] init];
//    [que addOperation:p1];
    [p1 start];//主线程的operation start任务并不会唤醒runloop
//    //在
    NSLog(@"callback ");

}



@end
