//
//  OB1.m
//  TestNotificationCenter
//
//  Created by Linsw on 2017/9/20.
//  Copyright © 2017年 Linsw. All rights reserved.
//

#import "OB1.h"
@implementation OB1

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    ClassMethodCallLog();
}

- (void)ob{
    ClassMethodCallLog();
    
}
@end
