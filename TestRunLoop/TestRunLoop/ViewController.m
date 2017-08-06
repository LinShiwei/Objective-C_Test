//
//  ViewController.m
//  TestRunLoop
//
//  Created by Linsw on 2017/8/5.
//  Copyright © 2017年 Linsw. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,weak) NSString *string_weak;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    // 场景 1
//    
//    NSString *string = [NSString stringWithFormat:@"1234567890"];
//    
//    self.string_weak = string;
    
    //场景 2
    
    //        @autoreleasepool {
    
    //            NSString *string = [NSString stringWithFormat:@"1234567890"];
    
    //        _string_weak = string;
    
    //        }
    
    //    NSLog(@"string: %@",_string_weak);
    
    // 场景 3
    
    
    //        NSString *string = nil;
    
    //        @autoreleasepool {
    
    //            string = [NSString stringWithFormat:@”1234567890”];
    
    //
    
    //            _string_weak = string;
    
    //        }
    
    NSLog(@"string: %@",self.string_weak);
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSLog(@"string: %@", self.string_weak);
    
} 

- (void)viewDidAppear:(BOOL)animated { 
    
    [super viewDidAppear:animated]; 
    
    NSLog(@"string: %@", self.string_weak);
    
}


@end
