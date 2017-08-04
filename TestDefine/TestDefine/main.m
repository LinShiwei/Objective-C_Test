//
//  main.m
//  TestDefine
//
//  Created by Lin,Shiwei on 2017/8/4.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#define SECONDS_PER_YEAR 60*60*24*365UL
#define aaa(A,B)	({ __typeof__(A) __a = (A); __typeof__(B) __b = (B); __a < __b ? __a : __b; })

#define bbb(X,Y) ((X)<(Y)?(X):(Y))
int main(int argc, char * argv[]) {
    @autoreleasepool {
        int a = SECONDS_PER_YEAR + 1;
        NSLog(@"%d",a);
        int i = 1;
        int j = 1;
        NSLog(@"%d",MIN(4, 2));
        NSLog(@"%d",aaa(4,2));
        
        NSLog(@"%d",aaa(++i,100));
        NSLog(@"%d",bbb(++i,100));
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
