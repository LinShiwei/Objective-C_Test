//
//  main.m
//  TestRunLoop2
//
//  Created by Lin,Shiwei on 2017/8/6.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
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
    @autoreleasepool {
//        CFRunLoopObserverContext context = {
//            0,
//            (__bridge void *)(self),
//            NULL,
//            NULL,
//            NULL
//        };
        CFRunLoopObserverRef observerRef = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &runloopCallback, NULL);
        CFRunLoopAddObserver(CFRunLoopGetCurrent(), observerRef, kCFRunLoopCommonModes);
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
