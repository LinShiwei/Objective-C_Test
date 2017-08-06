//
//  ContainProperty.h
//  TestProtpcol
//
//  Created by Linsw on 2017/8/5.
//  Copyright © 2017年 Linsw. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ContainProperty <NSObject>

//协议中可以声明属性，但是在遵循协议的类里面不会自动 @synthesize 关联实例变量

@property (nonatomic,copy) NSString *property;
//@required  协议中定义的默认是required的，显式表明@required好像并没有什么用。遵循协议的类即使没有实现required方法，编译的时候也不会报错。
//@optional 修饰的方法，如果不实现，编译器不会提示警告，同样，不实现却调用的话，运行时会抛出异常
- (void)protocolMethod;

@optional

-(void)protocolOptionalMethod;


@end
