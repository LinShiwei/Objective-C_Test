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
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*2);
    
}


@end
