//
//  ViewController.m
//  TestUserDefault
//
//  Created by Lin,Shiwei on 2017/8/17.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setBool:false forKey:@"bool"];
    [def setBool:true forKey:@"bool2"];
    
    NSLog(@"%d,",[def boolForKey:@"bool"]);//0
    NSLog(@"%d,",[def boolForKey:@"bool2"]);//1
    NSLog(@"%d,",[def boolForKey:@"boolbool"]);//0
    
    NSLog(@"%@,",[def objectForKey:@"bool"]);//0
    NSLog(@"%@,",[def objectForKey:@"boolbool"]);//null



}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
