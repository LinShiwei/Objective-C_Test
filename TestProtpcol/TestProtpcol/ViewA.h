//
//  ViewA.h
//  TestProtpcol
//
//  Created by Linsw on 2017/8/5.
//  Copyright © 2017年 Linsw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContainProperty.h"
@interface ViewA : NSObject<ContainProperty>


- (id)quickInit;
- (void)printProperty;

@end
