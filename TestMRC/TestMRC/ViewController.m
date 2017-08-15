//
//  ViewController.m
//  TestMRC
//
//  Created by Lin,Shiwei on 2017/8/2.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "MRCPerson.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)loadView{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Person *p1 = [Person newPerson];
    Person *p2 = [Person somePerson];
    NSLog(@"%@",p1.description);
    NSLog(@"%@",p2.description);

    [p1 release];
    
    MRCPerson *mp1 = [MRCPerson newPerson];
    MRCPerson *mp2 = [MRCPerson somePerson];
    NSLog(@"%@",mp1.description);
    NSLog(@"%@",mp2.description);
    
    [mp1 release];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
