//
//  main.m
//  TestTaggerPointer
//
//  Created by Lin,Shiwei on 2017/8/22.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSString *stra = @"a";
        NSString *a =[[stra mutableCopy] copy];//(NSTaggedPointerString *) $0 = 0xa000000000000611 @"111" (ASCII(a) = 97 = 0x61)

        NSString *straa = @"aa";
        NSString *aa =[[straa mutableCopy] copy];//(NSTaggedPointerString *) $1 = 0xa000000000061612 @"aa"

        NSString *stra7 = @"aaaaaaa";
        NSString *a7 =[[stra7 mutableCopy] copy];//(NSTaggedPointerString *) $0 = 0xa002082082082208 @"aaaaaaab"

        NSString *stra8 = @"aaaaaaab";
        NSString *a8 =[[stra8 mutableCopy] copy];//(NSTaggedPointerString *) $0 = 0xa616161616161617 @"aaaaaaa"

        NSString *stra1 = @"111";
        NSString *a1 =[[stra1 mutableCopy] copy];//(NSTaggedPointerString *) $0 = 0xa000000003131313 @"111" (ASCII(1) = 49 = 0x31)

        
        NSNumber *number3 = @3;
        NSNumber *number4 = @4;
        NSNumber *number9 = @9;
        NSLog(@"number3 pointer is %p", number3);
        NSLog(@"number4 pointer is %p", number4);
        NSLog(@"number9 pointer is %p", number9);

        
        NSLog(@"0xb000000000000052's class is %@",[(NSNumber*)0xb000000000000052 class]);
        
        NSNumber *numberBig = @(0x111111111111111);
        NSLog(@"numberBig pointer is %p, retaincount %d", numberBig,[numberBig retainCount]);
        
        
        [numberBig retain];
        NSLog(@"numberBig pointer is %p, retaincount %d", numberBig,[numberBig retainCount]);
//
//        void *a = malloc(1);
//        void *b = malloc(3);
//        NSLog(@"a: %p",a);
//        NSLog(@"b: %p",b);

        
        
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
