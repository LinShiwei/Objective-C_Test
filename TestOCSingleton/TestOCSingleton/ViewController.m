//
//  ViewController.m
//  TestOCSingleton
//
//  Created by Lin,Shiwei on 2017/8/4.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewController.h"
#import "SimpleSingleton.h"
#import "PrefectSingleton.h"

@interface ViewController ()
@property (nonatomic,copy) SimpleSingleton *simple;
@property (nonatomic,copy) SimpleSingleton *simpleCopy;
@property (nonatomic,strong) PrefectSingleton *prefect;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _simple = [SimpleSingleton sharedSimpleSingleton];
//    self.simple = [SimpleSingleton sharedSimpleSingleton];
    NSLog(@"%@",_simple);
    
//    _simpleCopy = [_simple copy]; //NSObject 不遵循NSCopying
    
    _simpleCopy = [[SimpleSingleton alloc] init];
    NSLog(@"%@",_simpleCopy);

    _prefect = [PrefectSingleton sharedPrefectSingleton];
    
    PrefectSingleton *p1,*p2,*p3;
    p1 = [_prefect copy];
    p2 = [_prefect mutableCopy];
    p3 = [[PrefectSingleton alloc] init];
    
    NSLog(@"%@",_prefect);
    NSLog(@"%@",p1);
    NSLog(@"%@",p2);
    NSLog(@"%@",p3);


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
