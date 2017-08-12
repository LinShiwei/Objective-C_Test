//
//  ViewController.m
//  Test_property
//
//  Created by Lin,Shiwei on 2017/8/12.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewController.h"
#import "ViewA.h"
@interface ViewController ()
@property (nonatomic,strong) ViewA *viewA;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //结论：在interface(){}大括号里声明的成员变量，如果以下划线开头的话，如“_bar“，那么使用setValue:forKey:中的key可以用"_bar"或"bar"。不论这个成员变量是否关联了属性。
    ///如：声明成员变量"_gaa"并声明属性"aag"用@synthesize aag = _gaa;
    ///这时候可以通过三个key来获取和设置这个属性／变量。这三个key是："_gaa","gaa","aag"。
    
    
    _viewA = [[ViewA alloc] init];
    [_viewA setValue:@"AA" forKey:@"str"];
    [_viewA setValue:@"CC" forKey:@"_foo"];
    NSLog(@"%@",_viewA.str);
    NSLog(@"%@",_viewA._foo);
    [_viewA setValue:@"bar" forKey:@"bar"];
    NSLog(@"%@",[_viewA valueForKey:@"bar"]);
    
    
    [_viewA setValue:@"_bar" forKey:@"_bar"];
    NSLog(@"%@",[_viewA valueForKey:@"_bar"]);
    
    [_viewA setValue:@"aaa" forKey:@"buzz"];
    NSLog(@"%@",[_viewA valueForKey:@"buzz"]);
    
//    [_viewA setValue:@"ccc" forKey:@"_buzz"];//doesn't work
//    NSLog(@"%@",[_viewA valueForKey:@"_buzz"]);
    
    
    //[_viewA setValue:@"BB" forKey:@"foo"];//doesn't work
    //Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<ViewA 0x7f8c2d406320> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key foo.'

    [_viewA setValue:@"BB" forKey:@"__foo"];//work
    NSLog(@"%@",_viewA._foo);
    
    
    [_viewA setValue:@"_gaa" forKey:@"_gaa"];
    NSLog(@"%@",[_viewA valueForKey:@"_gaa"]);
    
    [_viewA setValue:@"gaa" forKey:@"gaa"];
    NSLog(@"%@",[_viewA valueForKey:@"gaa"]);
    
    [_viewA setValue:@"aag" forKey:@"aag"];
    NSLog(@"%@",[_viewA valueForKey:@"aag"]);
    NSLog(@"%@",[_viewA valueForKey:@"gaa"]);
    NSLog(@"%@",[_viewA valueForKey:@"_gaa"]);
    [_viewA setValue:@"_aag" forKey:@"_aag"];//doesn't work



}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
