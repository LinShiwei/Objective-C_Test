//
//  SubUnuseView2.m
//  TestMessageForwarding
//
//  Created by Linsw on 2017/9/2.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "SubUnuseView2.h"

@implementation SubUnuseView2

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
// 没有实现load方法的话，不管父类是否实现load，都不会自动在本类调用父类的方法。
// 运行的时候：
//  2017-09-02 16:33:20.579 TestMessageForwarding[43810:2608150] UnuseView2 load call
// 是由于父类中实现了load，所以父类自身初始化的时候调用load，而不是子类初始化的时候调用父类的load
//
//  而对于initialize，如果子类没实现，而父类实现了，那么子类在初始化的时候，会在子类调用父类的initialize
@end
