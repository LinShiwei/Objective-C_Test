//
//  ViewA+View_TestSuper.m
//  TestMessageForwarding
//
//  Created by Lin,Shiwei on 2017/8/2.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewA+View_TestSuper.h"

@implementation ViewA (View_TestSuper)

+ (void)load{
    ClassMethodCallLog(@"view_testSuper_load");
    
}

+ (void)initialize{
    ClassMethodCallLog(@"view_testSuper_initialize");

}

- (void)testSuper{
    NSString *str = [super description];
    NSLog(@"%@",str);
}
@end
