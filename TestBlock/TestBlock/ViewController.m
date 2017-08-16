//
//  ViewController.m
//  TestBlock
//
//  Created by Lin,Shiwei on 2017/8/15.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __block int i = 1024;//此时i在栈上
    int j = 1;//此时j在栈上
    void (^blk)(void);
    blk = ^{printf("%d, %d\n", i, j); };//此时，blk已经初始化，它会拷贝没有__block标记的常规变量自己所持有的一块内存区，这块内存区现在位于栈上，而对于具有__block标记的变量，其地址会被拷贝置前述的内存区中
    blk();//1024, 1
    void(^blkInHeap)(void) = [blk copy];//复制block后，block所持有的内存区会被拷贝至堆上，此时，我们可以说，这个block现在位于堆上
    blkInHeap();//1024,1
    i++;
    j++;
    blk();//1025,1
    blkInHeap();//1025,1
//    NSString *str = [[NSString alloc] initWithFormat:@"hehe"]; // ARC
//    NSTimer * __strong timer;
//    __strong NSTimer * timer1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
