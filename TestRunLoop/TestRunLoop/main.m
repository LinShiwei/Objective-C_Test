//
//  main.m
//  TestRunLoop
//
//  Created by Linsw on 2017/8/5.
//  Copyright © 2017年 Linsw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

void runloopCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    NSString* activityStr = @"unkown";
    if (((activity >> 0)&1) == 1) {
        activityStr = @"kCFRunLoopEntry";
    }
    else if (((activity >> 1)&1) == 1){
        activityStr = @"kCFRunLoopBeforeTimers";
    }
    else if (((activity >> 2)&1) == 1){
        activityStr = @"kCFRunLoopBeforeSources";
    }
    else if (((activity >> 5)&1) == 1){
        activityStr = @"kCFRunLoopBeforeWaiting";
    }
    else if (((activity >> 6)&1) == 1){
        activityStr = @"kCFRunLoopAfterWaiting";
    }
    else if (((activity >> 7)&1) == 1){
        activityStr = @"kCFRunLoopExit";
    }
    else
    {
        activityStr = @"kCFRunLoopAllActivities";
    }
    
    printf("[%.4f] activity:%s\n",CFAbsoluteTimeGetCurrent(),activityStr.UTF8String);
}



int main(int argc, char * argv[]) {
    NSLog(@"%@",[NSThread currentThread]);
        @autoreleasepool {
            //current mode = (none),

            CFRunLoopObserverRef observerRef = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &runloopCallback, NULL);
            CFRunLoopAddObserver(CFRunLoopGetCurrent(), observerRef, kCFRunLoopCommonModes);
            
           
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }
    
}

/*
#include <Foundation/Foundation.h>

#include <time.h>

clock_t entryTM = 0;
clock_t exitTM = 0;

void callback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    exitTM = clock();
    NSLog(@"Total: %.5fs", (exitTM - entryTM) * 1.0/CLOCKS_PER_SEC);
    entryTM = clock();
}
int main(int argc, char * argv[]) {
//    @autoreleasepool {
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//    }
    
    CFRunLoopObserverRef observerRef = CFRunLoopObserverCreate(
                                                               kCFAllocatorDefault,
                                                               kCFRunLoopBeforeTimers,
                                                               true,
                                                               0,
                                                               callback,
                                                               NULL);
    CFRunLoopAddObserver(
                         CFRunLoopGetCurrent(),
                         observerRef,
                         kCFRunLoopCommonModes);
    
    if (CFRunLoopContainsObserver(CFRunLoopGetCurrent(),
                                  observerRef,
                                  kCFRunLoopCommonModes))
    {
        NSLog(@"Has observer!");
    }
    
    [NSTimer scheduledTimerWithTimeInterval: 1 
                                     target: nil
                                   selector: @selector(print) 
                                   userInfo: nil 
                                    repeats: YES];
    
    CFRunLoopRun();
    
    return 0;
}
 
 */
