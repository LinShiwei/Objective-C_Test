//
//  define.h
//  TestMessageForwarding
//
//  Created by Lin,Shiwei on 2017/7/27.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#ifndef define_h
#define define_h
#define ClassMethodCallLogWithMsg(_message) NSLog(@"Class:%@ Method:%@ Message:%@",[self class],NSStringFromSelector(_cmd),_message)
#define ClassMethodCallLog() NSLog(@"Class:%@ Method:%@",[self class],NSStringFromSelector(_cmd))

#endif /* define_h */
