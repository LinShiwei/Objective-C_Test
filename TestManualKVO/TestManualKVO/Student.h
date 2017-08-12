//
//  Student.h
//  TestManualKVO
//
//  Created by Lin,Shiwei on 2017/8/12.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject{
    NSString  *_age;
}
- (void)setAge:(NSString *)age;
- (NSString *)age;

@property (nonatomic, strong) NSString  *name;
@end
