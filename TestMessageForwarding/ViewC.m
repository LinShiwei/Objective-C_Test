//
//  ViewC.m
//  TestMessageForwarding
//
//  Created by Lin,Shiwei on 2017/8/15.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewC.h"
#import "define.h"
@implementation ViewC

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (void)initialize{
    
    ClassMethodCallLog(@"initialize");
}

+ (void)load{
    ClassMethodCallLog(@"load");
    
}

+ (void)printClassMethodC{
    ClassMethodCallLog(@"+ pintClassMethodC");
}

- (void)printC{
    ClassMethodCallLog(@"printC");
}

@end
