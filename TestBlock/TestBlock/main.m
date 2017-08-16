//
//  main.m
//  TestBlock
//
//  Created by Lin,Shiwei on 2017/8/15.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

void exampleA() {
    char a = 'A';
    ^{
        printf("%cn", a);
    }();
}

void exampleB_addBlockToArray(NSMutableArray *array) {
//    char b = 'B';
//    static char b = 'B';
    
    static int c = 11;
    __block int b = 1;
//    int b = 1;
    b = 2;
    [array addObject:^{
        NSLog(@"%d",b);
        int aa = b;
        NSLog(@"%d",b);
        NSLog(@"%d",c);

    }];
    
    void (^block)() = [array objectAtIndex:0];
    block();
    //ARC: array[0]: (__NSMallocBlock__ *) $0 = 0x0000600000046c30
    //MRC: array[0]: (__NSStackBlock__ *) $0 = 0x00007fff52e684b0

}

void exampleB() {
    NSMutableArray *array = [NSMutableArray array];
    exampleB_addBlockToArray(array);
    void (^block)() = [array objectAtIndex:0];
    block();
    //ARC: block: (void (^)(...)) $1 = 0x0000000106df74c0
    //ARC: array[0]: (__NSMallocBlock__ *) $0 = 0x0000600000046c30

}

void exampleC_addBlockToArray(NSMutableArray *array) {
    [array addObject:^{
        printf("Cn");
    }];
    //ARC: array[0]: (__NSGlobalBlock__ *) $3 = 0x0000000106df9140
    //MRC: array[0]: (__NSGlobalBlock__ *) $5 = 0x000000010cd99120

}

void exampleC() {
    NSMutableArray *array = [NSMutableArray array];
    exampleC_addBlockToArray(array);
    void (^block)() = [array objectAtIndex:0];
    block();
    
    //ARC: block: (void (^)(...)) $5 = 0x0000000106df7630
    //ARC: array[0]: (__NSGlobalBlock__ *) $4 = 0x0000000106df9140

    
    //MRC: block: (void (^)(...)) $6 = 0x000000010cd97740
    //MRC: array[0]: (__NSGlobalBlock__ *) $7 = 0x000000010cd99120

}

typedef void (^dBlock)();

//dBlock exampleD_getBlock() {
//    char d = 'D';
//    return ^{
//        printf("%cn", d);
//    };
//}

void exampleD() {
//    exampleD_getBlock()();
}

typedef void (^eBlock)();

eBlock exampleE_getBlock() {
    char e = 'E';
    void (^block)() = ^{
        printf("%cn", e);
    };
    //ARC: block: (void (^)(...)) $6 = 0x0000000106df7870

    //MRC: block: (void (^)(...)) $8 = 0x000000010cd97830

    return block;
}

void exampleE() {
    eBlock block = exampleE_getBlock();
    block();
    //ARC: block: (eBlock) $7 = 0x0000000106df7870
    
    //MRC: block: (eBlock) $9 = 0x000000010cd97858

    
}

void exampleF() {
    char a = 'F';
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:^{
        printf("FF");
    }];
    void (^block)() = [arr objectAtIndex:0];
    block();
    //ARC: array[0]: (__NSGlobalBlock__ *) $1 = 0x000000010c2031c0
    //ARC: block: (void (^)(...)) $2 = 0x000000010c2018d0
    
    //MRC: array[0]: (__NSGlobalBlock__ *) $11 = 0x000000010cd99180
    //MRC: block: (void (^)(...)) $10 = 0x000000010cd97930
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        exampleA();
        exampleB();
        exampleC();
        exampleD();
        exampleE();
        exampleF();
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
