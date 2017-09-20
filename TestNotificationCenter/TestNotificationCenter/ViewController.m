//
//  ViewController.m
//  TestNotificationCenter
//
//  Created by Linsw on 2017/9/20.
//  Copyright © 2017年 Linsw. All rights reserved.
//

#import "ViewController.h"
#import "OB1.h"
#import "OB2.h"
#import "OB3.h"
#import "OB4.h"

@interface ViewController ()
@property (nonatomic,strong) OB1 *ob1;
@property (nonatomic,strong) OB2 *ob2;
@property (nonatomic,strong) OB3 *ob3;
@property (nonatomic,strong) OB4 *ob4;


@end
#define OBKEY @"obkey"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _ob1 = [[OB1 alloc] init];
    _ob2 = [[OB2 alloc] init];
    _ob4 = [[OB4 alloc] init];
    _ob3 = [[OB3 alloc] init];

    // Do any additional setup after loading the view, typically from a nib.
    [self.view addObserver:_ob1 forKeyPath:@"backgroundColor" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addObserver:_ob2 forKeyPath:@"backgroundColor" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addObserver:_ob4 forKeyPath:@"backgroundColor" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addObserver:_ob3 forKeyPath:@"backgroundColor" options:NSKeyValueObservingOptionNew context:nil];
//    2017-09-20 23:14:00.566 TestNotificationCenter[27488:2245876] Class:OB3 Method:observeValueForKeyPath:ofObject:change:context:
//    2017-09-20 23:14:00.566 TestNotificationCenter[27488:2245876] Class:OB4 Method:observeValueForKeyPath:ofObject:change:context:
//    2017-09-20 23:14:00.567 TestNotificationCenter[27488:2245876] Class:OB2 Method:observeValueForKeyPath:ofObject:change:context:
//    2017-09-20 23:14:00.567 TestNotificationCenter[27488:2245876] Class:OB1 Method:observeValueForKeyPath:ofObject:change:context:
    
    //kvo 观察者方法调用顺序和添加顺序相反
    [self.view setBackgroundColor:[UIColor redColor]];
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:_ob1 selector:@selector(ob) name:OBKEY object:nil];
    [center addObserver:_ob3 selector:@selector(ob) name:OBKEY object:nil];
    [center addObserver:_ob4 selector:@selector(ob) name:OBKEY object:nil];
    [center addObserver:_ob2 selector:@selector(ob) name:OBKEY object:nil];
//    2017-09-20 23:14:00.567 TestNotificationCenter[27488:2245876] Class:OB1 Method:ob
//    2017-09-20 23:14:00.568 TestNotificationCenter[27488:2245876] Class:OB3 Method:ob
//    2017-09-20 23:14:00.568 TestNotificationCenter[27488:2245876] Class:OB4 Method:ob
//    2017-09-20 23:14:00.568 TestNotificationCenter[27488:2245876] Class:OB2 Method:ob
    //notification center 观察者方法调用顺序和添加顺序一致
    [center postNotificationName:OBKEY object:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [self.view removeObserver:_ob1 forKeyPath:@"backgroundColor"];
    [self.view removeObserver:_ob2 forKeyPath:@"backgroundColor"];
    [self.view removeObserver:_ob3 forKeyPath:@"backgroundColor"];
    [self.view removeObserver:_ob4 forKeyPath:@"backgroundColor"];
    
}

@end
