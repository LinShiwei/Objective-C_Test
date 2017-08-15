//
//  MRCPerson.m
//  TestMRC
//
//  Created by Lin,Shiwei on 2017/8/15.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "MRCPerson.h"

@implementation MRCPerson
+ (instancetype)newPerson{
    NSString *str = @"";
    [str retainCount];
    return [[MRCPerson alloc] init];
}

+ (instancetype)somePerson{
    return [[[MRCPerson alloc] init] autorelease];
}
@end
