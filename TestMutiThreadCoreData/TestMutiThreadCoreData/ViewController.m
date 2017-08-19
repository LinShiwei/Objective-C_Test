//
//  ViewController.m
//  TestMutiThreadCoreData
//
//  Created by Lin,Shiwei on 2017/8/17.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    AppDelegate *dele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *con = dele.persistentContainer.viewContext;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
