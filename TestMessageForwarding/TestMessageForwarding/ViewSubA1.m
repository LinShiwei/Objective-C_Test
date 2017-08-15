//
//  ViewSubA1.m
//  TestMessageForwarding
//
//  Created by Lin,Shiwei on 2017/8/1.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewSubA1.h"
#import "define.h"
@implementation ViewSubA1

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

- (void)testPolymorphic{
    ClassMethodCallLog(@"testPolymorphic");
//    nil
//    NULL
//    Nil
    
    
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    NSString *str = NSStringFromSelector(aSelector);
    if ([str isEqualToString:@"testPolymorphic"]) {
        return false;
    }
    return [super respondsToSelector:aSelector];
}
@end
