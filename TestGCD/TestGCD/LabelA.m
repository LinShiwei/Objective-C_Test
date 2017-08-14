//
//  LabelA.m
//  TestGCD
//
//  Created by Lin,Shiwei on 2017/8/14.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "LabelA.h"
@interface LabelA(){
    dispatch_queue_t _queue;
}
@end
@implementation LabelA
@synthesize str = _str;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        _queue = dispatch_queue_create("self.queue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}


//- (NSString *)str{
//    __block NSString *localStr;
//    dispatch_sync(_queue, ^{
//        localStr = _str;
//    });
//    return localStr;
//}
//
//- (void)setStr:(NSString *)str{
//    dispatch_async(_queue, ^{
//        if (str != _str) {
//            _str = str;
//        }
//    });
//}

@end
