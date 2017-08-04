//
//  ViewA.h
//  TestCopyProperty
//
//  Created by Lin,Shiwei on 2017/8/3.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewA : UIView
@property (nonatomic,copy) NSMutableString *strL;
@property (nonatomic,strong) NSMutableArray *arr;
- (void)changeStrL;
- (void)changeStrLWith:(NSMutableString *)str;

@end
