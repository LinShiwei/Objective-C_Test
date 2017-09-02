//
//  ViewController.m
//  TestMessageForwarding
//
//  Created by Lin,Shiwei on 2017/7/27.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "ViewB.h"
#import "ViewSubA.h"
#import "ViewSubA1.h"
//#import "ViewA+View_TestSuper.h"
#import "ViewA.h"
#import "ViewC.h"
#import "UnuseView2.h"
@interface ViewController ()
@property (strong,nonatomic) ViewA *viewA;
@property (strong,nonatomic) ViewB *viewB;
@property (strong,nonatomic) ViewSubA *viewSubA;
@property (strong,nonatomic) ViewSubA1 *viewSubA1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *unv2 = [[UnuseView2 alloc] init];
    
    _viewB = [[ViewB alloc] init];

    _viewA = [[ViewA alloc] initWithForwardingTarget:_viewB];
    _viewSubA = [[ViewSubA alloc] initWithForwardingTarget:_viewB];
    _viewSubA1 = [[ViewSubA1 alloc] initWithForwardingTarget:_viewB];

//    id vA = _viewA;
//    [vA testPolymorphic];
//
//    [_viewA setValue:@"a" forKey:@"_strTest"];
//    [_viewA setValue:@"b" forKey:@"strTest"];
    [_viewA somtFunc];
    
    
    id vSubA = _viewSubA;
//    [vSubA printSomething];
//    [vSubA testPolymorphic];
//    
//    [vSubA printB];
    id vAClass = [ViewA class];
    [vAClass printClassMethodB];
    
    [vSubA printClassMethodB];
//    [vSubA printClassMethodC];
    
    [[_viewB class] printClassMethodB];

    id vClassA = [_viewA class];
    [vClassA printClassMethodB];

    
    id vSubA1 = _viewSubA1;
    [vSubA1 testPolymorphic];
//    BOOL res = [vSubA1 respondsToSelector:@selector(testPolymorphic)];
//
//    [_viewA setValue:@"aaa" forKey:@"lswDescription"];
//    [_viewA testSuper];
    
    _viewA->_aString = @"";
    _viewA.str = @"";
    [_viewA testOverride];
    
    unsigned int count = 0 ;
    Method *methodList = class_copyMethodList(objc_getClass("ViewA"), &count);
    
    NSMutableArray<NSString *> *methodArray = [NSMutableArray array];
    for (int i = 0; i<count; i++) {
        NSString *name = NSStringFromSelector(method_getName(methodList[i]));
        [methodArray addObject:name];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
