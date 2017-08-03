//
//  ViewSubA.m
//  TestMessageForwarding
//
//  Created by Lin,Shiwei on 2017/7/27.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewSubA.h"

@implementation ViewSubA

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (void)load{
    ClassMethodCallLog(@"load");

}

+ (void)initialize{
//    [super initialize];不需要再调用super 的方法，会造成重复调用。

    ClassMethodCallLog(@"initialize");

}

- (void)testPolymorphic{
    ClassMethodCallLog(@"testPolymorphic");
    _aString = @"aa";
    self.str = @"aaaa";
    
}

@end
