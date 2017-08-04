//
//  ViewA.h
//  TestMessageForwarding
//
//  Created by Lin,Shiwei on 2017/7/27.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"
@interface ViewA : UIView{
    @public NSString *_aString;

}
- (instancetype)initWithForwardingTarget:(id)target;

- (void)testPolymorphic;
- (void)testOverride;

- (void)somtFunc;

@property (strong,nonatomic) NSString *str;
@property (strong,nonatomic) NSString *_strTest;
@end
