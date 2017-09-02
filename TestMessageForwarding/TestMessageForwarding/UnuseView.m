//
//  UnuseView.m
//  TestMessageForwarding
//
//  Created by Lin,Shiwei on 2017/8/22.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "UnuseView.h"
#import "define.h"
@implementation UnuseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
/*
+ (void)load{
    ClassMethodCallLog(@"load");
}//只实现load的话，不管这个类是否用到，运行的时候都会调用load
//*/
+ (void)initialize{
    ClassMethodCallLog(@"initialize");

}//只实现initialize，不实现load的话，那么这个initialize会等到这个类接收到第一条消息才会执行。

@end
