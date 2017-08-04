//
//  ViewA.m
//  TestCopyProperty
//
//  Created by Lin,Shiwei on 2017/8/3.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewA.h"

@implementation ViewA{
//    __strong NSString *_strL;
}
//@dynamic strL;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



//- (NSString *)strL{
//    return _strL;
//}

- (void)changeStrL{
    int a  = 10;
    _strL = [NSMutableString stringWithFormat:@"%d",a];
    [_strL appendString:@"CC"];
    
    self.strL = [NSMutableString stringWithFormat:@"111%d111",a];

    [_strL appendString:@"AA"];
    
}

- (void)changeStrLWith:(NSMutableString *)str{
    _strL = str;
    [_strL appendString:@"BB"];
}


@end
