//
//  Person.m
//  TestMRC
//
//  Created by Lin,Shiwei on 2017/8/15.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "Person.h"
//ARC
@implementation Person
+ (instancetype)newPerson{
//    NSString *str = @"";
//    [str retainCount];
    return [[Person alloc] init];
}

+ (instancetype)somePerson{
    return [[Person alloc] init];
}
@end
