//
//  ViewB.h
//  TestMessageForwarding
//
//  Created by Lin,Shiwei on 2017/7/27.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"
@interface ViewB : UIView
- (void)printSomething;
- (void)printB;

+ (void)printClassMethodB;
+ (void)printClassMethodBMock;
@end
