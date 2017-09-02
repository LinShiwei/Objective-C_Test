//
//  ViewA.h
//  TestExternStatic
//
//  Created by Linsw on 2017/9/2.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import <UIKit/UIKit.h>
//用extern修饰的话，也需要import相应的头文件才能用。
//使用extern修饰声明变量，然后在m文件中定义变量的值，这样可以保护变量，当h文件暴露给开发者时，可以防止变量的值被修改。
extern NSString * const VAStr;


@interface ViewA : UIView

@end
