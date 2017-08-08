//
//  CustomLabel.m
//  TestRunLoop2
//
//  Created by Lin,Shiwei on 2017/8/6.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawTextInRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIImage* image = [UIImage imageNamed:@"sv.jpg"];
    CGContextDrawImage(context, rect, image.CGImage);
    [super drawTextInRect:rect];
}
@end
